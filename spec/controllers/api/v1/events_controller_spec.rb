require 'rails_helper'

RSpec.describe Api::V1::EventsController, type: :request do
  let!(:event) { create(:event, description: "This is a test description") }

  describe '#index' do
    context 'when no filter provided' do
      it 'returns all events' do
        get api_v1_events_path
        expect(parsed_response.first['description']).to eq("This is a test description")
      end
    end
  end

  describe '#create' do
    context 'event successfully created' do
      let!(:params) do
        {
          title: "Reminder event",
          description: "This is a test reminder event",
          start_date: DateTime.current,
          end_date: DateTime.current + 30.minute,
          is_notification: true
        }
      end

      it 'creates an event' do
        post "/api/v1/events", params: params
        expect(parsed_response['description']).to eq("This is a test reminder event")
      end
    end
  end

  describe '#update' do
    context 'event successfully updated' do
      let!(:update_event) { create(:event, description: "This is a test description of update event") }

      let!(:params) do
        {
          description: "Event has been updated"
        }
      end

      it 'updates an event' do
        put api_v1_event_path(update_event.id), params: params
        expect(parsed_response['description']).to eq("Event has been updated")
      end
    end
  end

  describe '#destroy' do
    context 'event successfully destroyed' do
      let!(:destroy_event) { create(:event, description: "This is a test description of a destroy event") }
      let!(:sample_event) { create(:event, description: "This is a test description of a sample event") }

      it 'destroy an event' do
        delete "/api/v1/events/#{destroy_event.id}"
        expect(Event.count).to eq(2)
      end
    end
  end
end
