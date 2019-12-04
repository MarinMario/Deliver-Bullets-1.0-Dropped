extends Node2D

var player: Node2D
var camera: Node2D

var player_weapons := ["nothing"]
var player_pistol_ammo := 0
var player_mg_ammo := 0
var player_health := 100

var blood_sprites_on_screen := 0

const BULLET = preload("res://scenes/other/bullet.tscn")
const MOB_BULLET = preload("res://scenes/other/mob_bullet.tscn")

const WEAPON_ITEM = preload("res://scenes/other/weapon_item.tscn")

const BLOOD_SPLATTER = preload("res://scenes/other/blood_splatter.tscn")
const EXPLOSION = preload("res://scenes/other/explosion.tscn")
const BULLET_DESPAWN_EFFECT = preload("res://scenes/other/bullet_despawn_effect.tscn")