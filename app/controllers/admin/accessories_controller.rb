class Admin::AccessoriesController < Admin::BaseController
  def index
    @accessories = Accessory.all
  end

  def edit
    @accessory = Accessory.find(params[:id])
  end

  def update
    @accessory = Accessory.find(params[:id])
    if @accessory.update(accessory_params)
      flash[:notice] = "#{@accessory.title} updated."
      redirect_to accessory_path(@accessory)
    else
      flash[:error] = 'Something went wrong.'
      render :edit
    end
  end

  private

  def accessory_params
    params.require(:accessory).permit(:title, :description, :price, :image_file_name, :role)
  end
end
