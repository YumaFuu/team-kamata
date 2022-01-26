require "pry"
require "json"

require "./app/analyzer"


class Server
  def call(env)

    begin
      f = env.dig("MULTIPART_CONTENT", "file")

      result = MainAnalyzer.call(f)

      res result.to_json
    rescue => e
      b = { message: "failed: #{e}" }.to_json

      res b, 500
    end
  end

  private
  def res(body, status = 200)
    [status, {"Content-Type" => "application/json"}, [body]]
  end
end
