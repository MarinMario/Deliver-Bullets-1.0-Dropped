extends Node2D

var mouse: Vector2
var weapon_state := "nothing"
var fire_timer = 0

var num := 0

var BULLET = preload("res://scenes/other/bullet.tscn")

func _process(delta):
	mouse = get_global_mouse_position()
	
	self.look_at(mouse)
	#$gun.look_at(mouse)
	
	$gun.play(weapon_state)
	fire_timer += delta
	if Input.is_action_pressed("shoot") and fire_timer > $gun.fire_rate:
		shoot()
		fire_timer = 0
	
	#weapon change mechanic
	if Input.is_action_just_pressed("change_weapon"):
		num += 1
		#print(global.player_weapons)
	if num > global.player_weapons.size() - 1:
		num = 0
	if num < 0:
		num = global.player_weapons.size() - 1
	weapon_state = global.player_weapons[num]
	
func shoot():
	var bullet = BULLET.instance()
	bullet.init_pos = $shoot_point.global_position
	bullet.target = mouse
	bullet.weapon_state = weapon_state
	get_parent().get_parent().get_parent().add_child(bullet)
