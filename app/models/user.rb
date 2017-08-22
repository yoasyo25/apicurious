class User < ApplicationRecord

  def self.from_github(data, access_token)
    user = User.find_or_create_by(uid: data["id"], provider: 'github')
    user.username = data["login"]
    user.token = access_token
    user.name = data["name"]
    user.email = data["email"]
    user.image = data["avatar_url"]
    user.save

    user
  end
end
