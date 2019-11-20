extends CanvasLayer

var player: Node

func _process(delta):
	player = get_parent().get_node("body_container/player_hand")
	$ammo.text = "ammo: " + str(player.in_use_ammo)  + "/" + str(player.ammo) 