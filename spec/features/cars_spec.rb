require 'rails_helper'

RSpec.feature "Cars", type: :feature do
  scenario "User views /cars page" do
    visit "/cars"
    expect(page).to have_text("Cars")
    # save_and_open_page
    # screenshot_and_save_page
    # screenshot_and_open_image
    page.save_screenshot 'screenshot.png'
  end
end


# it 'successfully creates farm' do
#   visit '/farms'
#   click_link 'New Farm'

#   within '#new_farm' do
#     fill_in 'Acres', with: 10
#     fill_in 'Name', with: 'Castillo Andino'
#     fill_in 'Owner', with: 'Albita'
#     fill_in 'Address', with: 'Andes, Colombia'
#     fill_in 'Varieties', with: 'Colombia, Geisha, Bourbon'
#     fill_in 'Rating', with: 10
#   end
#   click_button 'Create Farm'

#   expect(page).to have_content 'Farm was successfully created.'
#   expect(page).to have_content 'Castillo Andino'
# end
