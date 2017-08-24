require 'rails_helper'

feature "user can see profile page" do
  scenario "a logged in user can see own repos" do

    auth = {
      "provider" => 'github',
      "id" =>  1,
      "login" => "yoasyo25",
      "uid" => "16178096",
      "token" => "0a284b6c7844b121dd2868f25149cd9b1e63a8b7",
      "avatar_url" => "https://avatars2.githubusercontent.com/u/16178096?v=4",
      "name" => "Yohanan Assefa",
      "email" => "nanahoy@gmail.com",
      "created_at" => "Tue, 22 Aug 2017 13:49:43 UTC +00:00",
      "updated_at" => "Tue, 22 Aug 2017 13:49:43 UTC +00:00"
    }

    user = User.from_github(auth, auth["token"])

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    VCR.use_cassette("features/user_can_see_profile_page", :record => :new_episodes) do
      visit "/dashboard"

      expect(current_path).to eq(dashboard_path)

      click_on "Repositories"
      expect(current_path).to eq(repository_path)

      within(first('.repositories')) do
        expect(page).to have_css(".name")
        expect(page).to have_css(".created_at")
        expect(page).to have_css(".language")
      end
    end
  end
end
