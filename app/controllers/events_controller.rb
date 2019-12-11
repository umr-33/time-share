class EventsController < ApplicationController
  before_action :set_group, only: []
  def index
    @events = Event.all
    @group = current_user.groups[0]
  end

  def new
    @group = current_user.groups[0]
    @event = Event.new
  end

  def create
    @event = @group.events.new(event_params)
    if @message.save
      redirect_to group_events_path(@group)
    else
      @events = @group.events.includes(:user)
      flash.new[:alert] = '予定を入力してください'
      render :index
    end
  end

  def update
  end

  def destroy
    @event.destroy
  end

  private

  def event_params
    params.require(:event).permit(:title, :start, :end, :color, :allday)
  end

  def set_group
    @group = Group.find(params[:group_id])
  end
end
