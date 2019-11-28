extends Node2D

func _process(delta):
	self.rotation_degrees += 1000 * delta
	self.modulate.a -= 3 * delta