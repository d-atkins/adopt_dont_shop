require 'rails_helper'

RSpec.describe "As a visitor:" do
  describe "from the pets index page" do
    before :each do
      @dog_city = Shelter.create!(
        name: "Dog City",
        address: "1923 Dog Ln",
        city: "Doggington",
        state: "CO",
        zip: "80414")
      @pet_1 = Pet.create(
        image: "https://i.pinimg.com/originals/a9/cf/64/a9cf6473ca327409108ab02d15cc06b0.jpg",
        name: "Snoopy",
        description: "beagle pup eh",
        approximate_age: "6 months old",
        sex: "male",
        shelter: @dog_city)
      @pet_2 = Pet.create(
        image: "https://upload.wikimedia.org/wikipedia/commons/2/2b/WelshCorgi.jpeg",
        name: "Nana",
        description: "super cute dog in need of home",
        approximate_age: "4 years old",
        sex: "female",
        status: "pending",
        shelter: @dog_city)
      @pet_3 = Pet.create!(
        image: "https://cdn.mos.cms.futurecdn.net/g8PyY6xAhcndpQLLSkdPf-320-80.jpg",
        name: "Capy'n Hook",
        description: "dread of the seven seas",
        approximate_age: "400 years old?",
        sex: "male",
        shelter: @dog_city)
      visit "/shelters/#{@dog_city.id}/pets"
      visit '/pets'
    end

    it "I can see a list of all pets and their information" do
      within("#pet-#{@pet_1.id}") do
        expect(page).to have_css("img[src*='#{@pet_1.image}']")
        expect(page).to have_content(@pet_1.name)
        expect(page).to have_content(@pet_1.approximate_age)
        expect(page).to have_content(@pet_1.sex)
        expect(page).to have_content(@pet_1.shelter.name)
      end

      within("#pet-#{@pet_2.id}") do
        expect(page).to have_css("img[src*='#{@pet_2.image}']")
        expect(page).to have_content(@pet_2.name)
        expect(page).to have_content(@pet_2.approximate_age)
        expect(page).to have_content(@pet_2.sex)
        expect(page).to have_content(@pet_2.shelter.name)
      end
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

    it "I can click a shelter name to get to its shelter show page" do
      within("#pet-#{@pet_1.id}") { click_link(@dog_city.name) }

      expect(current_path).to eq("/shelters/#{@dog_city.id}")
    end

    it "I can click a pet name to get to its pet show page" do
      within("#pet-#{@pet_1.id}") { click_link(@pet_1.name) }

      expect(current_path).to eq("/pets/#{@pet_1.id}")
    end

    it "I see adoptable pets listed before pending pets" do
      expected_matches = ["Snoopy", "Capy'n Hook", "Nana"].zip(page.all(".card"))
      expected_matches.each { |name, div| expect(div).to have_content(name) }
    end
  end
end
