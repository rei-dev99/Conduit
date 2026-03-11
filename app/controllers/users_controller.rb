class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
  end

  private

  def user_params
    params.expect(user: [:email, :password, :password_confirmation])
  end
end
