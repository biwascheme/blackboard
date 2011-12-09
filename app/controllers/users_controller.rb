class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @codes = @user.codes.order('updated_at DESC').
                         page(params[:page]).per(10)

    @owned = (current_user && (params[:id].to_i == current_user.id))
  end

  def signed_in?
    render json: (user_signed_in?)
  end
end
