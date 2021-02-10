module Api
  module V1
    class BaseController < ApplicationController
      include ExceptionHandler
    end
  end
end
