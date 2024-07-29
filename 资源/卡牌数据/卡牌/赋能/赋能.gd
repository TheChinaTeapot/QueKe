extends Resource
class_name 赋能

enum 稀有度类型{天,地,人}
enum 赋能类型{行动,反应,能力,被动,蓄势}
enum 触发条件类型{单张,临张,对子,顺子,刻子,杠}
enum 花色{万,筒,条,风}
enum 目标对象 {自己,单一敌人,所有敌人,所有人}

@export var 名称:String
@export var 限定花色:花色
@export var 点数:String
@export var 稀有度:稀有度类型
@export var 具体赋能类型:赋能类型
@export var 触发条件:触发条件类型
@export var 目标:目标对象
@export_multiline var 赋能效果:String
