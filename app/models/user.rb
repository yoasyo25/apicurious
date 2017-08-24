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

  def self.get_all_followers(current_user)
    GithubService.find_all_followers(current_user)
  end

  def self.get_all_following(current_user)
    GithubService.find_all_following(current_user)
  end

  def self.get_recent_commits(current_user)
    recent_events = GithubService.find_recent_commits(current_user)

    push_events = recent_events.select { |type| type[:type] == "PushEvent" }

    repo_name = push_events.map { |push_event| push_event[:repo][:url] }.split("/").last

    commits = push_events.each do |event|
      event[:payload][:commits]
    end

    # author_and_push_message = {}
    #   commits.each do |name|
    #     author_and_push_message[name[:author][:name]] = name[:message]
    #   end
    end
end
