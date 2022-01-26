import React, { useCallback, useRef } from "react";
import instance from './axios';
import requests from './requests';

export const Video = () => {
    const ref = useRef(null);

    const onPostForm = useCallback(async(data) => {
        try {
            const params = new FormData();
            Object.keys(data).forEach(function(key) {
                params.append(key, this[key]);
            }, data);

            const res = await instance.post(requests.postVideo, params, {
                headers: {
                    'Content-Type': 'multipart/form-data',
                },
            });
            console.log(res);
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
        </div>
    )
}

export default Video;