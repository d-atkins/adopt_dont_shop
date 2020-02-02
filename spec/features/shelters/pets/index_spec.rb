require 'rails_helper'

RSpec.describe "As a visitor: " do
  describe "from the shelter/pets index" do
    before :each do
      @dog_city = Shelter.create!(
        name: "Dog City",
        address: "1923 Dog Ln",
        city: "Doggington",
        state: "CO",
        zip: "80414")
      @cdp = Shelter.create!(
        name: "Cool Dogs Palace",
        address: "89123 Cool St",
        city: "Cool City",
        state: "Coolorado",
        zip: "88888")
      @pet_1 = Pet.create!(
        image_path: "https://i.pinimg.com/originals/a9/cf/64/a9cf6473ca327409108ab02d15cc06b0.jpg",
        name: "Snoopy",
        description: "beagle pup eh",
        approximate_age: "6 months old",
        sex: "male",
        shelter: @dog_city,
        status: "adoptable")
      @pet_2 = Pet.create!(
        image_path: "https://upload.wikimedia.org/wikipedia/commons/2/2b/WelshCorgi.jpeg",
        name: "Nana",
        description: "super cute dog in need of home",
        approximate_age: "4 years old",
        sex: "female",
        shelter: @dog_city,
        status: "adoptable")
      @pet_3 = Pet.create!(
        image_path: "https://cdn.mos.cms.futurecdn.net/g8PyY6xAhcndpQLLSkdPf-320-80.jpg",
        name: "Capy'n Hook",
        description: "dread of the seven seas",
        approximate_age: "400 years old?",
        sex: "male",
        shelter: @cdp,
        status: "adoptable")
      visit "/shelters/#{@dog_city.id}/pets"
    end

    it "I can see each pet that can be adopted from that shelter" do
      within("#pet-#{@pet_1.id}") do
        expect(page).to have_css("img[src*='#{@pet_1.image_path}']")
        expect(page).to have_content(@pet_1.name)
        expect(page).to have_content(@pet_1.approximate_age)
        expect(page).to have_content(@pet_1.sex)
      end

      within("#pet-#{@pet_2.id}") do
        expect(page).to have_css("img[src*='#{@pet_2.image_path}']")
        expect(page).to have_content(@pet_2.name)
        expect(page).to have_content(@pet_2.approximate_age)
        expect(page).to have_content(@pet_2.sex)
      end

      expect(page).to_not have_css("img[src*='#{@pet_3.image_path}']")
      expect(page).to_not have_content(@pet_3.name)
      expect(page).to_not have_content(@pet_3.approximate_age)
      expect(page).to_not have_content(@pet_3.shelter.name)
    end

    it "I can get to the edit page of a pet" do
      within("#pet-#{@pet_1.id}") { click_link("Update Pet") }

      expect(current_path).to eq("/pets/#{@pet_1.id}/edit")
    end

    it "I can delete a pet" do
      within("#pet-#{@pet_1.id}") { click_link("Delete Pet") }

      expect(current_path).to eq("/pets")
      expect(page).to_not have_content(@pet_1.name)
    end

    it "I can click a shelter name to get to its show page" do
      click_link(@dog_city.name)

      expect(current_path).to eq("/shelters/#{@dog_city.id}")
    end

    it "I can click a pet name to get to its show page" do
      within("#pet-#{@pet_1.id}") { click_link(@pet_1.name) }

      expect(current_path).to eq("/pets/#{@pet_1.id}")
    end
  end
end
