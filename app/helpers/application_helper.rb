module ApplicationHelper
  def get_address_options(user=nil)
    if user.nil? || user.role?(:admin)
      addresses = Address.active.by_recipient.to_a
    else
      addresses = user.customer.addresses.by_recipient.to_a
    end
    addresses.map{|addr| ["#{addr.recipient} : #{addr.street_1}", addr.id] }
  end

  def safe_picture_url(picture)
    return image_path 'orders_card.jpg' if picture.nil? || picture == ""
    return picture if picture =~ /\Ahttps?:\/\//
    image_path picture
  end

end
