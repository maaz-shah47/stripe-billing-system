# frozen_string_literal: true

module Admin
  # Users controller
  class UsersController < ApplicationController
    skip_before_action :authenticate_user!, only: %i[new create]
    before_action :auth_user, only: %i[index show new create edit update destroy]
    before_action :authenticate_user!

    layout 'main'

    def index
      @users = User.where.not(id: current_user.id).page params[:page]
    end

    def show
      @user = User.find(params[:id])
    rescue ActiveRecord::RecordNotFound => e
      render json: {
        error: e.to_s
      }, status: :not_found
    end

    def new
      @user = User.new
      authorize @user
    end

    def create
      ActiveRecord::Base.transaction do
        @user = User.new(users_params)
        if @user.save
          redirect_to users_path
        else
          render :new, status: :unprocessable_entity
        end
      end
    end

    def edit
      @user = User.find(params[:id])
    rescue ActiveRecord::RecordNotFound => e
      render json: {
        error: e.to_s
      }, status: :not_found
    end

    def update
      begin
        @user = User.find(params[:id])
      rescue ActiveRecord::RecordNotFound => e
        render json: {
          error: e.to_s
        }, status: :not_found
      end
      if @user.update(users_params)
        redirect_to users_path
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @user = User.find(params[:id])
      @user.destroy

      redirect_to users_path, status: :see_other
    rescue ActiveRecord::RecordNotFound => e
      render json: {
        error: e.to_s
      }, status: :not_found
    end

    def resend_invitation
      @user = User.find(params[:id])
      if @user.created_by_invite? && !@user.invitation_accepted?
        @user.invite!
        redirect_to users_path, notice: 'User re-invited'
      else
        redirect_to users_path, alert: 'User is already active'
      end
    end

    private

    def auth_user
      authorize current_user
    end

    def users_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :user_type, :avatar)
    end
  end
end
