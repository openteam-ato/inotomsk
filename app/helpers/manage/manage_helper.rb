module Manage::ManageHelper
  def highlight_layer(map_layer = nil)
    'active' if map_layer.nil? && params[:map_layer].nil?
    map_layer.try(:slug) == params[:map_layer] ? 'active layer' : 'layer'
  end

  def layer_icon(map_layer, icon_type = '')
    map_layer.send("#{icon_type}icon_url") || asset_path("#{icon_type}default.png")
  end

  def placemark_logotype(placemark)
    placemark.logotype_url || asset_path("symbol.png")
  end

  def address(placemark)
    return placemark.address if placemark.address
    "Координаты: #{placemark.latitude.round(4)}/#{placemark.longitude.round(4)}"
  end

  def permissions_role
    Permission.available_roles.map{ |role| [I18n.t("role.#{role}"), role] }
  end

  def opened_children_list?(map_layer)
    map_layer.children.map(&:slug).include?(params[:map_layer])
  end

  def selected_option(context, map_layer)
    map_layer == context.map_layer ? 'selected' : ''
  end

  def custom_map_layer_select_options(context)
    options = "<option></option>"
    MapLayer.roots.each do |root|
      options << "<option class='root_option'>#{root.title}</option>"
      root.children.each do |child|
        options << "<option value='#{child.id}' #{selected_option(context, child)} >#{child.title}</option>"
      end
    end
    options.html_safe
  end

  def human_term(event)
    if event.term_type == 'quarter'
      "#{event.quarter} квартал #{event.end_year} г."
    elsif event.term_type == 'period' && event.start_year != event.end_year
      "ежегодно (#{event.start_year} - #{event.end_year} годы)"
    else
      "#{event.start_year} г."
    end
  end
end
