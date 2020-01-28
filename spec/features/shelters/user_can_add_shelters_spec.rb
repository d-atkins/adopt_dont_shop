require 'rails_helper'

describe "shelters new page", type: :features do
  context "as user" do
    before(:all) do
      @shelter_1 = Shelter.create(name: "Shelter A", address: "123 Fake St", city: "Unreal", state: "FK", zip: "12345")
      @shelter_2 = Shelter.create(name: "Dog City", address: "1923 Dog Ln", city: "Doggington", state: "CO", zip: "80414")
    end

    it "clicks add new shelter link" do
      visit "/shelters/"
      click_link "Add new shelter"
      save_and_open_page
      expect(page).to have_content("Enter details for a new shelter:")
    end
  end
end
