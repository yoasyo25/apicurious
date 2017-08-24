require 'rails_helper'

RSpec.feature "user logs in" do
  it "is able to log in using github" do
    VCR.use_cassette("feature/user-logs-in-through-github", :record => :new_episodes) do
      visit root_path
      expect(page).to have_link("Log in with Github")
      click_link "Log in with Github"
      expect(page).to have_content("Yohanan Assefa")
      expect(page).to have_content("Logout")
    end
  end
end
