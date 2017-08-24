class RepositoryController < ApplicationController

  def index
    @conn = Faraday.new(url: "https://api.github.com") do |faraday|
      faraday.headers["X-API-KEY"] = ENV["client_id"]
      faraday.adapter Faraday.default_adapter
    end

    response = @conn.get("https://api.github.com/users/#{current_user.username}/repos")

    results = JSON.parse(response.body, symbolize_names: :true)

    @repositories = results.map do |result|
      Repository.new(result)
    end
  end
end
