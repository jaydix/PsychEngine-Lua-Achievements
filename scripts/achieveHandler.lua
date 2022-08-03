-- For some reason this functions as both the achievements menu and the achievement backend.
-- I'm a dumbass.

local achs = {}
-- local save = {}
local selected = 1
local sprites = 0
local saveKey = 'achievements'
local unlockedStuff = {}

local mod = ''
local modAchievementFile = 'achievements.txt'
local achieveName = '125.76.90.254, see you soon'

local isAwardsSong = false


function onCreate() -- initalization
    achieveName = getPropertyFromClass('Paths', 'currentModDirectory')
    -- achieveName = 'awards'
    if (songName:lower() == 'awards') and (achieveName == 'awards') then -- for the menu stuff
        isAwardsSong = true
    end
    -- debugPrint(isAwardsSong)

    if (isAwardsSong) then
        playMusic(getPropertyFromClass('ClientPrefs', 'pauseMusic'):lower():gsub(" ", "-"))
    end

    addHaxeLibrary("CoolUtil", '') -- for haxe stuff
    -- debugPrint('added util')

    -- luaDebugMode = true
    initSaveData(saveKey, "8bits-shit") -- SAVE DATA

    -- setPropertyFromClass('Paths','currentModDirectory',mod)

    -- the system for pushing new achievements
    local achString = getTextFromFile('achievements/achievements.txt') 
    runHaxeCode("var path = 'modsList.txt';")
    setMod(1)

    local modAchievements = getTextFromFile('achievements/' .. modAchievementFile)
    if (modAchievements ~= achString) then
        if (checkFileExists('achievements/' .. modAchievementFile)) then
            achString = achString .. '\n' .. modAchievements
        end
    else
        mod = ''
    end
    setPropertyFromClass('Paths', 'currentModDirectory', achieveName)
    local achArray = split(achString, '\n')
    local toPush = {}
    for i = 1, #achArray do
        table.insert(toPush, split(achArray[i], '|'))
    end
    achs = toPush

    -- old save data method, doesn't work

    -- local string = getTextFromFile('achievements/save-data.txt')
    -- local array = split(string, '\n')
    -- save = array
    -- -- debugPrint(save)

    -- debugPrint(isAwardsSong)
end

function setMod(add) -- very messy, tries to load a nearby mod
    runHaxeCode("var toSet = CoolUtil.coolTextFile(path);")
    runHaxeCode("var i = toSet.indexOf('" .. achieveName .. "|1') + " .. add .. ";")
    runHaxeCode("if(toSet[i] == null) i -= " .. add + 1 .. ";")
    runHaxeCode('var isEnabled = true;')
    runHaxeCode("if(toSet[i].split('|')[1] == '0') i -= ("..add.."+1);")
    runHaxeCode("if(toSet[i].split('|')[1] == '0') i -= 1;")
    runHaxeCode("if(toSet[i].split('|')[1] == '0') isEnabled = false;")
    runHaxeCode("if(isEnabled) toSet = toSet[i].split('|')[0];")
    runHaxeCode('if(isEnabled) Paths.currentModDirectory = toSet;')
    runHaxeCode('if(!isEnabled) Paths.currentModDirectory = "' .. achieveName .. '";')
    mod = getPropertyFromClass('Paths', 'currentModDirectory')
    -- debugPrint('mod: ', mod)
    setPropertyFromClass('Paths', 'currentModDirectory', mod)
    -- debugPrint('hmm: ', checkFileExists('achievements/' .. modAchievementFile))
    if (checkFileExists('achievements/' .. modAchievementFile) == false) then
        -- runHaxeCode("toSet.splice(i);")
        -- runHaxeCode("i -= 1;")
        -- runHaxeCode("if(toSet[i] == null) i += 2;")
        setMod(add + 1)
    end
end

function onCreatePost() -- all the menu.
    if (isAwardsSong) then
        -- unlockAchievement('steps', true)
        callOnLuas('unlockAchievement', {"steps", false}) -- GLOBAL YAYAYAYAYYAYAAYAYAYAYAYAYAYAYAYA

        local x = 50
        local y = 110

        makeLuaText('cursor', 'v', 400, 0, 0)
        setTextSize('cursor', 32)
        setTextFont('cursor', 'pixel.otf')
        setTextBorder('cursor', 0)
        -- setProperty('camOther.alpha',0)
        setObjectCamera('cursor', 'other')
        addLuaText('cursor')

        makeLuaText('name', 'sussy amongus imposter at 3 am', screenWidth, 0, screenHeight - 120)
        setTextSize('name', 32)
        setObjectCamera('name', 'other')
        addLuaText('name')

        makeLuaText('desc', 'go to C:/Windows and delete system32', screenWidth, 0, screenHeight - 90)
        setTextSize('desc', 32 / 1.5)
        setTextBorder('desc', 2, '000000')
        setObjectCamera('desc', 'other')
        addLuaText('desc')

        for i = 1, #achs do
            local a = achs[i]
            local tag = a[2]

            if (getDataFromSave(saveKey, tag) == tag) then
                setDataFromSave(saveKey, tag, false)
            end

            local unlocked = getDataFromSave(saveKey, tag, false)
            -- local unlocked = false
            --[[if (save[i] == nil) then
            local text = getTextFromFile('achievements/save-data.txt') .. '\n' .. tag .. ':false'
            -- debugPrint('text: ', text)
            --runHaxeCode("var AAAA = " .. text .. ";")
            -- runHaxeCode('sys.io.File.saveContent(Paths.mods("achievements/save-data.txt"),AAAA);')
            --saveFile('./mods/'..achieveName..'/achievements/save-data.txt',text)
            -- debugPrint('SAVED:: ', getTextFromFile('achievements/save-data.txt'))
        end]]

            local hidden = string.find(a[4], "true")
            if (hidden and unlocked) then
                hidden = false
            end

            -- debugPrint('unlocked: ', unlocked)

            table.insert(unlockedStuff, unlocked)

            if (not hidden) then
                sprites = sprites + 1
                makeLuaSprite('ach' .. sprites, 'achievements/' .. tag, x, y)
                setPropertyFromClass('Paths', 'currentModDirectory', mod)
                loadGraphic('ach' .. sprites, 'achievements/' .. tag)
                setPropertyFromClass('Paths', 'currentModDirectory', achieveName)
                if (unlocked == false) then
                    loadGraphic('ach' .. sprites, 'achievements/lockedachievement')
                end
                scaleObject('ach' .. sprites, 0.75, 0.75)
                setObjectCamera('ach' .. sprites, 'camOther')
                addLuaSprite('ach' .. sprites, true)

                x = x + 150

                if (x > 1200) then
                    x = 50
                    y = y + 135
                end
            end
        end
    end
