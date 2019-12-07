extends Area2D

export var next_level := 2


func _on_next_level_body_entered(body):
	if body.name == "player":
		get_tree().change_scene("res://scenes/levels/level" + str(next_level) + ".tscn")
