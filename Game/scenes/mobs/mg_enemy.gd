extends MobConstructor

func _ready():
	weapon_state = "machine_gun"
	health = 100
	detect_target_range = 500
	
func _process(delta):
	node_to_anim($body/Sprite)
	node_to_flip($body)