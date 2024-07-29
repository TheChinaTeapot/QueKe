extends Card

func applyEffect(targets:Array[Node]):
	var damdge_effect := 造成伤害.new()
	damdge_effect.amount = 5
	damdge_effect.execute(targets)
	
