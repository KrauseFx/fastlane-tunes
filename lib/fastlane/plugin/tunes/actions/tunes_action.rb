require 'shellwords'
module Fastlane
  module Actions
    class TunesAction < Action
      def self.run(params)
        if params[:file_path]
          play_song(params[:file_path])
        elsif params[:directory]
          UI.message("Playing all songs from directory '#{params[:directory]}'")
          Dir[File.join(params[:directory], "*.{mp3,aac,adts,ac3,aif,aiff,aifc,caf,mp4,m4a,snd,au,sd2,wav}")].each do |current|
            play_song(current)
          end
        else
          UI.user_error!("Please provide either a file_path or a directory")
        end
      end

      def self.play_song(path)
        Helper::TunesHelper.print_audio_information(path)
        sh "afplay #{path.shellescape}"
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
                                      end)

        ]
      end

      def self.is_supported?(platform)
        [:ios, :mac, :android, :caros, :rocketos, :napos].include?(platform)
      end
    end
  end
end
