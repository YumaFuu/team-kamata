require "dotenv/load"
require "aws-sdk"

Aws.config.update({
  region: 'ap-northeast-1',
  credentials: Aws::Credentials.new(
    ENV["AWS_ACCESS_KEY"],
    ENV["AWS_SECRET_KEY"],
  ),
})

class MultipartParser
  def initialize(app)
    @app = app
  end

  def call(env)
    if env["CONTENT_TYPE"] =~ /multipart\/form-data/
      params = Rack::Multipart.parse_multipart(env).to_h

      env["MULTIPART_CONTENT"] = params
    end

    @app.(env)
  end
end
use MultipartParser

require "./app/server"
run Server.new
