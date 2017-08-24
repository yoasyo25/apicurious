class Repository
  attr_reader :created_at, :language, :link

  def initialize(attributes = {})
    @link = attributes[:html_url]
    @created_at = attributes[:created_at]
    @language = attributes[:language]
    @name = attributes[:html_url]
  end

  def repo_name
    @name.split("/").last.capitalize
  end

  def self.find_all(current_user)
    repositories = GithubService.find_all_repos(current_user).map do |raw_repo|
      Repository.new(raw_repo)
    end
  end


end
