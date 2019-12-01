extends CanvasLayer

func _ready():
	$menu.rect_position.y = 1000
	$anim.play("ready_menu")


func _on_play_pressed():
	get_tree().change_scene("res://scenes/test_world.tscn")


func _on_exit_pressed():
	get_tree().quit()


func _on_options_pressed():
	pass
