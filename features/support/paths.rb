module NavigationHelpers
  def path_to(page_name)
    case page_name
    # basic semi-static pages
    when /the home\s?page/
      '/'
    when /the About Us\s?page/
      about_path
    when /the Contact Us\s?page/
      contact_path
    when /the Privacy\s?page/
      privacy_path

    # customer paths
    when /the customers\s?page/ 
      customers_path
    when /Alex Egan details\s?page/
      customer_path(@alexe)
    when /edit Melanie's\s?record/
      edit_customer_path(@melanie) 
    when /the new customer\s?page/
      new_customer_path

    # address paths
    when /the addresses\s?page/ 
      addresses_path
    when /the new address\s?page/
      new_address_path
    when /edit Melanie's\s?address/
      edit_address_path(@melanie_a1)

    # order paths
    when /the orders\s?page/ 
      orders_path
    when /Valentine's Day order/
      order_path(@alexe_o1)
    when /the new order\s?page/
      new_order_path

    # item paths
    when /the items\s?page/ 
      items_path
    when /Challah Bread details\s?page/
      item_path(@challah)
    when /the new item\s?page/
      new_item_path

    # user paths
    when /the login page/
      login_path 

    # else 'catch-all'
    else
      begin
        page_name =~ /the (.*) page/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue Object => e
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)