class Admin::AccessoriesController < Admin::BaseController
  def index
    @accessories = Accessory.all
  end

  def new
    @accessory = Accessory.new
  end

  def create
    @accessory = Accessory.new(accessory_params)
    title = accessory_params[:title]
    if @accessory.save(accessory_params)
      flash[:success] = "#{@accessory.title} Added!"
      redirect_to accessory_path(@accessory)
    else
      flash[:error] = "#{title} not added."
      render :new
    end
  end

  def edit
    @accessory = Accessory.find(params[:id])
  end

  def update
    @accessory = Accessory.find(params[:id])
    if @accessory.update(accessory_params)
      flash[:success] = "#{@accessory.title} updated."
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
