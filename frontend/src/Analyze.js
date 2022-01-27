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
    const labels = props.time;

    const graphData = {
        labels: labels,
        datasets: [
            {
                label: "動画",
                data: props.movie,
                borderColor: "rgb(75, 192, 192)",
            },
            {
                label: "音声",
                data: props.audio,
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