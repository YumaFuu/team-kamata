import React from "react";
import { Route, Routes, BrowserRouter, Link } from "react-router-dom";
import Video from "./Video"
import Analyze from "./Analyze"

function App() {
  return (
    <BrowserRouter>
    <div style={{ marginLeft: 20 }}>

      <h1>嘘つくのやめてもらっていいですか？</h1>
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
