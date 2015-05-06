class ItemsController < ApplicationController
  before_action :check_login
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  authorize_resource

  def index
    @no_items = Item.all.empty?
    @show_active = !(params[:show_inactive] == 'true')
    if is_admin?
      if @show_active
        @items = Item.active.alphabetical.paginate(:page => params[:page]).per_page(10)
      else
        @items = Item.inactive.alphabetical.paginate(:page => params[:page]).per_page(10)
      end
    else
      @items = Item.active.alphabetical.paginate(:page => params[:page]).per_page(10)
    end
  end

  def show
    if is_admin?
      @price_history = ItemPrice.for_item(@item).chronological
    else
      @similar_items = Item.active.for_category(@item.category).alphabetical.reject{|item| item.id == @item.id}
    end
  end

  def new
    @item = Item.new
    @item.new_price = 3.50  # Default price so cucumber test can pass.
  end

  def edit
    @item.new_price = @item.current_price
  end

  def create
    @item = Item.new(item_params)
    check_new_price
    if @item.errors.empty? && @item.save
      create_item_price
      redirect_to item_path(@item), notice: "#{@item.name} was added to the system"
    else
      render action: 'new'
    end
  end

  def update
    check_new_price
    if @item.errors.empty? && @item.update(item_params)
      create_item_price unless params[:item][:new_price].to_f == @item.current_price
      redirect_to @item, notice: "The item was revised in the system."
    else
      render action: 'edit'
    end
  end

  def destroy
    @item.destroy
    redirect_to items_path, notice: "The item was successfully deleted or made inactive."
  end

  private
  def set_item
    @item = Item.find(params[:id])
  end

  # Sort of a hacky way to change price with item instead of a nested attribute.
  def check_new_price
    begin
      new_price = Float(params[:item][:new_price])
      add_price_error if new_price < 0
    rescue
      add_price_error
    end
  end

  def add_price_error
    @item.errors.add(:new_price, "must be a valid price (no dollar signs)")
  end

  def create_item_price
    @ip = ItemPrice.new(price: params[:item][:new_price], start_date: Date.today, end_date: "", item_id: @item.id)
    @ip.save
  end

  def item_params
    params.require(:item).permit(:name, :description, :category, :picture, :units_per_item, :weight, :active, :new_price)
  end

end
