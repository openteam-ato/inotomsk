module Manage::ManageHelper
  def highlight_layer(map_layer = nil)
    'active' if map_layer.nil? && params[:map_layer].nil?
    map_layer.try(:slug) == params[:map_layer] ? 'active layer' : 'layer'
  end

  def layer_icon(map_layer, icon_type = '')
    map_layer.send("#{icon_type}icon_url") || "#{icon_type}default.png"
  end

  def placemark_logotype(placemark)
    placemark.logotype_url || "symbol.png"
  end

  def address(placemark)
    return placemark.address if placemark.address
    "Координаты: #{placemark.latitude.round(4)}/#{placemark.longitude.round(4)}"
  end

  def permissions_role
    Permission.available_roles.map{ |role| [I18n.t("role.#{role}"), role] }
  end

  def selected_option(placemark, map_layer)
    map_layer == placemark.map_layer ? 'selected' : ''
  end
end
