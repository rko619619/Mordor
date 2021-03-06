class ProfilesController < ApplicationController
  before_action :set_profile, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :check_ban

  def index
    @profiles = Profile.all
  end

  def show
  end

  def new
    @profile = current_user.build_profile
  end

  def edit
  end

  def create
    @profile = current_user.build_profile(profile_params)
      if @profile.save
        redirect_to @profile, success: t('profile.controller.profile_created')
      else
        flash.now[:danger] = t('profile.controller.profile_not_created')
        render :new
      end
  end

  def update
      if @profile.update(profile_params)
        redirect_to @profile, success: t('profile.controller.profile_update')
      else
        flash.now[:danger] = t('profile.controller.profile_not_created')
        render :edit
      end
  end

  def destroy
    @profile.destroy
    redirect_to profiles_path, success: t('profile.controller.profile_delete')
  end

  private

    def set_profile
      @profile = Profile.find(params[:id])
    end

    def profile_params
      params.require(:profile).permit(:screenname, :city, :birthday, :full_name)
    end

  protected

  def check_ban
    if current_user.ban?
      redirect_to root_path, alert: t('admin.ban')
    end
  end
end
