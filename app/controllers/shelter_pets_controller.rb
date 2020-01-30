class ShelterPetsController < ApplicationController
  def index
    @pets = Shelter.find(params[:id]).pets
    @shelter = Shelter.find(params[:id])
  end
end
