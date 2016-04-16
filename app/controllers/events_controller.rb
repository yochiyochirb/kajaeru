class EventsController < ApplicationController
  before_action :set_event, only: :show

  def index
    @events = Event.all
  end

  def show
    @voter = current_user.as_voter_for(@event)
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end
end
