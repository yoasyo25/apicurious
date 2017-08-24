require 'rails_helper'

RSpec.describe User, type: :model do
  it "creates of updates itself from oauth hash" do
    auth = {
      "provider" => 'github',
      "id" =>  1,
      "login" => "yoasyo25",
      "uid" => "16178096",
      "token" => "0a284b6c7844b121dd2868f25149cd9b1e63a8b7",
      "avatar_url" => "https://avatars2.githubusercontent.com/u/16178096?v=4",
      "name" => "Yohanan Assefa",
      "email" => "nanahoy@gmail.com",
      "provider" => "github",
      "created_at" => "Tue, 22 Aug 2017 13:49:43 UTC +00:00",
      "updated_at" => "Tue, 22 Aug 2017 13:49:43 UTC +00:00"
    }

    User.from_github(auth, auth["token"])
    new_user = User.first
    expect(new_user.provider).to eq("github")
    expect(new_user.email).to eq("nanahoy@gmail.com")
    expect(new_user.name).to eq("Yohanan Assefa")
    expect(new_user.username).to eq("yoasyo25")
    expect(new_user.image).to eq("https://avatars2.githubusercontent.com/u/16178096?v=4")
  end
end
