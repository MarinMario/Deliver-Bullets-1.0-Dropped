extends KinematicBody2D

export var weapon_state: String

var follow_player := false
var alive := true

var motion: Vector2
var speed := 300
var target: Vector2
var change_pos_timer := 2.0
var do_command_timer := 0.0
var can_shoot := false

var anim := "idle"
var health := 100

func _physics_process(delta):
	change_pos_timer += delta
	if change_pos_timer > 1 and follow_player:
		target = global.player_pos
		change_pos_timer = 0
	if follow_player and health > 0:
		motion = (target - position).normalized()
		$body_container/mob_hand.look_at(target)
		if position.distance_to(target) > 200:
			speed = 300
		else:
			speed = 0.0001
	else:
		speed = 200
		do_command_timer += delta
		if do_command_timer > 2 and health > 0:
			do_command()
			do_command_timer = 0
	
	if health <= 0: speed = 0
	move_and_slide(motion * speed)
	
	#animation
	$body_container/mob_hand/gun.play(weapon_state)
	$body_container/body_sprite.play(anim)
	if motion.x < 0:
		$body_container.scale.x = -1
	else:
		$body_container.scale.x = 1
	
	if health <= 0:
		anim = "die"
	elif speed < 1:
		anim = "idle"
	else:
		anim = "walk"


func do_command():
	randomize()
	var random_command: int = rand_range(0,6)
	if random_command == 0:
		motion.y = 1
	elif random_command == 1:
		motion.x = 1
	elif random_command == 2:
		motion.y = -1
	elif random_command == 3:
		motion.x = -1
	elif random_command in [4,5,6]:
		motion = Vector2(0,0)

func _on_line_of_sight_body_entered(body):
	if body.name == "player":
		follow_player = true
		can_shoot = true

func _on_line_of_sight_body_exited(body):
	if body.name == "player":
		follow_player = false
		can_shoot = false

func attack():
	$anims.play("attack")

func take_damage():
	health -= 5
	var blood_scale := 0.2 if health > 0 else 0.5
	for i in 10:
		var blood_splatter = global.BLOOD_SPLATTER.instance()
		blood_splatter.spawn_blood(global_position, 1000, 100, blood_scale)
		get_parent().add_child(blood_splatter)
	if health <= 0 and alive:
		die()

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