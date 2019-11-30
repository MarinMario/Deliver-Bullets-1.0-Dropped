extends Node2D

func _process(delta):
	self.rotation_degrees += 2000 * delta
	self.modulate.a -= 5 * delta
	
	if self.modulate.a == 0:
		self.queue_free()