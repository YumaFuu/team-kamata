import React, { useCallback, useRef, useState } from "react";
import Analyze from "./Analyze";
import instance from './axios';
import requests from './requests';

export const Video = () => {
    const ref = useRef(null);
    const [audio, setAudio] = useState();
    const [movie, setMovie] = useState();
    const [time, setTime] = useState();

    const onPostForm = useCallback(async(data) => {
        try {
            const params = new FormData();
            Object.keys(data).forEach(function(key) {
                params.append(key, this[key]);
            }, data);
            
            instance.interceptors.request.use(request => {
                console.log('Starting Request: ', request)
                return request
            })
            instance.interceptors.response.use(response => {
                console.log('Response: ', response)
                return response
            })

            const res = await instance.post(requests.postVideo, params, {
                headers: {
                    'Content-Type': 'multipart/form-data',
                },
            });

            const j = JSON.parse(JSON.stringify(res.data))
            const t = j.movie.map(obj => obj.time + "秒")
            const m = j.movie.map(obj => obj.data.happy)
            const a = j.audio.map(obj => obj.data.joy)

            setTime(t)
            setAudio(a)
            setMovie(m)
        } catch(err) {
            console.log(err);
        }
    }, []);

    const onSubmitHandler = useCallback((e) => {
        e.preventDefault();
        onPostForm({
            file: ref.current.files[0],
        });
    }, [onPostForm]);

    return (
        <div>
            <form onSubmit={onSubmitHandler}>
                <input type="file" accept="video/*" ref={ref} />
                <input type="submit" value="送信" />
            </form>
            <Analyze audio={audio} movie={movie} time={time} />
        </div>
    )
}

export default Video;