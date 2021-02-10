class EventsCollection < BaseCollection
  private

  def relation
    @relation ||= Event.all
  end

  def ensure_filters
    all_events_of_the_day
  end

  def all_events_of_the_day
    if params[:start_date]
      sd = Date.parse(params[:start_date]).beginning_of_day
      ed = sd.end_of_day

      filter do
        relation.where(start_date: sd..ed).
          order(start_date: :asc)
      end
    end
  end
end
