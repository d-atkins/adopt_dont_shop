require 'rails_helper'

RSpec.describe "from the pet show page" do
  it "I can get to the update page, fill in all fields of the update form, and submit the changes" do
    dog_city = Shelter.create!(name: "Dog City", address: "1923 Dog Ln", city: "Doggington", state: "CO", zip: "80414")
    pet_1 = Pet.create(
      image_path: "https://i.pinimg.com/originals/a9/cf/64/a9cf6473ca327409108ab02d15cc06b0.jpg",
      name: "Snoopy",
      description: "beagle pup eh",
      approximate_age: "6 months old",
      sex: "male",
      shelter: dog_city,
      status: "adoptable")
    pet_2 = Pet.create(
      image_path: "https://upload.wikimedia.org/wikipedia/commons/2/2b/WelshCorgi.jpeg",
      name: "Nana",
      description: "super cute dog in need of home",
      approximate_age: "4 years old",
      sex: "female",
      shelter: dog_city,
      status: "adoptable")
    snoop_url = "https://i.pinimg.com/236x/8d/28/e3/8d28e38a62466f9ef4166703fd5fe45f--nate-dogg-west-coast.jpg"

    visit "/pets/#{pet_1.id}"
    click_link("Update Pet")

    expect(current_path).to eq("/pets/#{pet_1.id}/edit")

    fill_in 'image_path', with: snoop_url
    fill_in 'name', with: "Snoop Dogg"
    fill_in 'description', with: "man, you know you in trouble"
    fill_in 'approximate_age', with: "like 60 years old"
    fill_in 'sex', with: "male"

    click_button("Update Pet")

    expect(current_path).to eq("/pets/#{pet_1.id}")
    expect(page).to have_css("img[src*='#{snoop_url}']")
    expect(page).to have_content("Snoop Dogg")
    expect(page).to have_content("man, you know you in trouble")
    expect(page).to have_content("like 60 years old")
    expect(page).to have_content("male")
    expect(page).to have_content("adoptable")
    expect(page).to_not have_content(pet_2.name)
  end
end
