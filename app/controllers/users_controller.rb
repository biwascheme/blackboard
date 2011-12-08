class UsersController < ApplicationController
  def show
    @me = (current_user && (params[:id].to_i == current_user.id))
  end

  def signed_in?
    render json: !!current_user
  end
end
