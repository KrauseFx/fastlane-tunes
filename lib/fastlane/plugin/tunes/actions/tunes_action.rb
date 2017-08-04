require 'shellwords'
module Fastlane
  module Actions
    class TunesAction < Action
      def self.run(params)
        if params[:file_path]
          play_song(params[:file_path], params[:background])
        elsif params[:directory]
          UI.message("Playing all songs from directory '#{params[:directory]}'")
          Dir[File.join(params[:directory], "*.{mp3,aac,adts,ac3,aif,aiff,aifc,caf,mp4,m4a,snd,au,sd2,wav}")].each do |current|
            # on directory mode no background sound
            play_song(current, false)
          end
        else
          UI.user_error!("Please provide either a file_path or a directory")
        end
      end

      def self.play_song(path, background)
        Helper::TunesHelper.print_audio_information(path)
        if background
          Thread.new do
            sh "afplay #{path.shellescape}"
          end
          at_exit do
            `killall -9 afplay 2>&1`
            exit
          end
        else
          sh "afplay #{path.shellescape}"
        end
      end

      def self.description
        "Play music using fastlane, because you can"
      end

      def self.authors
        ["neonichu"]
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :file_path,
                                  env_name: "TUNES_FILE_PATH",
                               description: "Specify the path of the audio file to play",
                                  optional: true,
                                      type: String,
                              verify_block: proc do |value|
                                UI.user_error!("Couldn't find file at path '#{value}'") unless File.exist?(value)
                              end,
                               conflicting_options: [:directory],
                                     conflict_block: proc do |value|
                                       UI.user_error!("Please only provide a path or a directory")
                                     end),
          FastlaneCore::ConfigItem.new(key: :directory,
                                  env_name: "TUNES_DIRECTORY",
                               description: "Specify the path to a folder that should be played",
                                  optional: true,
                                      type: String,
                                      verify_block: proc do |value|
                                        UI.user_error!("Couldn't find directory at path '#{value}'") unless File.directory?(value)
                                      end),
          FastlaneCore::ConfigItem.new(key: :background,
                                  env_name: "TUNES_BACKGROUND",
                               description: "Play sound in background",
                                  is_string: false,
                                  optional: true)

        ]
      end

      def self.is_supported?(platform)
        %i[ios mac android caros rocketos napos].include?(platform)
      end
    end
  end
end
