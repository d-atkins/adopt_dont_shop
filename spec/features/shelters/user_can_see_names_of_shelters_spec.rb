require 'rails_helper'

describe "shelters index page", type: :features do
  context "as user" do
    before(:all) do
      @shelter_1 = Shelter.create(name: "Shelter A", address: "123 Fake St", city: "Unreal", state: "FK", zip: "12345")
      @shelter_2 = Shelter.create(name: "Dog City", address: "1923 Dog Ln", city: "Doggington", state: "CO", zip: "80414")
    end

    it "sees names of all shelters" do
      visit "/shelters"

      expect(page).to have_content(@shelter_1.name)
      expect(page).to have_content(@shelter_2.name)
    end

    it "see info of a shelter on shelter show page" do
      visit "/shelters/#{@shelter_1.id}"

      expect(page).to have_content(@shelter_1.name)
      expect(page).to have_content(@shelter_1.address)
      expect(page).to have_content(@shelter_1.city)
      expect(page).to have_content(@shelter_1.state)
      expect(page).to have_content(@shelter_1.zip)
    end
  end
end
