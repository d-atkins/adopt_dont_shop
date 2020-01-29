require 'rails_helper'

describe "shelters new page", type: :features do
  context "as user" do

    it "clicks add new shelter link" do

      visit "/shelters/"
      click_link "Add new shelter"

      expect(page).to have_content("Enter details for a new shelter:")
    end

    it "fills form and clicks submit" do
      Shelter.create(name: "Shelter A", address: "123 Fake St", city: "Unreal", state: "FK", zip: "12345")
      Shelter.create(name: "Dog City", address: "1923 Dog Ln", city: "Doggington", state: "CO", zip: "80414")
      visit "/shelters/"
      click_link "Add new shelter"
      fill_in 'shelter[name]', with: 'Cool Dogs Palace'
      fill_in 'shelter[address]', with: '89123 Cool St'
      fill_in 'shelter[city]', with: 'Cool City'
      fill_in 'shelter[state]', with: 'Coolorado'
      fill_in 'shelter[zip]', with: '88888'
      click_button("Create Shelter")

      save_and_open_page

      expect(page).to have_content("Cool Dogs Palace")
    end
  end
end
