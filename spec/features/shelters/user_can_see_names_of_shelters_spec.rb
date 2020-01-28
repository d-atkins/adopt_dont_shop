require 'rails_helper'

describe "shelters index page", type: :features do
  context "as user" do
    it "sees names of all shelters" do
      shelter_1 = Shelter.create(name: "Shelter A", address: "123 Fake St", city: "Unreal", state: "FK", zip: "12345")
      shelter_2 = Shelter.create(name: "Shelter B", address: "1923 Dog Ln", city: "Doggington", state: "CO", zip: "80414")

      visit "/shelters"

      expect(page).to have_content(shelter_1.name)
      expect(page).to have_content(shelter_2.name)
    end
  end
end
