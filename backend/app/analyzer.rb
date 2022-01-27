require "./app/audio"
require "./app/movie"

class MainAnalyzer
  def self.call(file)
    f = file[:tempfile]

    audioresult = AudioAnalyzer.call(f.path)
    movieresult = MovieAnalyzer.call(f.path)

    {
      audio: audioresult,
      movie: movieresult,
    }
  end
end
