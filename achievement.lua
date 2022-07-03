local allowEnd = false
function onEndSong()
    if (not botPlay) then
        -- Block the first countdown and start a timer of 0.8 seconds to play the dialogue
        if (not allowEnd) and misses == 0 and (not getDataFromSave('achievements', 'cat', false)) then
            setProperty('inCutscene', true);
            callOnLuas('unlockAchievement', {"cat", getPropertyFromClass('Paths', 'currentModDirectory'), true})
            allowEnd = true;
            runTimer('endSongFromAchievement', 4)
            return Function_Stop;
        end
    end
    return Function_Continue;
end

function onTimerCompleted(tag, loops, loopsLeft)
    if tag == 'endSongFromAchievement' then -- Timer completed, play dialogue
        endSong()
    end
end

function onCreate()
    initSaveData(saveKey, "8bits-shit")
end
