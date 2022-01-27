require "dotenv/load"

module Middleware
  class MultipartParser
    def initialize(app)
      @app = app
    end

    def call(env)
      if env["CONTENT_TYPE"] =~ /multipart\/form-data/
        params = Rack::Multipart.parse_multipart(env).to_h

        env["MULTIPART_CONTENT"] = params
      end

      @app.call(env)
    end
  end
end
use Middleware::MultipartParser

require "./app/server"
run Server.new
