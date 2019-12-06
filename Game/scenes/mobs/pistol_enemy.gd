extends MobConstructor

func _process(delta):
	node_to_anim($body/Sprite)
	node_to_flip($body)