extends Resource
class_name Stats

signal statsChanged

@export var 刀币:int
@export var 图像:Texture2D
var 流动资金:int :set = set_money 


func set_money(money:int):
	流动资金 = money
	statsChanged.emit()

func take_damage(damage:int):
	if damage <= 0:
		return
	var initialDamage = damage
	damage = clampi(damage-流动资金,0,damage)
	self.流动资金 = clampi(流动资金- initialDamage,0,流动资金)
	self.刀币 -= damage
	statsChanged.emit()

func heal(amount:int):
	self.刀币 += amount

func create_instance():
	var instance:Stats = self.duplicate()
	instance.刀币 = 刀币
	instance.流动资金 = 0
	return instance
