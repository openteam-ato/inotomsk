module Manage::ManageHelper
  def map_layers
    return MapLayer.all unless params[:map_layer]
    MapLayer.find(:params[:map_layer])
  end

  def highlight_layer(map_layer = nil)
    'active' if map_layer.nil? && params[:map_layer].nil?
    map_layer.try(:slug) == params[:map_layer] ? 'active layer' : 'layer'
  end
end
