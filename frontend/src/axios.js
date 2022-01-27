import axios from "axios";

const instance = axios.create({
    "baseURL": "http://0.0.0.0:9000",
})

export default instance