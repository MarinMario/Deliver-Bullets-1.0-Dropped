extends KinematicBody2D

var motion := Vector2(0,0)
var speed := 300
var anim := "idle"

func _physics_process(delta):
	global.player_pos= self.global_position
	
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
		
	if Input.is_action_just_pressed("ui_select"):
		global.player_health -= rand_range(1,10)
	
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
