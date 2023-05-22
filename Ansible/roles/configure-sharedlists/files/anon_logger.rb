# Monkey patch ip address logging
# https://github.com/rails/rails/blob/7-1-stable/railties/lib/rails/rack/logger.rb

module Rails
  module Rack
    class Logger < ActiveSupport::LogSubscriber
      def started_request_message(request) # :doc:
        'Started %s "%s" for %s at %s' % [
          request.raw_request_method,
          request.filtered_path,
          'xx.xxx.xxx.x',
          Time.now.to_default_s ]
      end
    end
  end
end
