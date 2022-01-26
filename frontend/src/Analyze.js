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

export const Analyze = (props) => {
    const labels = ["0秒", "5秒", "10秒", "15秒", "20秒", "25秒", "30秒", "35秒", "40秒", "45秒", "50秒", "55秒", "1分"];
    const graphData = {
        labels: labels,
        datasets: [
            {
                label: "動画",
                data: [65, 59, 60, 81, 56, 55, 65, 59, 60, 81, 56, 55, 64],
                borderColor: "rgb(75, 192, 192)",
            },
            {
                label: "音声",
                data: [60, 55, 57, 61, 75, 50, 65, 59, 60, 81, 56, 55, 71],
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
        <div style={divStyle}>
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