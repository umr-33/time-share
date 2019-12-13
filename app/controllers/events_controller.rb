class EventsController < ApplicationController
  before_action :set_item, only: [:edit, :show, :update, :destroy]
  def index

    @events = Event.all
  end

  def new
    @group = Group.find(params[:group_id])
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      redirect_to "/groups/#{@event.group.id}"
    else
      #@events = @group.events.includes(:user)
      flash.now[:alert] = '予定を入力してください'
      render :new
    end
  end

  def update
  end

  def destroy
    @event.destroy
  end

  private

  def event_params
    params.require(:event).permit(:title, :start, :end, :color, :allday).merge(user_id: current_user.id, group_id: params[:group_id])
  end

  def set_group
    @group = Group.find(params[:group_id])
  end
end
