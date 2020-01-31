require 'rails_helper'

describe "from a shelter show page" do
  it "I can click a delete button" do
    shelter_1 = Shelter.create!(
      name: "Shelter A",
      address: "123 Fake St",
      city: "Las Vegas",
      state: "WY",
      zip: "12345")
    shelter_2 = Shelter.create!(
      name: "delete me",
      address: "do",
      city: "it",
      state: "you",
      zip: "coward")

    visit "/shelters/#{shelter_2.id}"
    click_button("Delete Shelter")

    expect(current_path).to eq('/shelters')
    expect(page).to have_content('Name: ' + shelter_1.name)
    expect(page).to_not have_content('Name: ' + shelter_2.name)
  end
end
