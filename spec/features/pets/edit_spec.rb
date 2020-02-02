require 'rails_helper'

RSpec.describe "As a visitor:" do
  describe "from the pet show page" do
    it "I can get to the update page, fill in all fields of the update form, and submit the changes" do
      dog_city = Shelter.create!(name: "Dog City", address: "1923 Dog Ln", city: "Doggington", state: "CO", zip: "80414")
      pet_1 = Pet.create(
        image_path: "https://i.pinimg.com/originals/a9/cf/64/a9cf6473ca327409108ab02d15cc06b0.jpg",
        name: "Snoopy",
        description: "beagle pup eh",
        approximate_age: "6 months old",
        sex: "male",
        shelter: dog_city)
      pet_2 = Pet.create(
        image_path: "https://upload.wikimedia.org/wikipedia/commons/2/2b/WelshCorgi.jpeg",
        name: "Nana",
        description: "super cute dog in need of home",
        approximate_age: "4 years old",
        sex: "female",
        shelter: dog_city)
      updated_info = {
        image_path: "https://i.pinimg.com/236x/8d/28/e3/8d28e38a62466f9ef4166703fd5fe45f--nate-dogg-west-coast.jpg",
        name: "Snoop Dogg",
        description: "now you know you in trouble",
        approximate_age: "like 60 years old",
        sex: "alpha male"
        }

      visit "/pets/#{pet_1.id}"
      click_link("Update Pet")

      expect(current_path).to eq("/pets/#{pet_1.id}/edit")

      fill_in 'image_path', with: updated_info[:image_path]
      fill_in 'name', with: updated_info[:name]
      fill_in 'description', with: updated_info[:description]
      fill_in 'approximate_age', with: updated_info[:approximate_age]
      fill_in 'sex', with: updated_info[:sex]

      click_button("Update Pet")

      expect(current_path).to eq("/pets/#{pet_1.id}")
      expect(page).to have_css("img[src*='#{updated_info[:image_path]}']", count: 1)
      expect(page).to have_content(updated_info[:name], count: 1)
      expect(page).to have_content(updated_info[:description], count: 1)
      expect(page).to have_content(updated_info[:approximate_age], count: 1)
      expect(page).to have_content(updated_info[:sex], count: 1)
      expect(page).to have_content("adoptable", count: 1)

      expect(page).to_not have_css("img[src*='#{pet_2.image_path}']", count: 1)
      expect(page).to_not have_content(pet_2.name)
      expect(page).to_not have_content(pet_2.description)
      expect(page).to_not have_content(pet_2.approximate_age)
      expect(page).to_not have_content(pet_2.sex)
    end
  end
end
