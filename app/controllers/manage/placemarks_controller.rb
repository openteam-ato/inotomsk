class Manage::PlacemarksController < Manage::ApplicationController
  def new
    add_breadcrumb "Карта", manage_map_layers_path
    add_breadcrumb "Новая метка", new_manage_placemark_path

    @placemark = Placemark.new
    @map_layers = MapLayer.roots
  end

  def create
    add_breadcrumb "Карта", manage_map_layers_path
    add_breadcrumb "Новая метка", new_manage_placemark_path

    @placemark = Placemark.new(params[:placemark])
    @map_layers = MapLayer.roots

    if @placemark.save
      redirect_to manage_map_layers_path
    else
      render :new
    end
  end

  def edit
    @placemark = Placemark.find(params[:id])
    @map_layers = MapLayer.roots

    add_breadcrumb "Карта", manage_map_layers_path
    add_breadcrumb "Редактировать", edit_manage_placemark_path(@placemark)
  end

  def update
    @placemark = Placemark.find(params[:id])
    @map_layers = MapLayer.roots

    add_breadcrumb "Карта", manage_map_layers_path
    add_breadcrumb "Редактировать", edit_manage_placemark_path(@placemark)

    if @placemark.update_attributes(params[:placemark])
      redirect_to manage_map_layers_path
    else
      render :new
    end
  end

  def destroy
    Placemark.find(params[:id]).destroy
    redirect_to manage_map_layers_path
  end
end
