extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var next_level = 1
var title
var paused = false
var options_show = false

# Called when the node enters the scene tree for the first time.
func _ready():
	next_level = get_parent()
	$Container.rect_size = get_viewport().size
	title = $Container/Control/Title
	
	


func _process(delta):
	if get_parent().health <= 0:
		title.text = "Eyyy! You screwed up..."
	elif get_parent().health > 0:
		title.text = "Nice! You did it..."

func _on_next_pressed():
	get_tree().change_scene("res://scenes/levels/level1.tscn")


func _on_restart_pressed():
	get_tree().reload_current_scene()


func _on_pause_pressed():
	paused = !paused
	if paused:
		$anims.play("menu")
	else:
		if options_show:
			$anims.play_backwards("options")
			paused = !paused
			options_show = !options_show
		else:
			$anims.play_backwards("menu")


func _on_options_pressed():
	options_show = !options_show
	if options_show:
		$anims.play("options")
	else:
		$anims.play_backwards("options")


func _on_exit_pressed():
	get_tree().change_scene("res://scenes/main_menu/main_menu.tscn")
