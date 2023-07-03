class PlantsController < ApplicationController
  wrap_parameters format: []
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  # GET /plants
  def index
    plants = Plant.all
    render json: plants
  end

  # GET /plants/:id
  def show
    plant = Plant.find_by(id: params[:id])
    render json: plant
  end

  
  # POST /plants
  def create
    plant = Plant.create(plant_params)
    render json: plant, status: :created
  end


  #DELETE /plants/:id
  def destroy
    plant = find_plant
    plant.destroy
    head :no_content
  end


  #PATCH /plants/:id
  def update
    plant = find_plant
    plant.update(plant_params)
    render json: plant, status: :ok
  end

  private

  def plant_params
    params.permit(:name, :image, :price, :is_in_stock)
  end

  def find_plant
    Plant.find(params[:id])
  end

  def record_not_found
    render json: {error: "Plant not found"}, status: :not_found
  end
  
end
