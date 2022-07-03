function onStartCountdown()
    return Function_Stop;
end

function onUpdatePost()
    if(getPropertyFromClass('flixel.FlxG','keys.justPressed.ESCAPE'))then
        endSong()
    end
end