require 'rails_helper'

describe GithubService do

  describe "repositories" do
    it "finds user repositories" do

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

      VCR.use_cassette("services/find-user-repos", :record => :new_episodes) do
        repositories = GithubService.find_all_repos(user)
        repository = repositories.first

        expect(repositories.count).to eq(30)
        expect(repository[:name]).to eq("active-record-sinatra")
        expect(repository[:html_url]).to eq("https://github.com/yoasyo25/active-record-sinatra")
        expect(repository[:created_at]).to eq("2017-06-28T20:07:38Z")
      end

      VCR.use_cassette("services/find-followers", :record => :new_episodes) do
        followers = GithubService.find_all_followers(user)
        follower = followers.first

        expect(followers.count).to eq(4)
        expect(follower[:login]).to eq("dianawhalen")
      end

      VCR.use_cassette("services/find-following", :record => :new_episodes) do
        followings = GithubService.find_all_following(user)
        following = followings.first

        expect(following.count).to eq(17)
        expect(following[:login]).to eq("dhh")
      end

      # VCR.use_cassette("services/find-organizations", :record => :new_episodes) do
      #   organizations = GithubService.find_all_organizations(user)
      #   organization = organizations.first
      #
      #   expect(organization.count).to eq(1)
      #   expect(organization[:url]).to eq("dhh")
      # end
    end
  end
end
