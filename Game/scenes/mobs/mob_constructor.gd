extends KinematicBody2D

class_name MobConstructor

onready var target := global.player
onready var target_pos := target.global_position
var direction := Vector2()
var motion := Vector2(0,0)

export var init_speed := 200
var speed := 200
export var detect_target_range := 500
export var health := 100
export var mob_type := "ranged"
export var weapon_state := "pistol"

var change_pos_timer := 0.0
export var max_distance_to_target := 200
export var change_pos_time := 1.0

var follow_target := false
var can_shoot := false
var allow_melee_attack := false

var rand_motion: Vector2
var choose_rand_motion_timer := 0.0
export var rand_motion_time := 1.0

func _process(delta):
	randomize()
	
	if health > 0:
		target = global.player
		change_pos_timer += delta
		if change_pos_timer >= change_pos_time:
			target_pos = target.global_position
			change_pos_timer = 0
		if self.global_position.distance_to(target_pos) <= max_distance_to_target and target.health > 0:
			speed = 0
		else:
			speed = init_speed
	
		direction = (target_pos-self.global_position).normalized()
	
		when_follow_target()
		if follow_target:
			motion = direction * speed
		else:
			choose_rand_motion_timer += delta if get_slide_count() < 1 else 10
			if choose_rand_motion_timer >= rand_motion_time:
				rand_motion = Vector2(rand_range(-1,1), rand_range(-1,1))
				choose_rand_motion_timer = 0
			
			motion = rand_motion * speed
	
		move_and_slide(motion)
	
		check_shoot()
		#check_melee_attack()
	
	
func when_follow_target():
	if global_position.distance_to(target_pos) <= detect_target_range and target.health > 0:
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

func check_shoot():
	if mob_type == "ranged" and follow_target:
		can_shoot = true
	else:
		can_shoot = false

func check_melee_attack():
	if mob_type == "melee" and follow_target:
		if self.global_position.distance_to(target_pos) <= max_distance_to_target + 10:
			allow_melee_attack = true
	else:
		allow_melee_attack = false

func take_damage():
	health -= 1
	follow_target = true if health > 0 and target.health > 0 else false
	can_shoot = true if health > 0 and target.health > 0 else false
	spawn_blood(3)
	if health <= 0:
		die()

func die():
	spawn_blood(20)
	can_shoot = false
	follow_target = false
	$CollisionShape2D.disabled = true
	$anims.play("die")
	pass


func spawn_blood(amount):
	for i in amount:
		var blood_splatter = global.BLOOD_SPLATTER.instance()
		blood_splatter.spawn_blood(global_position, 1000, 100, 0.4)
		get_parent().add_child(blood_splatter)