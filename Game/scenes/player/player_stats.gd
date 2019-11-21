extends CanvasLayer

var player: Node
var in_use_ammo: String
var ammo: String

func _process(delta):
	player = get_parent().get_node("body_container/player_hand")
	
	
	#set text for ammo bar
	if player.in_use_ammo < 10:
		in_use_ammo = "0" + str(player.in_use_ammo)
	else:
		in_use_ammo = str(player.in_use_ammo)
	
	if player.ammo < 10:
		ammo = "0" + str(player.ammo)
	else:
		ammo = str(player.ammo)
	
	$ammo/in_use_ammo.text = str(in_use_ammo)
	$ammo/remaining_ammo.text = str(ammo)
	
	$anims.play("r_key")
	if player.in_use_ammo == 0 and player.ammo > 0:
		$ammo/key.visible = true
	else:
		$ammo/key.visible = false
	
	
	#set health bar
	$health/health_bar.value = global.player_health
	
	#set in use gun
	$weapon.play(player.weapon_state)
	
	
	