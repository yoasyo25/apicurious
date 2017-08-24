class DashboardController < ApplicationController
  before_action :authorize

  def show
    @followers = User.get_all_followers(current_user)
    @followings = User.get_all_following(current_user)
    @user_recent_commits = User.get_recent_commits(current_user)
  end

end
