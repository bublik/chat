module LocationsHelper

  def show_map(location = nil)
    return unless location
    image_tag("http://maps.google.com/maps/api/staticmap?size=250x250&sensor=false&zoom=10&markers=#{location.latitude}%2C#{location.longitude}",
              class: 'round h250',
              style: 'margin-left: -32px')
  end

end
