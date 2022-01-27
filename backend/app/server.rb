require "pry"
require "json"

require "./app/analyzer"


class Server
  def call(env)
    begin
      f = env.dig("MULTIPART_CONTENT", "file")

      result = MainAnalyzer.(f)

      res result.to_json
    rescue => e
      b = { message: "failed: #{e}" }.to_json

      res b, 500
    end
  end

  private
  def res(body, status = 200)
    header = {
        "Access-Control-Allow-Origin" => "*",
        "Access-Control-Allow-Methods" =>
          %w(GET POST PUT PATCH OPTIONS DELETE) * ",",
        "Access-Control-Allow-Headers" =>
          %w(Content-Type Accept Auth-Token Authorization Access-Control-Allow-Origin) * ",",
        "Content-Type" => "application/json",

    }
    [status, header, [body]]
  end
end
