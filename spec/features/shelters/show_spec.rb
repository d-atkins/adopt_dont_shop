require 'rails_helper'

RSpec.describe "As a visitor: " do
  describe "from the shelter show page" do
    it "I can see the info of the shelter" do
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

      visit "/shelters/#{shelter_1.id}"

      expect(page).to have_content("Name: #{shelter_1.name}")
      expect(page).to have_content("Address: #{shelter_1.address}")
      expect(page).to have_content("City: #{shelter_1.city}")
      expect(page).to have_content("State: #{shelter_1.state}")
      expect(page).to have_content("Zip: #{shelter_1.zip}")
      expect(page).to_not have_content("Name: #{shelter_2.name}")
    end
  end
end
