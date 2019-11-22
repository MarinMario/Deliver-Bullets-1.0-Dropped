extends KinematicBody2D

var motion: Vector2
var speed := 100
var target: Vector2
var change_pos_timer := 2.0

var anim := "idle"

func _physics_process(delta):
	change_pos_timer += delta
	if change_pos_timer > 1:
		target = global.player_pos
		change_pos_timer = 0
	
	motion = (target - position).normalized() * speed
	move_and_slide(motion)
	
	#animation
	
	$body_container/body_sprite.play(anim)
	if motion.x < 0:
		$body_container.scale.x = -1
	else:
		$body_container.scale.x = 1
	
	if motion != Vector2(0,0):
		anim = "walk"
	
	