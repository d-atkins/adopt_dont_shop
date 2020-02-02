class ShelterPetsController < ApplicationController
  def index
    @pets = Shelter.find(params[:shelter_id]).pets
    @shelter = Shelter.find(params[:shelter_id])
  end

  def new
    @shelter_id = params[:shelter_id]
  end

  def create
    Pet.create(pet_params)

    redirect_to "/shelters/#{params[:shelter_id]}/pets"
  end

  private

    def pet_params
      params.permit(:image, :name, :description, :approximate_age, :sex, :shelter_id)
    end
end
