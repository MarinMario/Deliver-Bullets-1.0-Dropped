extends CanvasLayer

var player: Node
var in_use_ammo: String
var ammo: String
var slow_time_value: float

func _process(delta):
	player = get_parent().get_node("body_container/player_hand")
	
	
	#set text for ammo bar
	
	$ammo/in_use_ammo.text = str(player.ammo)
	
	$anims.play("r_key")
	if player.ammo > 0:
		$ammo/key.visible = false
	else:
		$ammo/key.visible = true
	
	
	#set health bar
	$health/health_bar.value = global.player.health
	
	#set in use gun
	$weapon.play(player.weapon_state)
	
	#set slow mo time
	slow_time_value = get_parent().slow_mo_timer
	$slow_mo/slow_mo_bar.value = slow_time_value
	
	
	
