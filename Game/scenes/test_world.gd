extends Node2D

func _process(delta):
	if Input.is_action_just_pressed("ui_page_down"):
		OS.window_fullscreen = true
	if Input.is_action_just_pressed("ui_page_up"):
		OS.window_fullscreen = false