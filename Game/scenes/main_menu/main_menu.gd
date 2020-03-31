extends CanvasLayer

var option_on := false

func _ready():
	$menu.rect_position.y = 1000
	$options_tab.rect_position.x = 2000
	$CenterContainer.rect_position.x = -1800
	$anim.play("ready_menu")


func _on_play_pressed():
		$anim.play("despawn")


func _on_exit_pressed():
	get_tree().quit()


func _on_options_pressed():
	if option_on:
		$anim.play_backwards("option_menu")
		option_on = false
	else:
		$anim.play("option_menu")
		option_on = true


func _on_anim_animation_finished(anim_name):
	if anim_name == "despawn":
		get_tree().change_scene("res://scenes/main_menu/levels.tscn")
