require "pathname"
require "./app/external/empath"

class AudioAnalyzer
  def self.call(file)
    aa = new

    begin
      wavfiles = aa.mp4_to_wavs(file)
      result = aa.analyze_emotion(wavfiles)

      result
    rescue => e
      raise "#{self.name} Faild: #{e}"
    end
  end

  def mp4_to_wavs(filepath)
    10.times.map do |i|
      t = 0.5 * i

      wavpath = Pathname.new(filepath).sub_ext "#{i}.wav"
      cmd = "ffmpeg -ss #{t} -t 0.5 -i '#{filepath.to_s}' -ar 11025 -ac 1 -f wav '#{wavpath.to_s}'"
      system cmd

      {
        file: wavpath,
        time: t,
      }
    end
  end


  def analyze_emotion(wavfiles)
    wavfiles.map do |wavfile|
      file = wavfile[:file]
      time = wavfile[:time]

      data = Empath.(file)
      {
        "time": time,
        "data": data,
      }
    end
  end
end
