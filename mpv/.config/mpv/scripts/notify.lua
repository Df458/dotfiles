require "os";

function on_pause_change(name, value)
    if value == true then
        notify_pause();
    else
        notify_play();
    end
end

function notify_play()
    title = mp.get_property_native("filename");
    if title == nil then
        return;
    end
    os.execute("notify-send -i 'media-playing' 'Now Playing' '" .. title .. "'");
end

function notify_pause()
    title = mp.get_property_native("filename");
    if title == nil then
        return;
    end
    os.execute("notify-send -i 'media-paused' 'Now Paused' '" .. title .. "'");
end

mp.observe_property("pause", "bool", on_pause_change)
mp.get_property_bool("pause");
if pause == false then
    mp.add_timeout(1, notify_play);
end
