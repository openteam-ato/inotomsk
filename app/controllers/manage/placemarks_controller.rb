class Manage::PlacemarksController < Manage::ApplicationController
  def new
    add_breadcrumb 'Карта', manage_map_layers_path
    add_breadcrumb 'Новая метка', new_manage_placemark_path

    @placemark = Placemark.new
  end

  def create
    add_breadcrumb 'Карта', manage_map_layers_path
    add_breadcrumb 'Новая метка', new_manage_placemark_path

    @placemark = Placemark.new(params[:placemark])

    if @placemark.save
      create_addresses
      redirect_to manage_map_layers_path
    else
      render :new
    end
  end

  def edit
    @placemark = Placemark.find(params[:id])

    add_breadcrumb 'Карта', manage_map_layers_path
    add_breadcrumb 'Редактировать', edit_manage_placemark_path(@placemark)
  end

  def update
    @placemark = Placemark.find(params[:id])

    add_breadcrumb 'Карта', manage_map_layers_path
    add_breadcrumb 'Редактировать', edit_manage_placemark_path(@placemark)

    if @placemark.update_attributes(params[:placemark])
      create_addresses
      redirect_to manage_map_layers_path
    else
      render :edit
    end
  end

  def destroy
    Placemark.find(params[:id]).destroy
    redirect_to manage_map_layers_path
  end

  private

  def zip_coords
    params[:placemark][:address][:latitude].zip params[:placemark][:address][:longitude]
  end

  def create_addresses
    @placemark.addresses.destroy_all
    zip_coords.each do |lat, lon|
      @placemark.addresses.create(latitude: lat, longitude: lon)
    end
  end
end
