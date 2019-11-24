extends Node2D

var player_pos: Vector2

var player_weapons := ["nothing"]
var player_pistol_ammo := 0
var player_mg_ammo := 0
var player_health := 100

const BLOOD_PARTICLES = preload("res://blood_particles.tscn")
const BULLET = preload("res://scenes/other/bullet.tscn")