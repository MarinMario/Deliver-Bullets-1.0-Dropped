extends AnimatedSprite

var fire_rate: float
var state: String

func _process(delta):
	state = get_parent().weapon_state
	self.play(state)
	
	if state == "pistol":
		fire_rate = 0.5
	elif state == "machine_gun":
		fire_rate = 0.1
