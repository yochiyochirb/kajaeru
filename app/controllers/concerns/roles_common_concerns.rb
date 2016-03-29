concern :RolesCommonConcerns do

  included do
    before_action :set_event, only: %i(index)

    private

    def set_event
      @event = Event.find(params[:event_id])
    end
  end
end
