class ShelterPetsController < ApplicationController
  def index
    @pets = Shelter.find(params[:id]).pets
  end
end
