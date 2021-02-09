module Api
  module V1
    class EventsController < BaseController

      def create
        event = Event.create(event_params)
        render json: event, serializer: EventSerializer::Full
      end

      def update
        event = Event.find(params[:id])
        event.update!(event_params)
        render json: event, serializer: EventSerializer::Full
      end

      def index
        collection = EventsCollection.new(params)
        render json: collection.results, each_serializer: EventSerializer::Full
      end

      def search_event
        event.update!(event_params)
        render json: event, serializer: EventSerializer::Full
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
        params.permit(:title, :description, :start_date, :end_date, :is_notification)
      end
    end
  end
end
