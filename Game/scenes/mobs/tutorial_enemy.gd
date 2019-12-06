extends MobConstructor

var add_dialog = true

func _ready():
	mob_type = "melee"
	weapon_state = "nothing"

func _process(delta):
	node_to_anim($body/Sprite)
	node_to_flip($body)
	
	if health <= 0 and add_dialog:
		var dialog = global.DIALOG_BOX.instance()
		dialog.lines = PoolStringArray(["You killed your first enemy!"])
		add_child(dialog)
		add_dialog = false