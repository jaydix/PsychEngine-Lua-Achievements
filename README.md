**PSYCH ENGINE 0.6.1+ REQUIRED!!**

# hi what is this
psych engine lua achievements: what the devs could never do

## how add achievement1!?1?1?1?1?1?1!!!?1?1?!1!?
in your mod's folder (so PsychEngine/mods/Your Mod), make a folder called achievements

then make a file called `achievements.txt`

the file follows this format:

`Name|Image/Save Data Tag|Description|Hidden (true/false)`

each line is another achievement

you can name everything whatever you want except for `hidden`, which is either `true` or `false`

if `hidden` is `true`, the achievement will not be visible until you unlock it

### images time
now, make a folder in images, also called achievements

inside this folder, you can make an image file and name it the same as the tag you put into `achievements.txt`

if you need a base for your image, you can use [this](https://raw.githubusercontent.com/ShadowMario/FNF-PsychEngine/main/art/flashFiles/emptyAchievement.png) template.

now you've made an achievement, and-

![image](https://user-images.githubusercontent.com/75950907/177055561-dbf60caf-e2de-425b-9fa3-f9bc97bf3649.png)

oh. right. it's locked.

## unlocking achievements
to unlock an achievement, use `callOnLuas('unlockAchievement', {"achievement-tag", getPropertyFromClass('Paths', 'currentModDirectory'), false})`

if you want to unlock an achievement at the end of a song, use [this](https://raw.githubusercontent.com/8bitjake/PsychEngine-Lua-Achievements/main/achievement.lua) template

and boom, your achievement should be unlocked!

![image](https://user-images.githubusercontent.com/75950907/177055911-2092b745-dfeb-4aab-ab80-157da158d2b3.png)
