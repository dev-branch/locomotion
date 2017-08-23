require 'rails_helper'

RSpec.feature "Cars", type: :feature do
  scenario "User views /cars page" do
    visit "/cars"
    expect(page).to have_text("Cars")
    save_and_open_page
  end
end
