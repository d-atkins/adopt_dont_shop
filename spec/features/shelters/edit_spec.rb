require 'rails_helper'

RSpec.describe "from the shelter show page" do
  it "I can click 'Update Shelter' link on the show page" do
    shelter_1 = Shelter.create(name: "Shelter A", address: "123 Fake St", city: "Las Vegas", state: "WY", zip: "12345")
    Shelter.create(name: "Dog City", address: "1923 Dog Ln", city: "Doggington", state: "CO", zip: "80414")

    visit "/shelters/#{shelter_1.id}"
    click_link "Update Shelter"

    expect(current_path).to eq("/shelters/#{shelter_1.id}/edit")

    expect(page).to have_content("Update shelter")
    expect(page).to have_content('Name')
    expect(page).to have_content('Address')
    expect(page).to have_content('City')
    expect(page).to have_content('State')
    expect(page).to have_content('Zip')
  end

  it "I can fill the update form and click submit" do
    shelter_1 = Shelter.create(name: "Shelter A", address: "123 Fake St", city: "Las Vegas", state: "WY", zip: "12345")
    new_info = {name: "Dog City", address: "1923 Dog Ln", city: "Doggington", state: "CO", zip: "80414"}

    visit "/shelters/#{shelter_1.id}/edit"

    fill_in 'shelter[name]', with: new_info[:name]
    fill_in 'shelter[address]', with: new_info[:address]
    fill_in 'shelter[city]', with: new_info[:city]
    fill_in 'shelter[state]', with: new_info[:state]
    fill_in 'shelter[zip]', with: new_info[:zip]

    click_button("Submit")

    expect(current_path).to eq("/shelters/#{shelter_1.id}")

    expect(page).to have_content("Name: #{new_info[:name]}")
    expect(page).to have_content("Address: #{new_info[:address]}")
    expect(page).to have_content("City: #{new_info[:city]}")
    expect(page).to have_content("State: #{new_info[:state]}")
    expect(page).to have_content("Zip: #{new_info[:zip]}")

    expect(page).to_not have_content("Name: #{shelter_1.name}")
    expect(page).to_not have_content("Address: #{shelter_1.address}")
    expect(page).to_not have_content("City: #{shelter_1.city}")
    expect(page).to_not have_content("State: #{shelter_1.state}")
    expect(page).to_not have_content("Zip: #{shelter_1.zip}")
  end
end
