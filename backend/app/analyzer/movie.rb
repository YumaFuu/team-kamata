require "pathname"
require "./app/external/aws"

class MovieAnalyzer
  def self.call(file)
    ma = new

    begin
      pngfiles = ma.mp4_to_pngs(file)
      result = ma.analyze_emotion(pngfiles)

      result
    rescue => e
      raise "#{self.name} Faild: #{e}"
    end
  end

  def mp4_to_pngs(filepath)
    # 1image / 500ms * 10
    10.times.map do |i|
      pngpath = Pathname.new(filepath).sub_ext "#{i}.png"
      t = 0.5 * i

      system "ffmpeg -ss #{t} -i '#{filepath.to_s}' -r 1 -f  image2 -t 1 -vframes 1 '#{pngpath}'"

      {
        file: pngpath,
        time: t,
      }
    end
  end

  def analyze_emotion(pngfiles)
    pngfiles.map do |pngfile|
      file = pngfile[:file]
      time = pngfile[:time]

      data = AWS.(file)

      {
        "time": time,
        "data": data,
      }
    end
  end
end
