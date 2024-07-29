extends Effect
class_name 获得流动资金

var amount := 0

func execute(targets:Array[Node]):
	for target in targets:
		if not target:
			continue
		if target is Enemy or target is Player:
			target.stats.流动资金 += amount
		
