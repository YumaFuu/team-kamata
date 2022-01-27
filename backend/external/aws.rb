class AWS
  BUCKET = "team-kamata"

  def self.call(file)
    client = Aws::S3::Client.new

    now = Time.now.to_s.split
    dir = "#{now[0]}/#{now[1].split(":").join}"
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

    data
  end
end
