import React from "react";
import {
    Chart as ChartJS,
    CategoryScale,
    LinearScale,
    PointElement,
    LineElement,
    Title,
    Tooltip,
    Legend,
  } from 'chart.js';

  import { Line } from 'react-chartjs-2';

ChartJS.register(
    CategoryScale,
    LinearScale,
    PointElement,
    LineElement,
    Title,
    Tooltip,
    Legend
  );

export const Analyze = () => {
  const labels = ["1 月", "2 月", "3 月", "4 月", "5 月", "6 月"];
  const graphData = {
    labels: labels,
    datasets: [
      {
        label: "A社",
        data: [65, 59, 60, 81, 56, 55],
        borderColor: "rgb(75, 192, 192)",
      },
      {
        label: "B社",
        data: [60, 55, 57, 61, 75, 50],
        borderColor: "rgb(75, 100, 192)",
      },
    ],
  };

  const options = {
    maintainAspectRatio: false,
  };

  const divStyle = {
    marginLeft: "auto",
    marginRight: "auto",
    margin: "10px",
    width: "500px",
  };

  return (
    <div className="App" style={divStyle}>
      <Line
        height={300}
        width={300}
        data={graphData}
        options={options}
        id="chart-key"
      />
    </div>
  );
}

export default Analyze;