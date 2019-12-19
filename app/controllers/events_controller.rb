class EventsController < ApplicationController
  before_action :set_group, only: [:edit, :show, :update, :destroy]
  before_action :move_to_index, except: [:index, :show]

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
      
      flash.now[:alert] = '予定を入力してください'
      render :new
    end
  end

  def show
    @group = Group.where(:id => params[:group_id]).first
    @event = @group.events.where(:id => params[:id]).first
  
  end

  def edit
    @group = Group.find(params[:group_id])
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    if @event.update(event_params)
      redirect_to root_path, notice: 'グループを更新しました'
    else
      render :edit
    end
  end

  def destroy
    @event = Event.find(params[:id])
    if @event.destroy
      redirect_to root_path
    else
      render :edit
    end
  end

  private

  def event_params
    params.require(:event).permit(:title, :start, :end, :color, :allday).merge(user_id: current_user.id, group_id: params[:group_id])
  end

  def set_group
    @group = Group.find(params[:group_id])
  end

  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end
end
