class Admin::AccessoriesController < Admin::BaseController
  def index
    @accessories = Accessory.all
  end

  def edit
    @accessory = Accessory.find(params[:id])
  end

  def update
    accessory = Accessory.find(params[:id])
    accessory.update(accessory_params)
    redirect_to accessory_path(accessory)
  end

  private

  def accessory_params
    params.require(:accessory).permit(:title, :description, :price, :image_file_name, :role)
  end
end
