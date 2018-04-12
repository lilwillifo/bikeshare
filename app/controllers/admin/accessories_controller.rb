class Admin::AccessoriesController < Admin::BaseController
  def index
    @accessories = Accessory.all
  end
end
