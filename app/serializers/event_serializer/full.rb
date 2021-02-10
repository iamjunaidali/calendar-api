module EventSerializer
  class Full < ActiveModel::Serializer
    attributes :id, :title, :description, :start, :end, :is_notification

    def start
      object.start_date
    end

    def end
      object.end_date
    end
  end
end
