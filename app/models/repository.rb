class Repository
  attr_reader :created_at, :language, :link

  def initialize(attributes = {})
    @link = attributes[:html_url]
    @created_at = attributes[:created_at]
    @language = attributes[:language]
    @name = attributes[:html_url]
  end

  def repo_name
    @name.split("/").last
  end

end
