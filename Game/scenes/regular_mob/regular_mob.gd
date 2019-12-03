extends KinematicBody2D

export var weapon_state: String

var follow_player := false
var alive := true

var motion: Vector2
var speed := 200
var target: Vector2
var change_pos_timer := 0.0
var change_pos_value := 1.0
var do_command_timer := 0.0
var can_shoot := false
var attack_timer := 0
var distance_from_player := 200
var mob_type := "melee"

var anim := "idle"
var health := 100

func _physics_process(delta):
	change_pos_timer += delta
	
	change_pos_value = 1 if mob_type == "ranged" else 0.5
	
	if change_pos_timer > change_pos_value and follow_player:
		target = global.player_pos
		change_pos_timer = 0
	if follow_player and health > 0:
		motion = (target - position).normalized()
		$body_container/mob_hand.look_at(target)
		if position.distance_to(target) > distance_from_player:
			speed = 300
		else:
			speed = 0.0001
	else:
		speed = 150
		do_command_timer += delta if get_slide_count() < 1 else 3
	
		if do_command_timer > 2 and health > 0:
			do_command()
			do_command_timer = 0
	
	#if mob_type == "melee":
	for collision in get_slide_count():
			var body = get_slide_collision(collision).collider
			if body.name == "player" and mob_type == "melee":
				$anims.play("attack")
	
	if health <= 0: speed = 0
	move_and_slide(motion * speed)
	
	#animation
	$body_container/mob_hand/gun.play(weapon_state)
	$body_container/body_sprite.play(anim)
	if motion.x < 0:
		$body_container.scale.x = -1
	else:
		$body_container.scale.x = 1
	
	choose_mob()

func do_command():
	randomize()
	motion = Vector2(rand_range(-1,1), rand_range(-1,1))

func choose_mob():
	var die_anim
	var idle_anim
	var walk_anim
	if weapon_state == "bat":
		die_anim = "melee_die"
		idle_anim = "melee_idle"
		walk_anim = "melee_walk"
		distance_from_player = 10
		mob_type = "melee"
	else:
		die_anim = "die"
		idle_anim = "idle"
		walk_anim = "walk"
		distance_from_player = 200
		mob_type = "ranged"
	
	if health <= 0:
		anim = die_anim
	elif speed < 1:
		anim = idle_anim
	else:
		anim = walk_anim
	
	

func _on_line_of_sight_body_entered(body):
	if body.name == "player":
		follow_player = true
		can_shoot = true

func _on_line_of_sight_body_exited(body):
	if body.name == "player":
		follow_player = false
		can_shoot = false

func take_damage():
	health -= 1
	follow_player = true if health > 0 else false
	can_shoot = true if health > 0 else false
	if health <= 0 and alive:
		die()
	
	global.camera.camera_shake(5, 1)

func die():
	alive = false
	
	$CollisionShape2D.disabled = true
	$line_of_sight/CollisionShape2D.disabled = true
	follow_player = false
	
	#drop weapon
	var weapon_item = global.WEAPON_ITEM.instance()
	var gun = $"body_container/mob_hand/gun"
	var random_pos = rand_range(30,70)
	weapon_item.weapon_state = weapon_state
	weapon_item.global_position = gun.global_position + Vector2(random_pos, random_pos)
	get_parent().add_child(weapon_item)
	
	
	$anims.play("die")
	self.z_index = -2
	weapon_state = "nothing"

func _on_anims_animation_finished(anim_name):
	if anim_name == "attack":
		for i in 10:
			global.player.take_damage()
