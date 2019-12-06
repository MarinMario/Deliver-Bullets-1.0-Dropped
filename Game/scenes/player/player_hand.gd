extends Node2D

var target := Vector2(0,0)
var weapon_state := "hand"
var fire_timer := 0.0
var allow_fire := false

var ammo: int

var num := 0

func _process(delta):
	if global.player.health > 0:
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

func shoot():
	var bullet = global.BULLET.instance()
	bullet.init_pos = $shoot_point.global_position
	bullet.target = target
	bullet.bullet_type = weapon_state
	get_parent().get_parent().get_parent().add_child(bullet)
	
	if weapon_state == "pistol":
		global.player.pistol_ammo -= 1
	elif weapon_state == "machine_gun":
		global.player.mg_ammo -= 1
	
	fire_timer = 0


func change_weapon():
	num += 1
	if num > global.player.weapons.size() - 1:
		num = 0
	if num < 0:
		num = global.player.weapons.size() - 1
	weapon_state = global.player.weapons[num]

func ammo_manager():
	if weapon_state == "pistol":
		ammo = global.player.pistol_ammo
	elif weapon_state == "machine_gun":
		ammo = global.player.mg_ammo
	else:
		ammo = 0
	
	
	allow_fire = true if ammo > 0 and global.player.health > 0 else false
	global.player.ammo = ammo




