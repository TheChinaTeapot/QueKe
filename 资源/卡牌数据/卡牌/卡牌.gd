extends Resource
class_name Card

enum 花色类型 {万,筒,条,字,花}

@export var name:String
@export var 花色:花色类型
@export var 点数:String
@export var 是否赋能:bool
@export var 具体赋能:赋能
@export var 是否效果:bool
@export var 污染增效:效果
@export var 图:Texture2D
@export var choose:bool
@export var 编号:int

func is_single():
	if 具体赋能 == null:
		return false
	return 具体赋能.目标 == 具体赋能.目标对象.单一敌人

func getTargets(targets:Array[Node]):
	if not targets:
		return []
	
	var tree := targets[0].get_tree()
	match 具体赋能.目标:
		具体赋能.目标对象.自己:
			return tree.get_nodes_in_group("player")
		具体赋能.目标对象.所有敌人:
			return tree.get_nodes_in_group("enemy")
		具体赋能.目标对象.所有人:
			return tree.get_nodes_in_group("player") + tree.get_nodes_in_group("enemy")
		_:
			return []

func play(targets:Array[Node]):
	events.cardPlayed.emit(self)
	
	if 具体赋能 == null:
		return
	
	if is_single():
		applyEffect(targets)
	else :
		applyEffect(getTargets(targets))

func applyEffect(_targets:Array[Node]):
	pass
		
