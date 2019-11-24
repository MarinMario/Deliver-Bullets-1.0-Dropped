extends KinematicBody2D

var motion := Vector2(0,0)
var speed := 300
var anim := "idle"
var weapon_state: String

func _physics_process(delta):
	global.player_pos = self.global_position
	
	#movement
	motion = Vector2(0,0)
	
	if Input.is_action_pressed("ui_right"):
		motion.x += 1
	if Input.is_action_pressed("ui_left"):
		motion.x -= 1
	if Input.is_action_pressed("ui_down"):
		motion.y += 1
	if Input.is_action_pressed("ui_up"):
		motion.y -= 1
		
	if Input.is_action_pressed("ui_select"):
		take_damage()
	
	move_and_slide(motion.normalized() * speed)
	
	#animations
	$body_container/body_sprite.play(anim)
	
	if motion != Vector2(0,0):
		anim = "walk"
	else:
		anim = "idle"
	
	if motion.x < 0:
			$body_container.scale.x = -1
	elif motion.x > 0:
			$body_container.scale.x = 1

func take_damage():
	global.player_health -= 5
	var blood_particles = global.BLOOD_PARTICLES.instance()
	add_child(blood_particles)







