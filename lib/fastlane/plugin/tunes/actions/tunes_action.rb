module Fastlane
  module Actions
    class TunesAction < Action
      def self.run(params)
        sh "afplay '#{params[:file_path]}'"
      end

      def self.description
        "Play music using fastlane, because you can."
      end

      def self.authors
        ["Boris Bügling"]
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :file_path,
                                  env_name: "TUNES_FILE_PATH",
                               description: "Specify the path of the audio file to play",
                                  optional: false,
                                      type: String)
        ]
      end

      def self.is_supported?(platform)
        [:ios, :mac, :android, :caros, :rocketos, :napos].include?(platform)
      end
    end
  end
end
