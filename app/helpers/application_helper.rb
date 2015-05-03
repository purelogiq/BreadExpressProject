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

  # Formats phone number as: DDD-DDD-DDDD
  def format_phone num
    num.insert(3, '-').insert(7, '-')
  end

  # Formats address as: Street_1, [Street 2, ]City, State Zip
  def format_address_plain addr
    street_2 = (addr.street_2 == nil || addr.street_2 == "") ? "" : (addr.street_2 + "<br />")
    "#{addr.street_1}<br />#{street_2}#{addr.city}, #{addr.state} #{addr.zip}"
  end

  # Formats date as: mm/dd/yy
  def format_date date
    date.strftime('%m/%d/%y')
  end

  # Formats price with $ in from and 2 required decimals.
  def format_price price
    "$#{'%.2f' % price}"
  end
end
