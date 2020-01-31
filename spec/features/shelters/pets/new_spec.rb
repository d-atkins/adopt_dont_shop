require 'rails_helper'

RSpec.describe 'from the shelter pets index page' do
  it 'I can get to the new pet page, fill the form, and submit it' do
    dog_city = Shelter.create!(
      name: "Dog City",
      address: "1923 Dog Ln",
      city: "Doggington",
      state: "CO",
      zip: "80414")
    pet_1 = Pet.create!(
      image_path: "https://i.pinimg.com/originals/a9/cf/64/a9cf6473ca327409108ab02d15cc06b0.jpg",
      name: "Snoopy",
      description: "beagle pup eh",
      approximate_age: "6 months old",
      sex: "male",
      shelter: dog_city,
      status: "adoptable")
    pet_2 = Pet.create!(
      image_path: "https://upload.wikimedia.org/wikipedia/commons/2/2b/WelshCorgi.jpeg",
      name: "Nana",
      description: "super cute dog in need of home",
      approximate_age: "4 years old",
      sex: "female",
      shelter: dog_city,
      status: "adoptable")
    new_info = {
      image_path: "https://cdn.mos.cms.futurecdn.net/g8PyY6xAhcndpQLLSkdPf-320-80.jpg",
      name: "Capy'n Hook",
      description: "dread of the seven seas",
      approximate_age: "400 years old?",
      sex: "male"}

    visit "/shelters/#{dog_city.id}/pets"
    click_link('Add a New Adoptable Pet')

    expect(current_path).to eq("/shelters/#{dog_city.id}/pets/new")

    fill_in 'image_path', with: new_info[:image_path]
    fill_in 'name', with: new_info[:name]
    fill_in 'description', with: new_info[:description]
    fill_in 'approximate_age', with: new_info[:approximate_age]
    fill_in 'sex', with: new_info[:sex]

    click_button('Submit')

    expect(current_path).to eq("/shelters/#{dog_city.id}/pets")
    expect(page).to have_css("img[src*='#{pet_1.image_path}']")
    expect(page).to have_content(pet_1.name)
    expect(page).to have_content(pet_1.approximate_age)
    expect(page).to have_content(pet_1.sex)
    expect(page).to have_css("img[src*='#{pet_2.image_path}']")
    expect(page).to have_content(pet_2.name)
    expect(page).to have_content(pet_2.approximate_age)
    expect(page).to have_content(pet_2.sex)
    expect(page).to have_css("img[src*='#{new_info[:image_path]}']")
    expect(page).to have_content(new_info[:name])
    expect(page).to have_content(new_info[:approximate_age])
    expect(page).to have_content(new_info[:sex])
  end
end
