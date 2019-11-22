extends KinematicBody2D

export var weapon_state: String

var follow_player := false

var motion: Vector2
var speed := 100
var target: Vector2
var change_pos_timer := 2.0
var do_command_timer := 0.0

var anim := "idle"

func _physics_process(delta):
	change_pos_timer += delta
	if change_pos_timer > 1 and follow_player:
		target = global.player_pos
		change_pos_timer = 0

	if follow_player:
		motion = (target - position).normalized()
		$body_container/mob_hand/hand.look_at(target)
	else:
		do_command_timer += delta
		if do_command_timer > 1:
			do_command()
			do_command_timer = 0
	
	move_and_slide(motion * speed)
	for i in range(get_slide_count()):
		var collision = get_slide_collision(i)
	
	#animation
	
	$body_container/mob_hand/gun.play(weapon_state)
	$body_container/body_sprite.play(anim)
	if motion.x < 0:
		$body_container.scale.x = -1
	else:
		$body_container.scale.x = 1
	
	if motion != Vector2(0,0):
		anim = "walk"
	else:
		anim = "idle"
	
	
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

func _on_line_of_sight_body_exited(body):
	if body.name == "player":
		follow_player = false