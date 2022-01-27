require 'net/http'
require 'uri'
require 'net/http/post/multipart'

class Empath
  API_URL = "https://api.webempath.net/v2/analyzeWav"
  API_KEY = ENV["EMPATH_API_KEY"]

  def self.call(file)
    url = URI.parse(API_URL)

    r = nil
    File.open(file) do |jpg|
      req = Net::HTTP::Post::Multipart.new url.path,
        "apikey" => API_KEY,
        "wav" => UploadIO.new(jpg, "audio/wav", "data.wav")

      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = (url.scheme == "https")

      res = http.request(req).body
      r = JSON.parse res
    end

    r
  end
end
