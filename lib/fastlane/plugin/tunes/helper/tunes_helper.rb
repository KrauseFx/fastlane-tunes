module Fastlane
  module Helper
    class TunesHelper
      def self.print_audio_information(path)
        UI.message "Playing song '#{path}'"
        duration = `afinfo songs/Classic1.mp3 | grep "duration"`.match(/duration: ([\d\.]+)/)
        duration = duration[1].to_i
        UI.message "Song duration #{duration} seconds"
      rescue => ex
        UI.error(ex) # we don't want this to fail the build
      end
    end
  end
end
