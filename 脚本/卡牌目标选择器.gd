extends Node2D

@onready var area_2d = $Area2D

func _physics_process(_delta):
	area_2d.position = get_local_mouse_position()

func _on_area_2d_area_entered(area):
	if not global.targets.has(area):
		global.targets.clear()
		global.targets.append(area)
		events.targetsChanged.emit()
