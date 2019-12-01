extends KinematicBody2D

var motion := Vector2(0,0)
var speed := 300
var anim := "idle"
var weapon_state: String
var slow_mo_timer := 5.0
#var p_a: int = 0

func _ready():
	global.player_health = 100
	#speed = 300
	#$CollisionShape2D.disabled = false

func _physics_process(delta):
	global.player_pos = self.global_position
	
	#movement
	motion = Vector2(0,0)
	if global.player_health > 0 and not Input.is_action_pressed("move_camera"):
		if Input.is_action_pressed("ui_right"):
			motion.x += 1
		if Input.is_action_pressed("ui_left"):
			motion.x -= 1
		if Input.is_action_pressed("ui_down"):
			motion.y += 1
		if Input.is_action_pressed("ui_up"):
			motion.y -= 1
	
	
	if Input.is_action_pressed("slow_time") and slow_mo_timer > 0:
		Engine.set_time_scale(0.1)
		slow_mo_timer -= 10 * delta if slow_mo_timer > 0 else 0
	else:
		slow_mo_timer += delta if slow_mo_timer < 10 else 0
		Engine.set_time_scale(1.0)
		
	if Input.is_action_pressed("ui_select"):
		get_tree().reload_current_scene()
	
	move_and_slide(motion.normalized() * speed)
	
	#animations
	$body_container/body_sprite.play(anim)
	
	if motion == Vector2(0,0):
		anim = "idle"
	else:
		anim = "walk"
	
	if motion.x < 0:
			$body_container.scale.x = -1
	elif motion.x > 0:
			$body_container.scale.x = 1

func take_damage():
	global.player_health -= 1
		#p_a += 10
	$Camera2D.camera_shake(5, 1)
	
	if global.player_health <= 0:
		die()
	#print("particle amount: " + str(p_a))

func die():
	speed = 0
	$CollisionShape2D.disabled = true
	$anims.play("die")
	self.z_index = 0
	
	#get_tree().reload_current_scene()






