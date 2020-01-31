class ShelterPetsController < ApplicationController
  def index
    @pets = Shelter.find(params[:id]).pets
    @shelter = Shelter.find(params[:id])
  end

  def new
    @shelter = Shelter.find(params[:id])
  end

  def create
    shelter = Shelter.find(params[:id])
    shelter.pets.create(pet_params)

    redirect_to "/shelters/#{shelter.id}/pets"
  end

  private

    def pet_params
      params.permit(:image_path, :name, :description, :approximate_age, :sex)
    end
end
