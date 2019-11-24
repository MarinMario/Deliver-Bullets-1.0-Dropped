extends Particles2D

func _ready():
	self.emitting = true
	self.one_shot = true

func _process(delta):
	if self.emitting == false:
		self.queue_free()
