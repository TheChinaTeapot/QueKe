extends Control
class_name ManaUI

@export var character_stats :Character : set = set_character_stats

@onready var label = $Label

func set_character_stats(value:Character):
	character_stats = value
	
	if not character_stats.statsChanged.connect(OnStatsChanged):
		character_stats.statsChanged.connect(OnStatsChanged)
	
	if not is_node_ready():
		await ready
	
	OnStatsChanged()

func OnStatsChanged():
	label.text = str(character_stats.出牌数)
