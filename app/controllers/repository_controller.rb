class RepositoryController < ApplicationController

  def index
    @repositories = Repository.find_all(current_user)
  end

end
