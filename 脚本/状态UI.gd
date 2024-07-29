extends HBoxContainer
class_name StatsUI

@onready var 刀币数 = $"刀币栏/刀币数"
@onready var 流动资金数 = $"流动资金栏/流动资金数"
@onready var 刀币栏 = $"刀币栏"
@onready var 流动资金栏 = $"流动资金栏"

func UpdateStats(stats:Stats):
	刀币数.text = str(stats.刀币)
	流动资金数.text = str(stats.流动资金)
	
	刀币栏.visible = stats.刀币 > 0
	流动资金栏.visible = stats.流动资金 > 0
	
