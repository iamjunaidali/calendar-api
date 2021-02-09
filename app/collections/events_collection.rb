class EventsCollection < BaseCollection
  private

  def relation
    @relation ||= Event.all
  end

  def ensure_filters
    all_events_of_the_month
    all_events_of_the_year
  end

  def all_events_of_the_month
    filter do
      relation.where(start_date: DateTime.now.beginning_of_month..DateTime.now.end_of_month).
        order(start_date: :asc)
    end if params[:all_events_of_the_month]
  end

  def all_events_of_the_year
    filter do
      relation.where(start_date: DateTime.now.beginning_of_year..DateTime.now.end_of_year).
        order(start_date: :asc)
    end if params[:all_events_of_the_year]
  end
end
