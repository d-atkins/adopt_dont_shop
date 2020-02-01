require 'rails_helper'

RSpec.describe "As a visitor: " do
  describe "from the pets index page" do
    before :each do
      @dog_city = Shelter.create!(
        name: "Dog City",
        address: "1923 Dog Ln",
        city: "Doggington",
        state: "CO",
        zip: "80414")
      @pet_1 = Pet.create(
        image_path: "https://i.pinimg.com/originals/a9/cf/64/a9cf6473ca327409108ab02d15cc06b0.jpg",
        name: "Snoopy",
        description: "beagle pup eh",
        approximate_age: "6 months old",
        sex: "male",
        shelter: @dog_city,
        status: "adoptable")
      @pet_2 = Pet.create(
        image_path: "https://upload.wikimedia.org/wikipedia/commons/2/2b/WelshCorgi.jpeg",
        name: "Nana",
        description: "super cute dog in need of home",
        approximate_age: "4 years old",
        sex: "female",
        shelter: @dog_city,
        status: "adoptable")
      visit '/pets'
    end

    it "I can see a list of all pets and their information" do
      expect(page).to have_css("img[src*='#{@pet_1.image_path}']")
      expect(page).to have_content(@pet_1.name)
      expect(page).to have_content(@pet_1.approximate_age)
      expect(page).to have_content(@pet_1.sex)
      expect(page).to have_content(@pet_1.shelter.name)

      expect(page).to have_css("img[src*='#{@pet_2.image_path}']")
      expect(page).to have_content(@pet_2.name)
      expect(page).to have_content(@pet_2.approximate_age)
      expect(page).to have_content(@pet_2.sex)
      expect(page).to have_content(@pet_2.shelter.name)
    end

    it "I can get to the edit page of a pet" do
      click_link("Update Pet", match: :first)

      expect(current_path).to eq("/pets/#{@pet_1.id}/edit")
    end

    it "I can delete a pet" do
      click_link("Delete Pet", match: :first)

      expect(current_path).to eq("/pets")
      expect(page).to_not have_content(@pet_1.name)
    end

    it "I can click a shelter name to get to its shelter show page" do
      click_link(@dog_city.name, match: :first)

      expect(current_path).to eq("/shelters/#{@dog_city.id}")
    end

    it "I can click a pet name to get to its pet show page" do
      click_link(@pet_1.name, match: :first)

      expect(current_path).to eq("/pets/#{@pet_1.id}")
    end
  end
end
