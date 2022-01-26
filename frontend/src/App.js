import { Route, Routes, BrowserRouter, Link } from "react-router-dom";

function App() {
  return (
    <div>
      <p>嘘つくのやめてもらっていいですか？</p>
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

function Analyze() {
  return (
    <h1>分析！</h1>
  )
}

function Video() {
  return (
    <h1>動画投稿</h1>
  )
}
export default App;
