extends MobConstructor

func _ready():
	pass
	
	
func _process(delta):
	node_to_anim($Sprite)
	node_to_flip($Sprite)