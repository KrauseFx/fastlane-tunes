module Fastlane
  module Helper
    class TunesHelper
      # class methods that you define here become available in your action
      # as `Helper::TunesHelper.your_method`
      #
      def self.show_message
        UI.message("Hello from the tunes plugin helper!")
      end
    end
  end
end