end

function onUpdate() -- also the menu
    if (isAwardsSong) then
        setProperty('cursor.x', getProperty('ach' .. selected .. '.x') - 140)
        setProperty('cursor.y', getProperty('ach' .. selected .. '.y') - 35)
        if (getPropertyFromClass('flixel.FlxG', 'keys.justPressed.RIGHT')) then
            playSound('scrollMenu')
            selected = selected + 1
        end
        if (getPropertyFromClass('flixel.FlxG', 'keys.justPressed.LEFT')) then
            playSound('scrollMenu')
            selected = selected - 1
        end
        if (selected < 1) then
            selected = sprites
        end
        if (selected > sprites) then
            selected = 1
        end

        setTextString('name', achs[selected][1])
        setTextString('desc', achs[selected][3])

        if (unlockedStuff[selected] == false) then
            setTextString('name', 'Locked Achievement')
        end
    end
end

function unlockAchievement(tag, mod, force) -- backend, call this in other songs
    if (not botPlay) then
        local _force = force
        if (_force == nil) then
            _force = false
        end

        local unlocked = achievementUnlocked(tag)
        if ((not unlocked) or force) then
            setDataFromSave(saveKey, tag, true)
            popup(tag, mod)
            playSound('confirmMenu')
            flushSaveData(saveKey)
            return true;
            -- debugPrint('unlocked: ', tag)
        end
    end
end

function achievementUnlocked(tag)
    return getDataFromSave(saveKey, tag, false)
end

function popup(tag, modToGrabImage)
    makeLuaSprite('unlock', null, 20, 20)
    makeGraphic('unlock', 400, 125, '000000')
    setObjectCamera('unlock', 'other')
    addLuaSprite('unlock', true)

    setPropertyFromClass('Paths', 'currentModDirectory', modToGrabImage)
    makeLuaSprite('image', 'achievements/' .. tag, 30, 22.5)
    scaleObject('image', 0.8, 0.8)
    setObjectCamera('image', 'other')
    addLuaSprite('image', true)
    setPropertyFromClass('Paths', 'currentModDirectory', achieveName)

    makeLuaText('unlocked', 'Achievement Unlocked!', 300, 125, 35)
    setTextSize('unlocked', 20)
    setObjectCamera('unlocked', 'other')
    addLuaText('unlocked')

    local info = {}
    for i = 1, #achs do
        if (achs[i][2] == tag) then
            info = achs[i]
        end
    end
    -- debugPrint(info)

    makeLuaText('info', info[1] .. '\n' .. info[3], 300, 147.5, 60)
    setTextAlignment('info', 'left')
    setObjectCamera('info', 'other')
    addLuaText('info')

    setProperty('unlock.alpha', 0)
    setProperty('image.alpha', 0)
    setProperty('unlocked.alpha', 0)
    setProperty('info.alpha', 0)

    doTweenAlpha('unlockAlpha', 'unlock', 1, 0.5)
    doTweenAlpha('imageAlpha', 'image', 1, 0.5)
    doTweenAlpha('unlockedAlpha', 'unlocked', 1, 0.5)
    doTweenAlpha('infoAlpha', 'info', 1, 0.5)

    runTimer('achievement_destroy', 3)
end

function onTimerCompleted(t)
    if (t == 'achievement_destroy') then
        doTweenAlpha('unlockAlpha', 'unlock', 0, 0.5)
        doTweenAlpha('imageAlpha', 'image', 0, 0.5)
        doTweenAlpha('unlockedAlpha', 'unlocked', 0, 0.5)
        doTweenAlpha('infoAlpha', 'info', 0, 0.5)
        runTimer('clearAchievements', 0.5)
    end
    if (t == 'clearAchievements') then
        removeLuaSprite('unlock')
        removeLuaSprite('image')
        removeLuaText('unlocked')
        removeLuaText('info')
    end
end

-- helper functions
function split(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t = {}
    for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
        table.insert(t, str)
    end
    return t
end

function indexOf(array, value)
    for i, v in ipairs(array) do
        if v == value then
            return i
        end
    end
    return nil
end

function setContains(set, key)
    return set[key] ~= nil
end
