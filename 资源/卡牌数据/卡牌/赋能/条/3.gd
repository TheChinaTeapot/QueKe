extends Card

func applyEffect(targets:Array[Node]):
	
	var block_effeect :=获得流动资金.new()
	block_effeect.amount = 3
	block_effeect.execute(targets)
