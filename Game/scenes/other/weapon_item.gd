extends Area2D

export var weapon_state: String

func _ready():
	#weapon_state = "pistol"
	pass

func _process(delta):
	$gun.play(weapon_state)

func _on_weapon_item_body_entered(body):
	if body.name == "player":
		self.queue_free()
		if weapon_state in global.player_weapons:
			add_ammo()
		else:
			add_weapon()

func add_ammo():
	if weapon_state == "pistol":
		global.player_pistol_ammo += 30
	elif weapon_state == "machine_gun":
		global.player_mg_ammo += 30
	
	print(global.player_mg_ammo)

func add_weapon():
	global.player_weapons.push_back(weapon_state)
	add_ammo()