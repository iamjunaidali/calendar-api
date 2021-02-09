module Api
  module V1
    class EventsController < BaseController

      def create
        event = Event.create!(event_params)
        render json: event, serializer: EventSerializer::Full
      end

      def update
        event = Event.find(params[:id])
        event.update!(event_params)
        render json: event, serializer: EventSerializer::Full
      end

      def index
        collection = EventsCollection.new({})
        render json: collection.results, each_serializer: EventSerializer::Full
      end

      def search_events
        # sd = DateTime.parse(params[:start]).beginning_of_day
        # ed = sd.end_of_day

        #Solr was not working in testing due to some dependencies issues.
        # results ||= Event.search do
        #   with(:start_date, sd..ed)
        # end

        collection = EventsCollection.new(params)
        render json: collection.results, each_serializer: EventSerializer::Full
      end

      def destroy
        if event.destroy
          render json: event
        else
          render json: { message: event.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def event
        @event ||= Event.find(params[:id])
      end

      def event_params
        params.permit(:title, :description, :start_date, :end_date, :is_notification).merge(start_date: params[:start], end_date: params[:end])
      end
    end
  end
end
