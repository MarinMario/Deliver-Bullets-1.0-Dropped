extends KinematicBody2D

var init_pos: Vector2
var target: Vector2
var direction: Vector2
var motion: Vector2
var speed := 800
var despawn_timer := 0.0
var damage := 1
var bullet_type: String

func _ready():
	#init_pos = global.player_shoot_point
	position = init_pos
	direction = (target - self.position).normalized()
	look_at(target)
	
	var explosion = global.EXPLOSION.instance()
	explosion.global_position = self.global_position
	get_parent().add_child(explosion)

func _process(delta):
	motion = direction * speed
	move_and_slide(motion)
	$bullet_sprite.play(bullet_type)
	
	if bullet_type == "machine_gun":
		damage = 1
		speed = 1500
	elif bullet_type == "pistol":
		damage = 3
		speed = 1000
	
	if get_slide_count() > 0:
		for i in get_slide_count():
			var collision = get_slide_collision(i).collider
			if collision.is_in_group("living"):
				for i in damage:
					collision.take_damage()
			
			self.queue_free()







