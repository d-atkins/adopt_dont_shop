require 'rails_helper'

RSpec.describe "from the shelters index page" do
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
end
