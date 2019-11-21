extends Area2D

export var weapon_state: String
var pick_allow := false
var play_key = false

func _ready():
	#weapon_state = "pistol"
	pass

func _process(delta):
	$gun.play(weapon_state)
	
	if Input.is_action_just_pressed("action_key") and pick_allow:
		pick_up()
	
	$anims.play("key")
	if play_key:
		$key.visible = true
	else:
		$key.visible = false
	
func pick_up():
	if weapon_state in global.player_weapons:
		add_ammo()
	else:
		add_weapon()
	
	self.queue_free()

func add_ammo():
	if weapon_state == "pistol":
		global.player_pistol_ammo += 30
	elif weapon_state == "machine_gun":
		global.player_mg_ammo += 30
	
	print(global.player_mg_ammo)

func add_weapon():
	global.player_weapons.push_back(weapon_state)
	add_ammo()

func _on_weapon_item_body_entered(body):
	if body.name == "player":
		pick_allow = true
		play_key = true

func _on_weapon_item_body_exited(body):
	if body.name == "player":
		pick_allow = false
		play_key = false
