require 'rails_helper'

RSpec.describe "from the shelters index page" do
  it "I can click a link to add a shelter" do
    visit "/shelters/"

    click_link "New Shelter"

    expect(current_path).to eq("/shelters/new")

    expect(page).to have_content("Enter details for a new shelter:")
    expect(page).to have_content('Name')
    expect(page).to have_content('Address')
    expect(page).to have_content('City')
    expect(page).to have_content('State')
    expect(page).to have_content('Zip')
  end

  it "I can fill the form and click submit" do
    Shelter.create(name: "Shelter A", address: "123 Fake St", city: "Las Vegas", state: "WY", zip: "12345")
    Shelter.create(name: "Dog City", address: "1923 Dog Ln", city: "Doggington", state: "CO", zip: "80414")
    new_info = {name: "Cool Dogs Palace", address: "89123 Cool St", city: "Cool City", state: "Coolorado", zip: "88888"}

    visit "/shelters/"
    click_link "New Shelter"

    expect(current_path).to eq("/shelters/new")

    fill_in 'shelter[name]', with: new_info[:name]
    fill_in 'shelter[address]', with: new_info[:address]
    fill_in 'shelter[city]', with: new_info[:city]
    fill_in 'shelter[state]', with: new_info[:state]
    fill_in 'shelter[zip]', with: new_info[:zip]

    click_button("Create Shelter")

    expect(current_path).to eq('/shelters')

    expect(page).to have_content("Cool Dogs Palace")
  end
end
