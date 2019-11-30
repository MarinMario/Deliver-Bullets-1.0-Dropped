extends KinematicBody2D

var motion := Vector2(0,0)
var speed := 300
var anim := "idle"
var weapon_state: String
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
	global.player_health -= 5
	for i in 10:
		var blood_splatter = global.BLOOD_SPLATTER.instance()
		blood_splatter.spawn_blood(global_position, 1000, 100, 0.2)
		get_parent().add_child(blood_splatter)
		#p_a += 10
	
	$Camera2D.camera_shake()
	
	if global.player_health <= 0:
		die()
	#print("particle amount: " + str(p_a))

func die():
	speed = 0
	$CollisionShape2D.disabled = true
	$anims.play("die")
	
	#get_tree().reload_current_scene()






