extends KinematicBody2D

var alive := true
var bodies_inside_area := []
var despawn_timer := 0.0

func _ready():
	$Sprite/light_caster.visible = false
	$Sprite.scale = Vector2(1,1)
	$Sprite.modulate.a = 1

func _process(delta):
	if not alive:
		despawn_timer += delta
		if despawn_timer > 2:
			self.queue_free()

func take_damage():
	if alive:
		$Sprite.scale = Vector2(0,0)
		$CollisionShape2D.disabled = true
		
		$Sprite.play("explosion")
		$Sprite/light_caster.visible = true
		$anims.play("explode")
		$shadow.visible = false
		
		alive = false
		
		global.camera.camera_shake(15, 3)
		
		give_damage()

func give_damage():
	for anyone in bodies_inside_area:
		for i in 100:
			anyone.take_damage()

func _on_damage_area_body_entered(body):
	if body.is_in_group("living"):
		bodies_inside_area.push_back(body)

func _on_damage_area_body_exited(body):
	bodies_inside_area.erase(body)
