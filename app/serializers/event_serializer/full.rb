module EventSerializer
  class Full < ActiveModel::Serializer
    attributes :id, :title, :description, :start_date, :end_date, :is_notification

    def start_date
      object.start_date.strftime('%Y-%m-%d')
    end

    def end_date
      object.end_date.strftime('%Y-%m-%d')
    end
  end
end
