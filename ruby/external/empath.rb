require 'net/http'
require 'uri'

class Empath
  API_URL = "https://api.webempath.net/v2/analyzeWav"
  API_KEY = ENV["EMPATH_API_KEY"]

  def self.call(file)
    uri = URI.parse(API_URL)

    req = Net::HTTP::Post.new(uri)
    req.body = JSON.dump({
      "apikey" => API_KEY,
    })

    req_options = {
      use_ssl: uri.scheme == "https",
    }

    res = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
      http.request(req)
    end

    binding.pry
    # res.code
    # res.body
  end
end
