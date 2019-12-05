extends CanvasLayer

var scene_to_change := "res://scenes/main_menu/main_menu.tscn"
var allow_change_scene := false

func _ready():
	$back_button.visible = false
	allow_change_scene = false
	$container.rect_position.y = 1000
	$title.rect_position.x = -1000
	$anim.play("ready")
	

func _process(delta):
	if allow_change_scene:
		get_tree().change_scene(scene_to_change)
	

func _on_anim_animation_finished(anim_name):
	if anim_name == "despawn":
		print("allow_change_scene = true")
		allow_change_scene = true
		

func _on_back_button_pressed():
	scene_to_change = "res://scenes/main_menu/main_menu.tscn"
	$anim.play("despawn")
 