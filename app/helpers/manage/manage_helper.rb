module Manage::ManageHelper
  def highlight_layer(map_layer = nil)
    'active' if map_layer.nil? && params[:map_layer].nil?
    map_layer.try(:slug) == params[:map_layer] ? 'active layer show_children' : 'layer'
  end

  def layer_icon(map_layer, icon_type = '')
    map_layer.send("#{icon_type}icon_url") || asset_path("#{icon_type}default.png")
  end

  def placemark_logotype(placemark)
    placemark.logotype_url || asset_path("symbol.png")
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
      options << "<option class='root_option' value='#{root.id}' #{selected_option(context, root)} >#{root.title}</option>"
      root.children.each do |child|
        options << "<option value='#{child.id}' #{selected_option(context, child)} >#{child.title}</option>"
      end
    end
    options.html_safe
  end

  def human_term(event)
    if event.term_type == 'quarter'
      "#{event.quarter} #{I18n.t('time_period.quarter')} #{event.end_year}"
    elsif event.term_type == 'period' && event.start_year != event.end_year
      "#{I18n.t('time_period.annually')} (#{event.start_year} - #{event.end_year})"
    else
      "#{event.start_year}"
    end
  end

  def event_row_color(event)
    case event.state
    when "implemented"
      "success"
    when "now"
      "info"
    when "postponed"
      "warning"
    end
  end

  def selected_filter(filter, param_name)
    return 'active' if filter == "all" && !params[param_name]
    'active' if params[param_name] == filter
  end

  def invitations_active_scope(filter)
    return "primary" if filter == params[:scope]
    return "primary" if params[:scope].blank? && filter == "created_by_invite"
    "default"
  end
end
