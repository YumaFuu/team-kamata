require "pathname"

class MovieAnalyzer
  BUCKET = "team-kamata"
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

  def initialize
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
    now = Time.now.to_s.split
    dir = "#{now[0]}/#{now[1].split(":").join}"

    pngfiles.map do |pngfile|
      file = pngfile[:file]
      time = pngfile[:time]

      client = Aws::S3::Client.new
      key = "#{dir}/#{file.basename.to_s}"

      client.put_object(
        bucket: BUCKET,
        key: key,
        body: File.open(file),
        content_type: "image/png",
      )

      rekog = Aws::Rekognition::Client.new
      result = rekog.detect_faces({
        image: {
          s3_object: {
            bucket: BUCKET,
            name: key,
          },
        },
        attributes: ["ALL"],
      })


      # 顔は1つだけの想定
      detail = result.face_details.first

      data = {}
      detail.emotions&.each{ |emo| data[emo.type&.downcase] = emo.confidence }

      {
        "time": time,
        "data": data,
      }
    end
  end
end
