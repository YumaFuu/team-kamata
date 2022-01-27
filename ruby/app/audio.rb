require "pathname"
require "./external/empath"

class AudioAnalyzer
  def self.call(file)
    aa = new

    begin
      wavfile = aa.mp4_to_wav(file)
      result = aa.analyze_emotion(wavfile)

      result
    rescue => e
      raise "#{self.name} Faild: #{e}"
    end
  end

  def mp4_to_wav(filepath)
    wavpath = Pathname.new(filepath).sub_ext ".wav"

    cmd = "ffmpeg -i '#{filepath.to_s}' -ac 2 -f wav '#{wavpath.to_s}'"
    system cmd

    wavpath
  end


  def analyze_emotion(wavfile)
    # call empath api
    Empath.call(wavfile)
    {
      "attr1": [*0..10].sample,
      "attr2": [*0..10].sample,
      "attr3": [*0..10].sample,
    }
  end
end
