class CitiesController < ApplicationController
  def get_cities_by_state
    @cities = City.where("state_id = ?", params[:state_id])
    @field_id = params[:input_id]
  end

  def list
    cities = City.where(state_id: params[:state_id])

    render json: cities
  end

  def get_by_name
    @cidades = City.where('lower(name) LIKE ?', "%#{params[:term].downcase}%")
    render json: @cidades
  end

end
