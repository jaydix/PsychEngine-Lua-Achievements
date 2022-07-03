function onCreate()
    --setProperty('camHUD.visible',false)
    
    local width = screenWidth
    local height = 75

    makeLuaSprite('bg','menuDesat',0,0)
    setProperty('bg.color',getColorFromHex('FF8000'))
    setObjectCamera('bg','other')
    addLuaSprite('bg',true)

    makeLuaSprite('border',null,0,0)
    makeGraphic('border',width,height,'000000')
    setProperty('border.alpha',0.5)
    setObjectCamera('border','other')
    addLuaSprite('border',true)

    runHaxeCode('var title = new Alphabet(0,12.5,"awards",true,false,0,0.8);')
    runHaxeCode('title.x = FlxG.width/2.5;')
    runHaxeCode('title.cameras = [game.camOther];')
    runHaxeCode('game.add(title);')

    height = 125
    makeLuaSprite('textbg',null,0,screenHeight-height)
    makeGraphic('textbg',width,height,'000000')
    setProperty('textbg.alpha',0.5)
    setObjectCamera('textbg','other')
    addLuaSprite('textbg',true)
end