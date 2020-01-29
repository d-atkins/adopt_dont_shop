require 'rails_helper'

describe "shelters index page", type: :features do
  context "as user" do

    it "sees names of all shelters" do
      shelter_1 = Shelter.create(name: "Shelter A", address: "123 Fake St", city: "Unreal", state: "FK", zip: "12345")
      shelter_2 = Shelter.create(name: "Dog City", address: "1923 Dog Ln", city: "Doggington", state: "CO", zip: "80414")
      visit "/shelters"

      expect(page).to have_content(shelter_1.name)
      expect(page).to have_content(shelter_2.name)
    end

    it "see info of a shelter on show page" do
      shelter_1 = Shelter.create(name: "Shelter A", address: "123 Fake St", city: "Unreal", state: "FK", zip: "12345")
      visit "/shelters/#{shelter_1.id}"

      expect(page).to have_content('Name: ' + shelter_1.name)
      expect(page).to have_content('Address: ' + shelter_1.address)
      expect(page).to have_content('City: ' + shelter_1.city)
      expect(page).to have_content('State: ' + shelter_1.state)
      expect(page).to have_content('Zip: ' + shelter_1.zip)
    end

    it "clicks 'Add Shelter' link" do
      visit "/shelters/"
      click_link "New shelter"

      expect(page).to have_content("Enter details for a new shelter:")
    end

    it "fills form and clicks submit" do
      Shelter.create(name: "Shelter A", address: "123 Fake St", city: "Unreal", state: "FK", zip: "12345")
      Shelter.create(name: "Dog City", address: "1923 Dog Ln", city: "Doggington", state: "CO", zip: "80414")
      visit "/shelters/"
      click_link "New shelter"
      fill_in 'shelter[name]', with: 'Cool Dogs Palace'
      fill_in 'shelter[address]', with: '89123 Cool St'
      fill_in 'shelter[city]', with: 'Cool City'
      fill_in 'shelter[state]', with: 'Coolorado'
      fill_in 'shelter[zip]', with: '88888'
      click_button("Create Shelter")

      expect(page).to have_content("Cool Dogs Palace")
    end
  end
end
