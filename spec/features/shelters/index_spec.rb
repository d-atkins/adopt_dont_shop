require 'rails_helper'

RSpec.describe "As a visitor: " do
  describe "from the shelters index page" do
    it "I can see names of all of the shelters" do
      shelter_1 = Shelter.create!(
        name: "Shelter A",
        address: "123 Fake St",
        city: "Las Vegas",
        state: "WY",
        zip: "12345")
      shelter_2 = Shelter.create!(
        name: "Dog City",
        address: "1923 Dog Ln",
        city: "Doggington",
        state: "CO",
        zip: "80414")

      visit "/shelters"

      expect(page).to have_content(shelter_1.name)
      expect(page).to have_content(shelter_2.name)
    end
    it "I can get to the edit page of a shelter" do
      shelter_1 = Shelter.create!(
        name: "Shelter A",
        address: "123 Fake St",
        city: "Las Vegas",
        state: "WY",
        zip: "12345")
      Shelter.create!(
        name: "Dog City",
        address: "1923 Dog Ln",
        city: "Doggington",
        state: "CO",
        zip: "80414")

      visit "/shelters"

      click_link("Update Shelter", match: :first)

      expect(current_path).to eq("/shelters/#{shelter_1.id}/edit")
    end
    it "I can delete a shelter" do
      shelter_1 = Shelter.create!(
        name: "Shelter A",
        address: "123 Fake St",
        city: "Las Vegas",
        state: "WY",
        zip: "12345")
      Shelter.create!(
        name: "Dog City",
        address: "1923 Dog Ln",
        city: "Doggington",
        state: "CO",
        zip: "80414")
      Pet.create(
        image_path: "https://i.pinimg.com/originals/a9/cf/64/a9cf6473ca327409108ab02d15cc06b0.jpg",
        name: "Snoopy",
        description: "beagle pup eh",
        approximate_age: "6 months old",
        sex: "male",
        shelter: shelter_1,
        status: "adoptable")

      visit "/shelters"

      click_link("Delete Shelter", match: :first)

      expect(current_path).to eq("/shelters")
      expect(page).to_not have_content(shelter_1.name)
    end
    it "I can click a shelter name to get to its show page" do
      dog_city = Shelter.create!(
        name: "Dog City",
        address: "1923 Dog Ln",
        city: "Doggington",
        state: "CO",
        zip: "80414")
      Pet.create(
        image_path: "https://i.pinimg.com/originals/a9/cf/64/a9cf6473ca327409108ab02d15cc06b0.jpg",
        name: "Snoopy",
        description: "beagle pup eh",
        approximate_age: "6 months old",
        sex: "male",
        shelter: dog_city,
        status: "adoptable")

      visit "/shelters"

      click_link(dog_city.name, match: :first)

      expect(current_path).to eq("/shelters/#{dog_city.id}")
    end
  end
end
