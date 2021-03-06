class GroupsController < ApplicationController
  before_action :set_group, only: [:edit, :update, :show, :destroy]

  def index
  end

  def new
    @group = Group.new
    @group.users << current_user
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      redirect_to "/groups/#{current_user.id}"
      # redirect_to "/users/#{current_user.id}"
    else
      render :new
    end
  end

  def show
    @events = @group.events.includes(:user)
  end

  def update
    if @group.update(group_params)
      redirect_to group_event_path(@group), notice: '編集しました'
    else
      render :edit
    end
  end

  private
  def group_params
    params.require(:group).permit(:name, {user_ids: [] })
  end

  def set_group
    @group = Group.find(params[:id])
  end
end
