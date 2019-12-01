extends CanvasLayer

var option_on := false

func _ready():
	$menu.rect_position.y = 1000
	$options_tab.rect_position.x = 2000
	$anim.play("ready_menu")


func _on_play_pressed():
	get_tree().change_scene("res://scenes/test_world.tscn")


func _on_exit_pressed():
	get_tree().quit()


func _on_options_pressed():
	if option_on:
		$anim.play_backwards("option_menu")
		option_on = false
	else:
		$anim.play("option_menu")
		option_on = true
