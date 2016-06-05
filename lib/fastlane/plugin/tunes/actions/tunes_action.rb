module Fastlane
  module Actions
    class TunesAction < Action
      def self.run(params)
        if params[:file_path]
          sh "afplay '#{params[:file_path]}'"
          return
        end

        spotify = File.join(`bundle show fastlane-plugin-tunes`.chomp, 'script', 'shpotify', 'spotify')

        if params[:spotify_song]
          play = params[:spotify_song]
        elsif params[:spotify_artist]
          play = params[:spotify_artist]
        elsif params[:spotify_album]
          play = params[:spotify_album]
        end
        sh "#{spotify} play #{play}" if play
      end

      def self.description
        "Play music using fastlane, because you can."
      end

      def self.authors
        ["Boris Bügling", "David Ohayon"]
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :file_path,
                                  env_name: "TUNES_FILE_PATH",
                               description: "Specify the path of the audio file to play",
                                  optional: true,
                                      type: String),
          FastlaneCore::ConfigItem.new(key: :spotify_artist,
                                  env_name: "TUNES_SPOTIFY_ARTIST",
                               description: "Specify the artist to play in Spotify",
                                  optional: true,
                                      type: String),
          FastlaneCore::ConfigItem.new(key: :spotify_album,
                                  env_name: "TUNES_SPOTIFY_ALBUM",
                               description: "Specify the album to play in Spotify",
                                  optional: true,
                                      type: String),
          FastlaneCore::ConfigItem.new(key: :spotify_song,
                                  env_name: "TUNES_SPOTIFY_SONG",
                               description: "Specify the song to play in Spotify",
                                  optional: true,
                                      type: String)
        ]
      end

      def self.is_supported?(platform)
        [:ios, :mac, :android, :caros, :rocketos, :napos].include?(platform)
      end
    end
  end
end
