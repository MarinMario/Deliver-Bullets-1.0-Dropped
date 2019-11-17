extends Node2D

var mouse
var state = "nothing"
var fire_rate = 0
var fire_timer = 0
var fire_time = 0
var fire_allowed = false

func _process(delta):
	mouse = get_global_mouse_position()
	self.look_at(mouse)
	$gun.look_at(mouse)
	
	#$gun.play(state)