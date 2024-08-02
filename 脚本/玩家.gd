extends Area2D
class_name Player

@export var stats:Character :set = set_character_stats
@onready var sprite_2d = $Sprite2D
@onready var 状态ui = $"状态UI" as StatsUI

func set_character_stats(value:Character):
	stats = value
	
	if not stats.statsChanged.is_connected(UpdateStats):
		stats.statsChanged.connect(UpdateStats)
		
	updatePlayer()

func updatePlayer():
	if not stats is Character:
		return
	if not is_inside_tree():
		await  ready
	
	sprite_2d.texture = stats.图像
	UpdateStats()

func UpdateStats():
	状态ui.UpdateStats(stats)

func takeDamage(damage:int):
	if stats.刀币 <= 0:
		return
	
	stats.take_damage(damage)
	
	if stats.刀币 <= 0:
		queue_free()
