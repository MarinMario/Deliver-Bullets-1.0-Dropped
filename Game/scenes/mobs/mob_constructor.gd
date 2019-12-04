extends KinematicBody2D

class_name MobConstructor

var target := Vector2()
var direction := Vector2()
var motion := Vector2(0,0)

export var init_speed := 200
var speed := 200
export var detect_target_range := 500
export var health := 100
export var mob_type := "ranged"

export var fire_rate := 1.0
export var fire_timer := 0.0

export var change_pos_timer := 0.0
export var max_distance_to_target := 200
export var change_pos_time := 1.0

var follow_target := false
var can_shoot := false

var rand_motion: Vector2
export var choose_rand_motion_timer := 0.0
export var rand_motion_time := 1.0

func _process(delta):
	
	change_pos_timer += delta
	if change_pos_timer >= change_pos_time:
		target = global.player.global_position
		change_pos_timer = 0
	if self.global_position.distance_to(target) <= max_distance_to_target:
		speed = 0
	else:
		speed = init_speed
	
	direction = (target-global_position).normalized()
	
	when_follow_target()
	if follow_target:
		motion = direction * speed
	else:
		choose_rand_motion_timer += delta
		if choose_rand_motion_timer >= rand_motion_time:
			rand_motion = Vector2(rand_range(-1,1), rand_range(-1,1))
			choose_rand_motion_timer = 0
		
		motion = rand_motion * speed
	
	move_and_slide(motion)
	
	
	
func when_follow_target():
	if global_position.distance_to(target) <= detect_target_range:
		follow_target = true
	else:
		follow_target = false

func node_to_anim(node_to_anim: Node2D):
	var anim: String
	if health > 0:
		anim = "idle" if motion == Vector2() else "move"
	else:
		anim = "die"
	
	node_to_anim.play(anim)

func node_to_flip(node_to_flip: Node2D):
	if motion.x > 0:
		node_to_flip.scale.x = 1
	elif motion.x < 0:
		node_to_flip.scale.x = -1
		
		
		
		
		
		