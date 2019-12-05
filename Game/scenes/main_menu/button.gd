extends TextureButton

export var text := ""

func _ready():
	$Label.text = text
