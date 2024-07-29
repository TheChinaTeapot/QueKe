extends Node

@onready var StateMachine: StateChart = $"状态机"

func _on_初始化_state_entered() -> void:
	print("初始化")

func _on_战斗_state_entered() -> void:
	self.add_child(preload("res://场景/战斗场景.tscn").instantiate())

func _on_非战斗状态_state_entered() -> void:
	print("进入非战斗状态")

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

func _on_抽牌_state_entered() -> void:
	print("抽牌")

func _on_出牌_state_entered() -> void:
	print("出牌")

func _on_默认_state_entered() -> void:
	print("默认状态")

func _on_卡牌点击_state_entered() -> void:
	print("点击卡牌")

func _on_卡牌拖动_state_entered() -> void:
	print("拖动卡牌")

func _on_卡牌打出_state_entered() -> void:
	print("打出卡牌")

func _on_卡牌销毁_state_entered() -> void:
	print("销毁卡牌")

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_down"):
		StateMachine.send_event("战斗")

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
