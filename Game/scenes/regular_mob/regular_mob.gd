extends KinematicBody2D

export var weapon_state: String

var follow_player := false

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
		if position.distance_to(target) > 100:
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
	
	if motion == Vector2(0,0) and health > 0:
		anim = "idle"
	elif health <= 0:
		anim = "die"
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
	var blood_particles = global.BLOOD_PARTICLES.instance()
	add_child(blood_particles)
	if health <= 0:
		die()

func die():
	$CollisionShape2D.disabled = true
	$line_of_sight/CollisionShape2D.disabled = true
	follow_player = false
	$anims.play("die")



