extends Area2D

var mouse: Vector2
var cursor_color := Color(0.9, 0.9, 0.9)

func _process(delta):
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	mouse = get_global_mouse_position()
	self.global_position = mouse
	
	$cursor_sprite.modulate = cursor_color
	

func _on_crosshair_body_entered(body):
	if body.is_in_group("interacting"):
		cursor_color = Color(0.8, 0, 0)

func _on_crosshair_body_exited(body):
	cursor_color = Color(0.9, 0.9, 0.9)
