extends Area2D
class_name Enemy

@export var stats:Stats :set = set_enemy

@onready var sprite_2d = $Sprite2D
@onready var 状态ui = $"状态UI"
@onready var 瞄准 = $"瞄准"

func _ready():
	events.targetsChanged.connect(OnTargetsChanged)

func set_enemy(value:Stats):
	stats = value.create_instance()
	
	if not stats.statsChanged.is_connected(UpdateStats):
		stats.statsChanged.connect(UpdateStats)
	
	updateEnemy()

func updateEnemy():
	if not stats is Stats:
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
		global.chooseEnemy.erase(self)
		queue_free()


func OnTargetsChanged():
	if global.targets.has(self):
		瞄准.visible = true
		global.chooseEnemy.append(self)
	else:
		瞄准.visible = false
		global.chooseEnemy.erase(self)
