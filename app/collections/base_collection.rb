class BaseCollection
  attr_reader :params

  def initialize(params)
    @params = params
  end

  def results
    @results ||= begin
      ensure_filters
      relation
      paginate
    end
  end

  def meta
    { total: total }
  end

  def total
    results.size
  end

  def paginate
    if params[:page]
      @relation.paginate(per_page: params[:per_page], page: params[:page])
    else
      @relation
    end
  end

  def count
    @relation.count
  end

  private

  def filter
    @relation = yield(relation)
  end

  def relation
    fail(NotImplementedError)
  end

  def ensure_filters
    fail(NotImplementedError)
  end
end
