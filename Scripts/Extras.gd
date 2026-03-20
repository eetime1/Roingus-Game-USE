extends Control

var textShrooms = [
'
Pathshroom: 
Not the brightest knife in the shed. Upon first hearing ‘there’s not mushroom in here’ for 
the first time, Pathshroom made it his life’s ambition to make as much room for him and 
his mycelium friends as he possibly could. Just as you can rely on him to take a joke 
literally or blankly smile along to a conversation he doesn’t even slightly understand, 
you can rely on him to eagerly form a path and hold the line when called upon in times 
of turmoil. 
',

'
Plainshroom: 
"I am... the night." the Plainshroom said, looking out over the forest. "An unsung hero -  
a warrior who fights for what is right, whenever the world needs me." The Plainshroom 
peeked back over his shoulder to make sure nobody had noticed that he was out 
of bed at this hour. He continued, "and today... it really needs me."  
He paused. 
"And today... the world needs a… savior?"  
He shook his head. He\'ll work on it.
',

'
Sporeshroom: 
Quick to temper, and didn’t his mushroom colleagues know it. Short in 
stature and rather sick of being called a ‘spore loser’, Sporeshroom had developed 
quite the Napoleon complex, though he was careful to not lash out at those around him. 
When the Chief Roingus called upon the mushrooms to prepare to fight the fires and 
whatever lurks within them, Sporeshroom was among the first in line, eager to get it all 
out of his system. 
All the spores. 
He shoots spores from his mouth. 
It’s just how he lets off steam.
',
 
'
Wallshroom:  
Ever since she was a spore, Wallshroom had always been bigger than the rest of her                           
shroomfolk, and often faced adversity. Playground bullying really tore down poor 
Wallshroom’s confidence. She often found comfort in escapism, and naturally found her 
way into the fandom of comic book heroes. Comics, replicas, memorabilia - she built a 
proud collection of anything that gave her the feeling that being big and strong was a 
boon, not something to be teased for. When the fires came for the forest, Wallshroom 
knew what she had to do - her body may be vast, but her courage is moreso. (She is 
not crying at the thought of the impending inferno, rather that her beloved copy of 
‘SuperRoing vs MushMan #12’ is now a pile of ash’) 
',

'
Healshroom: 
Healshroom was in a constant state of flux - eager to please and lived to make friends 
with the animals of the forest, but was quick to push any that came too close away. This 
was sensible, as his poisonous spines were potent enough to take down an elephant if 
rubbed up the wrong way, though it resulted in quite a lonely existence. 
'
]

var textRoingus = [
'
Roingus:  
The humble roingus. 
A creature with such a spring in its step, it was named after the ‘sproing’ it makes when 
hopping from place to place. 
Look at ‘em go. 
Brilliant. 
',

'
Roingus Civilians: 
The typical roingus was a natural home-maker, and spent most of its time burrowing, 
building shelter, and foraging for food. Roingus society was a very communal one and 
had few internal disputes - it focused its energy towards issues concerning climate, 
grain storage, and avoiding owls. 
',

'
Roingus (Full of gems):  
The normally desert-dwelling roingus didn’t take much time to get used to the digging 
terrain of the woods. Quite soon after the arrival of the First Roingu, the Mining And 
Digging Co-operative Under Natural Terrain union formed between the roingus and 
other woodland creatures. While at first a diplomatic treaty for digging creatures to pool 
their assets together, after some time, the moles parted ways from the alliance. Mingus 
Mudview, head of the Mole Clan, decided to separate from the group to pursue a 
capitalistic endeavour in selling dirt. When asked why he made the move, he said, ‘it’s 
simple - I’m a soil man.’ 
'
]

var textSpaces = ['
Homeshroom:  
The greatest mushroom in the forest, so it was told, the Homeshroom was maintained 
by the mystical workings of the Roingu Arch-Shaman and acted as a base for all key 
roingus activity, apart from burrowing. The roingus believed that the Homeshroom held 
the Spirit of the Woods within it and that, as long as they respected and tended to the 
shroom, their village would remain safely under its protective aura. Also, little beetles 
were found under the gills of the shroom, and oh boy were they good eatin’. 
',

'
Burrows: 
Too hot outside? Dig a burrow. 
Too cold outside? Dig a burrow. 
Hiding in the nighttime? Dig a burrow. 
Sleeping in the daytime? Dig a burrow. 
Need a feeding site? Dig a burrow. 
Need a place to raise the young? Dig a burrow. 
If you aren’t a fan of burrows, visiting the Roingu village should not make it onto your 
bucket list. 
',

'
Mycelium:  
Met one mycelium, you’ve met them all. Literally. This hive mind network operates on a 
level of consciousness that no single roingus fully understands. In the olden days, 
before the roingus were accustomed to this land, a Shaman overindulged in a rather 
unique crop of mushroom and claimed to have communed with the mycelium and had 
gained a vast knowledge of the inner workings of mushroom society. Unfortunately, the 
old Shaman conked out before he could write any of it down and had forgotten it all 
upon waking up. The Roingu were not a scientifically-minded species by nature, so no 
further studies had been done - they just had a vague sense that, somehow, the 
mycelium had their back.
'
, '']

var devExtrasText = ['', '', '', '', '', '']

var activeText = textShrooms

func _buttonCall(button) -> void:
	_reset()
	match (button):
		"shrooms":
			$Grey/MarginContainer/Panel/MarginContainer/Items/ShroomsGrid.visible = true
			activeText = textShrooms
			pass
		"roingus":
			$Grey/MarginContainer/Panel/MarginContainer/Items/RoingusGrid.visible = true
			activeText = textRoingus
			pass
		"spaces":
			$Grey/MarginContainer/Panel/MarginContainer/Items/Landmarks.visible = true
			activeText = textSpaces
			pass
		"devextras":
			$Grey/MarginContainer/Panel/MarginContainer/Items/DevExtras.visible = true
			activeText = devExtrasText
			pass
		
func _reset() -> void:
	$Grey/MarginContainer/Panel/MarginContainer/Items/ShroomsGrid.visible = false
	$Grey/MarginContainer/Panel/MarginContainer/Items/RoingusGrid.visible = false
	$Grey/MarginContainer/Panel/MarginContainer/Items/Landmarks.visible = false
	$Grey/MarginContainer/Panel/MarginContainer/Items/DevExtras.visible = false
	
func _deeperButtonCall(button) -> void:
	$Grey/MarginContainer/Panel/MarginContainer2/Descriptions/RichTextLabel.text = activeText[button]


func _returnToMenu() -> void:
	get_tree().change_scene_to_file("res://Scenes/Levels/MainMenu.tscn")
