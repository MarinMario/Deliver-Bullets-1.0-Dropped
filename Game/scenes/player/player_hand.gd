extends Node2D

var mouse: Vector2
var state := "machine_gun"
var fire_rate := 0
var fire_timer: float = 0
var fire_time := 0
var fire_allowed := false

var BULLET = preload("res://scenes/other/bullet.tscn")

func _process(delta):
	mouse = get_global_mouse_position()
	
	self.look_at(mouse)
	#$gun.look_at(mouse)
	
	#$gun.play(state)
	fire_timer += delta
	if fire_timer > fire_rate:
		fire_allowed = true
		fire_timer = 0
	#gun_manager()
	if Input.is_action_pressed("shoot") and fire_allowed:
		
		print(fire_timer)
		
		shoot()

func shoot():
	var bullet = BULLET.instance()
	bullet.init_pos = $shoot_point.global_position
	bullet.target = mouse
	bullet.speed = 100
	get_parent().get_parent().get_parent().add_child(bullet)

func gun_manager():
	if state == "nothing":
		fire_allowed = false
	elif state == "pistol":
		fire_allowed = true
		fire_rate = 0.25
	elif state == "machine_gun":
		fire_allowed = true
		fire_rate = 5
		