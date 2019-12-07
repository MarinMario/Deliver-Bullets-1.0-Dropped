extends Node2D

var dialog1_spawned := false
var dialog2_spawned := false

func _ready():
	yield(get_tree().create_timer(1.0), "timeout")
	spawn_dialog([
				"You can use WASD to move",
			])
	

func _process(delta):
	
	if "pistol" in global.player.weapons and not dialog1_spawned:
		dialog1_spawned = true
		spawn_dialog([
			"Now you have to press TAB to switch to it"
		])
	
	if "pistol" in global.player.weapons and not dialog2_spawned:
		if Input.is_action_just_pressed("change_weapon"):
			dialog2_spawned = true
			spawn_dialog([
				"Good. Now it's time to kill the enemy!",
			 	"Press left click to shoot"
			])


func spawn_dialog(lines):
	var dialog = global.DIALOG_BOX.instance()
	dialog.lines = PoolStringArray(lines)
	add_child(dialog)
