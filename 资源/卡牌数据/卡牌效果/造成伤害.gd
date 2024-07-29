extends Effect
class_name 造成伤害

var amount = 0

func execute(targets:Array[Node]):
	for target in targets:
		if not target:
			continue
		if target is Enemy or target is Player:
			target.takeDamage(amount)
