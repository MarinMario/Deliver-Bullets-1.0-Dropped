extends CanvasLayer

onready var title = $Container/Control/Title
onready var paused = false
onready var options_show = false

func _ready():
	get_tree().paused = false
	$Container.rect_size = get_viewport().size
	$Container/Control/buttons/next.disabled = true


func _process(delta):
	if get_parent().health <= 0:
		title.text = "Eyyy! You screwed up..."
		$end_screen_timer.start()
	elif global.enemies_in_scene <= 0: 
		title.text = "Nice! You did it..."
		$Container/Control/buttons/next.disabled = false
		$end_screen_timer.start()
	elif options_show:
		title.text = "Options"
	else:
		title.text = "Paused"


func _on_next_pressed():
	var next_level = str(global.curent_level + 1)
	var next_scene = "res://scenes/levels/level" + next_level+ ".tscn"
	get_tree().change_scene(next_scene)


func _on_restart_pressed():
	get_tree().reload_current_scene()


func _on_pause_pressed():
	pause()

func pause():
	paused = !paused
	if paused:
		$anims.play("menu")
	elif options_show:
		$anims.play_backwards("options")
		paused = !paused
		options_show = !options_show
	else:
		$anims.play_backwards("menu")
	
	get_tree().paused = paused

func _on_options_pressed():
	options_show = !options_show
	if options_show:
		$anims.play("options")
	else:
		$anims.play_backwards("options")

func _on_exit_pressed():
	get_tree().paused = false
	get_tree().change_scene("res://scenes/main_menu/main_menu.tscn")

func _on_end_screen_timer_timeout():
	print("LEVEL STOP")
	#pause()
