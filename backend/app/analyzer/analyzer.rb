require "./app/analyzer/audio"
require "./app/analyzer/movie"

class Analyzer
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
