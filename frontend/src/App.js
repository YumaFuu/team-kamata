import { Route, Routes, BrowserRouter } from "react-router-dom";
import Video from "./Video"
import Analyze from "./Analyze"

function App() {
  return (
    <div>
      <h1>嘘つくのやめてもらっていいですか？</h1>
    <p>
      <a href="video">動画投稿</a>
    </p>
    <p>
      <a href="analyze">分析</a>
    </p>
    <hr />

    <BrowserRouter>
      <Routes>
      <Route exact path="analyze" element={<Analyze />} />
      <Route path="video" element={<Video />} />
      </Routes>
    </BrowserRouter>

    </div>
  );
}

export default App;
