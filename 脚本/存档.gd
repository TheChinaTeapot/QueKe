extends Resource
class_name SaveGame

@export var seeds:int
@export var seed_state:int
@export var character:Character
@export var 当前牌堆:CardPile

const SAVE_PATH := "user://savegame.tres"


func save_data() -> void:
	var err := ResourceSaver.save(self,SAVE_PATH)
	assert(err == OK,"Couldn't save the game")

static func load_data() -> SaveGame:
	if FileAccess.file_exists(SAVE_PATH):
		return ResourceLoader.load(SAVE_PATH) as SaveGame
	
	return null

static func delete_data() -> void:
	if FileAccess.file_exists(SAVE_PATH):
		DirAccess.remove_absolute(SAVE_PATH) 
