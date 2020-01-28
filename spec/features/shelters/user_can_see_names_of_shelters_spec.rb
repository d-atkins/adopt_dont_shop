require 'rails_helper'

describe "shelters index page", type: :features do
  context "as user" do
    it "can see names of all shelters" do
      shelter_1 = Shelter.create(name: "Shelter A")
      shelter_2 = Shelter.create(name: "Shelter B")
      shelter_3 = Shelter.create(name: "Denver Something-or-other Shelter")

      visit "/shelters"
      save_and_open_page

      expect(page).to have_content(shelter_1.name)
      expect(page).to have_content(shelter_2.name)
      expect(page).to have_content(shelter_3.name)
    end
  end
end
