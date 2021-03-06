require 'rails_helper'

RSpec.describe "As a visitor:" do
  describe "from the pet show page" do
    it "I can delete a pet from the database" do
      dog_city = Shelter.create!(
        name: "Dog City",
        address: "1923 Dog Ln",
        city: "Doggington",
        state: "CO",
        zip: "80414")
      pet_1 = Pet.create(
        image: "https://i.pinimg.com/originals/a9/cf/64/a9cf6473ca327409108ab02d15cc06b0.jpg",
        name: "Snoopy",
        description: "beagle pup eh",
        age: "6 months old",
        sex: "male",
        shelter: dog_city)
      pet_2 = Pet.create(
        image: "https://upload.wikimedia.org/wikipedia/commons/2/2b/WelshCorgi.jpeg",
        name: "Nana",
        description: "super cute dog in need of home",
        age: "4 years old",
        sex: "female",
        shelter: dog_city)

      visit "/pets/#{pet_2.id}"
      click_link("Delete Pet")

      expect(current_path).to eq("/pets")
      expect(page).to have_css("img[src*='#{pet_1.image}']")
      expect(page).to have_content("Name: #{pet_1.name}")
      expect(page).to have_content("Age: #{pet_1.age}")
      expect(page).to have_content("Sex: #{pet_1.sex}")

      expect(page).to_not have_css("img[src*='#{pet_2.image}']")
      expect(page).to_not have_content(pet_2.name)
      expect(page).to_not have_content(pet_2.age)
      expect(page).to_not have_content(pet_2.sex)
    end
  end
end
