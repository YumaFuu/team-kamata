import React from "react";
import { Route, Routes, BrowserRouter, Link } from "react-router-dom";
import Video from "./Video"
import Analyze from "./Analyze"

function App() {
  return (
    <BrowserRouter>
    <div>
      
      <h1>嘘つくのやめてもらっていいですか？</h1>
      <ul>
        <li><Link to="/video">動画投稿</Link></li>
        <li><Link to="/analyze">分析</Link></li>
      </ul>
      <hr />

        <Routes>
        <Route path="analyze" element={<Analyze />} />
        <Route path="video" element={<Video />} />
        </Routes>

    </div>
    </BrowserRouter>
  );
}

export default App;
