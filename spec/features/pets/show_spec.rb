require 'rails_helper'

RSpec.describe "As a visitor: " do
  describe "from the pet show page" do
    it "I can see the info of the pet" do
      dog_city = Shelter.create!(
        name: "Dog City",
        address: "1923 Dog Ln",
        city: "Doggington",
        state: "CO",
        zip: "80414")
      pet_1 = Pet.create(
        image_path: "https://i.pinimg.com/originals/a9/cf/64/a9cf6473ca327409108ab02d15cc06b0.jpg",
        name: "Snoopy",
        description: "beagle pup eh",
        approximate_age: "6 months old",
        sex: "male",
        shelter: dog_city,
        status: "adoptable")
      pet_2 = Pet.create(
        image_path: "https://upload.wikimedia.org/wikipedia/commons/2/2b/WelshCorgi.jpeg",
        name: "Nana",
        description: "super cute dog in need of home",
        approximate_age: "4 years old",
        sex: "female",
        shelter: dog_city,
        status: "adoptable")

      visit "pets/#{pet_1.id}"

      expect(page).to have_css("img[src*='#{pet_1.image_path}']")
      expect(page).to have_content("Name: #{pet_1.name}", count: 1)
      expect(page).to have_content("Description: #{pet_1.description}", count: 1)
      expect(page).to have_content("Approximate age: #{pet_1.approximate_age}", count: 1)
      expect(page).to have_content("Sex: #{pet_1.sex}", count: 1)
      expect(page).to have_content("Status: #{pet_1.status}", count: 1)
      
      expect(page).to_not have_content(pet_2.name)
      expect(page).to_not have_content(pet_2.description)
      expect(page).to_not have_content(pet_2.approximate_age)
      expect(page).to_not have_content(pet_2.sex)
    end
  end
end
