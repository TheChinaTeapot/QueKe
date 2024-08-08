extends Resource
class_name 胡牌条件

@export var name:String
@export var 番:int
var damage:int = 0
var 面:= 0
var 出牌:Array = []

func 具体条件(_牌组1:Array,_牌组2:Array,_牌组3:Array,_牌组4:Array,_雀头:Array):
	pass

func 检测(牌组1:Array,牌组2:Array,牌组3:Array,牌组4:Array,雀头:Array):
	出牌.append_array(牌组1)
	出牌.append_array(牌组2)
	出牌.append_array(牌组3)
	出牌.append_array(牌组1)
	出牌.append_array(雀头)
	if 顺子(牌组1) or 刻子(牌组1) or 杠子(牌组1):
		面 += 1
	if 顺子(牌组2) or 刻子(牌组2) or 杠子(牌组2):
		面 += 1
	if 顺子(牌组3) or 刻子(牌组3) or 杠子(牌组3):
		面 += 1
	if 顺子(牌组4) or 刻子(牌组4) or 杠子(牌组4):
		面 += 1

func 顺子(牌组:Array):
	牌组.sort_custom(sort_by_number)
	return 牌组.size() == 3 and 牌组[0].编号 + 1 == 牌组[1].编号 and 牌组[1].编号 + 1 == 牌组[2].编号

func 对子(牌组:Array):
	return 牌组.size() == 2 and 牌组[0].编号 == 牌组[1].编号

func 刻子(牌组:Array):
	return 牌组.size() == 3 and 牌组[0].编号 == 牌组[1].编号 and 牌组[1].编号 == 牌组[2].编号

func 杠子(牌组:Array):
	return 牌组.size() == 4 and 牌组[0].编号 == 牌组[1].编号 and 牌组[1].编号 == 牌组[2].编号 and 牌组[2].编号 == 牌组[3].编号
	

func sort_by_number(a, b):
	return a.编号 < b.编号
