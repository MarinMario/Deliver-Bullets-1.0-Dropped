extends Node2D

var player: Node2D
var camera: Node2D

const BULLET = preload("res://scenes/other/bullet.tscn")
const MOB_BULLET = preload("res://scenes/other/mob_bullet.tscn")

const WEAPON_ITEM = preload("res://scenes/other/weapon_item.tscn")
const DIALOG_BOX = preload("res://scenes/player/dialog_box.tscn")

const BLOOD_SPLATTER = preload("res://scenes/other/blood_splatter.tscn")
const EXPLOSION = preload("res://scenes/other/explosion.tscn")
const BULLET_DESPAWN_EFFECT = preload("res://scenes/other/bullet_despawn_effect.tscn")

var enemies_in_scene = 0
var curent_level = 0
