extends KinematicBody2D

var init_pos: Vector2
var target: Vector2
var direction: Vector2
var motion: Vector2
var speed := 500
var weapon_state: String
var despawn_timer := 0.0
var damage := 1

func _ready():
	#init_pos = global.player_shoot_point
	position = init_pos
	direction = (target - self.position).normalized()
	look_at(target)

func _process(delta):
	motion = direction * speed
	move_and_slide(motion)
	if get_slide_count() > 0:
		for i in get_slide_count():
			var collision = get_slide_collision(i).collider
			if collision.is_in_group("living"):
				for i in damage:
					collision.take_damage()
			
			self.queue_free()







