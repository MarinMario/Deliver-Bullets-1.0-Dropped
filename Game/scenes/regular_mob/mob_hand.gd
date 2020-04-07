extends Node2D

var weapon_state: String
var fire_timer := 0.0
var target: Vector2
var fire_rate: float
var can_shoot := true
var weapon_dropped := false
onready var mob := get_parent().get_parent()

func _process(delta):
	weapon_state = mob.weapon_state
	fire_rate = mob.fire_rate
	
	if mob.can_shoot:
		fire_timer += delta
		if fire_timer > fire_rate:
			target = mob.target_pos
			self.look_at(target)
			fire_timer = 0
			#yield(get_tree().create_timer(0.5), "timeout")
			shoot()
	else:
		self.rotation_degrees = 0
	
	if mob.health <= 0:
		if not weapon_dropped:
			drop_weapon()
			weapon_dropped = true

func shoot():
	if weapon_state != "nothing":
		var bullet = global.MOB_BULLET.instance()
		bullet.init_pos = $shoot_point.global_position
		bullet.target = target
		bullet.bullet_type = weapon_state
		get_parent().get_parent().get_parent().add_child(bullet)


func drop_weapon():
	if weapon_state != "nothing":
		var weapon_item = global.WEAPON_ITEM.instance()
		weapon_item.weapon_state = weapon_state
		mob.weapon_state = "nothing"
		weapon_item.global_position = self.global_position + Vector2(0,100)
		mob.get_parent().add_child(weapon_item)









