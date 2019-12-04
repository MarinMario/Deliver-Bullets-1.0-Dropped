extends KinematicBody2D

var motion := Vector2(0,0)
var speed := 300
var anim := "idle"
var weapon_state: String
var slow_mo_timer := 5.0
var dash_anim := "dash1"
var dash = 1000
#var p_a: int = 0
var dash_timer := 0.0

func _ready():
	global.player_health = 150
	global.player = self
	#speed = 300
	#$CollisionShape2D.disabled = false

func _physics_process(delta):
	dash_timer += delta
	
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
		if Input.is_action_just_pressed("ui_select") and dash_timer > 0.5:
			$anims.play(dash_anim)
		
		if $anims.is_playing():
			if anim == "dash1" or "dash2":
				speed = 600
		else:
			speed = 300
		
	if Input.is_action_pressed("slow_time") and slow_mo_timer > 0:
		Engine.set_time_scale(0.1)
		slow_mo_timer -= 10 * delta if slow_mo_timer > 0 else 0
	else:
		slow_mo_timer += delta if slow_mo_timer < 10 else 0
		Engine.set_time_scale(1.0)
		
	if Input.is_action_pressed("ui_end"):
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
			dash_anim = "dash1"
	elif motion.x > 0:
			$body_container.scale.x = 1
			dash_anim = "dash2"

func take_damage():
	spawn_blood(3)
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
	
	#get_tree().change_scene("res://scenes/main_menu/main_menu.tscn")


func spawn_blood(amount):
	for i in amount:
		var blood_splatter = global.BLOOD_SPLATTER.instance()
		blood_splatter.spawn_blood(global_position, 1000, 100, 0.4)
		get_parent().add_child(blood_splatter)