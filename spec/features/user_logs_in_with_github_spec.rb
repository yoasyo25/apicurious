require 'rails_helper'

RSpec.feature "user logs in" do
  scenario "using github" do

    stub_omniauth
    visit root_path
    expect(page).to have_link("Log in with Github")
    click_link "Log in with Github"
    expect(page).to have_content("Yohanan Assefa")
    expect(page).to have_content("Logout")
  end
end
