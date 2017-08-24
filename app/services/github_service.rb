class GithubService
  attr_reader :current_user

  def initialize(user)
    @current_user = user
    @conn = Faraday.new(url: "https://api.github.com") do |faraday|
      faraday.headers["X-API-KEY"] = ENV["client_id"]
      faraday.adapter Faraday.default_adapter
    end
  end

  def get_url(url)
    response = @conn.get(url)
    JSON.parse(response.body, symbolize_names: :true)
  end

  def find_all_repos
    get_url("https://api.github.com/users/#{current_user.username}/repos")
  end

  def self.find_all_repos(current_user)
    new(current_user).find_all_repos
  end

  def find_all_followers
    get_url("https://api.github.com/users/#{current_user.username}/followers")
  end

  def self.find_all_followers(current_user)
    new(current_user).find_all_followers
  end

  def find_all_following
    get_url("https://api.github.com/users/#{current_user.username}/following")
  end

  def self.find_all_following(current_user)
    new(current_user).find_all_following
  end

  # add organization and make them public
  def find_all_organizations
    get_url("https://api.github.com/users/#{current_user.username}/orgs")
  end
  #######
  def self.find_all_organizations(current_user)
    new(current_user).find_all_organizations
  end

  def find_recent_commits
    get_url("https://api.github.com/users/#{current_user.username}/received_events")
  end

  def self.find_recent_commits(current_user)
    new(current_user).find_recent_commits
  end
end
