extends Area2D

export var state: String

func _process(delta):
	$gun.play(state)

func _on_weapon_item_body_entered(body):
	if body.name == "player":
		global.player_weapons.push_front(state)
		self.queue_free()