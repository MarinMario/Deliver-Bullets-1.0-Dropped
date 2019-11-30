extends Node2D

var target := Vector2(0,0)
var weapon_state := "hand"
var fire_timer := 0.0
var allow_fire := false
var allow_reload := false
var is_reloading := false

var ammo: int
var in_use_ammo: int

var in_use_pistol_ammo: int
var in_use_mg_ammo:int

var num := 0

func _process(delta):
	if global.player_health > 0:
		target = get_global_mouse_position()
		self.look_at(target)
	#$gun.look_at(mouse)
	
	$gun.play(weapon_state)
	ammo_manager()
	fire_timer += delta
	if Input.is_action_pressed("shoot") and fire_timer > $gun.fire_rate and allow_fire:
		shoot()
	if Input.is_action_just_pressed("change_weapon"):
		change_weapon()
	if Input.is_action_just_pressed("reload") and allow_reload:
		is_reloading = true
		print("reloading...")
		yield(get_tree().create_timer(2.0), "timeout")
		reload()
		is_reloading = false

func shoot():
	var bullet = global.BULLET.instance()
	bullet.init_pos = $shoot_point.global_position
	bullet.target = target
	bullet.bullet_type = weapon_state
	get_parent().get_parent().get_parent().add_child(bullet)
	
	if weapon_state == "pistol":
		in_use_pistol_ammo -= 1
	elif weapon_state == "machine_gun":
		in_use_mg_ammo -= 1
	
	fire_timer = 0

func reload():
	var max_ammo = 30
	var reload_ammo = max_ammo - in_use_ammo
	if ammo >= reload_ammo and in_use_ammo < max_ammo:
		if weapon_state == "pistol":
			in_use_pistol_ammo += reload_ammo
			global.player_pistol_ammo -= reload_ammo
		elif weapon_state == "machine_gun":
			in_use_mg_ammo += reload_ammo
			global.player_mg_ammo -= reload_ammo
		else:
			in_use_ammo = 0

func change_weapon():
	num += 1
	if num > global.player_weapons.size() - 1:
		num = 0
	if num < 0:
		num = global.player_weapons.size() - 1
	weapon_state = global.player_weapons[num]

func ammo_manager():
	if weapon_state == "pistol":
		ammo = global.player_pistol_ammo
		in_use_ammo = in_use_pistol_ammo
	elif weapon_state == "machine_gun":
		ammo = global.player_mg_ammo
		in_use_ammo = in_use_mg_ammo
	else:
		ammo = 0
		in_use_ammo = 0
	
	if global.player_health > 0:
		if in_use_ammo == 0 or is_reloading:
			allow_fire = false
		else:
			allow_fire = true
	
		if is_reloading or ammo == 0:
			allow_reload = false
		else:
			allow_reload = true
	else:
		allow_reload = false
		allow_fire = false




