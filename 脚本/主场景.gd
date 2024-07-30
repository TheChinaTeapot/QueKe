extends Node

@onready var StateMachine: StateChart = $"状态机"

@export var character:Character

var new_character:Character
var first = false

func _on_初始化_state_entered() -> void:
	new_character = character.create_instance()

func _on_战斗_state_entered() -> void:
	var fight_node = preload("res://场景/战斗场景.tscn").instantiate()
	if !first :
		self.add_child(fight_node)
		fight_node.character = new_character
		fight_node.start_battle(new_character)
	else :
		fight_node.visible = true

func _on_非战斗状态_state_entered() -> void:
	print("进入非战斗状态")
	get_tree().get_first_node_in_group("fight").visible = false

func _on_战斗初始化_state_entered() -> void:
	print("战斗初始化")

func _on_玩家回合_state_entered() -> void:
	print("进入玩家回合")

func _on_敌人回合_state_entered() -> void:
	print("进入敌人回合")

func _on_响应_state_entered() -> void:
	print("进入响应阶段")

func _on_结算_state_entered() -> void:
	print("进入结算阶段")

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_down"):
		StateMachine.send_event("战斗")
	if event.is_action_pressed("ui_up"):
		StateMachine.send_event("回合结束")
	if event.is_action_pressed("ui_left"):
		StateMachine.send_event("战斗结束")

#进入战斗状态
#StateMachine.send_event("战斗")

#玩家回合结束
#StateMachine.send_event("回合结束")

#战斗结束
#StateMachine.send_event("战斗结束")

#继续出牌
#StateMachine.send_event("继续出牌")

#继续战斗
#StateMachine.send_event("继续战斗")
