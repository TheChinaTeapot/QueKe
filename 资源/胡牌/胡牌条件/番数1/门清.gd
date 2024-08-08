extends 胡牌条件

func 具体条件(牌组1:Array,牌组2:Array,牌组3:Array,牌组4:Array,雀头:Array):
	检测(牌组1,牌组2,牌组3,牌组4,雀头)
	if 面 < 4:
		return null
	for card in 出牌:
		if card.对手牌:
			return null
	damage = 番 * 4
	return self
	
