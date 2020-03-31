extends Sprite

var mouse: Vector2

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func _process(delta):
	mouse = get_global_mouse_position()
	self.global_position = mouse
