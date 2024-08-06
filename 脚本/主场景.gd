extends Node

@onready var StateMachine: StateChart = $"状态机"

@export var character:Character

var new_character:Character
var first = false
var save_data : SaveGame

func save_run() -> void:
	save_data.seed = global.instance.seed
	save_data.seed_state = global.instance.state
	save_data.character = character
	save_data.当前牌堆 = character.当前牌堆
	save_data.save_data()

func load_run() -> void:
	save_data = SaveGame.load_data()
	assert(save_data,"Couldn't load last save")
	global.set_from_save(save_data.seed,save_data.seed_state)
	character = save_data.character
	character.当前牌堆 = save_data.当前牌堆
	
	

func _on_新游戏初始化_state_entered() -> void:
	save_data = SaveGame.new()
	save_run()
	new_character = character.create_instance()

func _on_继续游戏初始化_state_entered() -> void:
	StateMachine.send_event("非战斗")
	load_run()
	new_character = character.create_instance()

func _on_初始化_state_entered() -> void:
	pass

func _on_战斗_state_entered() -> void:
		var fight_node = preload("res://场景/战斗场景.tscn").instantiate()
	#if !first :
		fight_node.character = new_character
		self.add_child(fight_node)
		fight_node.start_battle(new_character)
	#else :
		#fight_node.visible = true

func _on_非战斗状态_state_entered() -> void:
	print("进入非战斗状态")
	if get_tree().get_first_node_in_group("fight") == null:
		return
	new_character.手牌堆.clear()
	get_tree().get_first_node_in_group("fight").queue_free()
	
	#get_tree().get_first_node_in_group("fight").visible = false

func _on_战斗初始化_state_entered() -> void:
	print("战斗初始化")

func _on_玩家回合_state_entered() -> void:
	events.playerTurnStart.emit()

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
		StateMachine.send_event("继续战斗")
	if event.is_action_pressed("ui_left"):
		StateMachine.send_event("战斗结束")


func _on_继续游戏_pressed() -> void:
	StateMachine.send_event("继续游戏")


func _on_新游戏_pressed() -> void:
	StateMachine.send_event("新游戏")
	pass # Replace with function body.

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

#非战斗
