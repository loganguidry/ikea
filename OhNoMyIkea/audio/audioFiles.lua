
-- LOAD SOUND EFFECTS AND MUSIC HERE

Sounds = {
	["Start Game"] = audio.loadSound("audio/sfx/interface/dustbin.ogg"),
	["Place Furniture"] = audio.loadSound("audio/sfx/interface/snap.ogg"),
	["Place Wall"] = audio.loadSound("audio/sfx/interface/snap.ogg"),
	["Catch Fire"] = audio.loadSound("audio/sfx/spells/explode4.ogg"),
	["Game Over"] = audio.loadSound("audio/sfx/spells/cheer.ogg"),
}
audio.play(audio.loadSound("audio/sfx/spells/cheer.ogg"))

Music = {
	["Gameplay"] = audio.loadStream("audio/music/gameplay.mp3")
}