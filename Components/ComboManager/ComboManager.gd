extends Node
class_name ComboManager

@export var comboSettings: Array[ComboSettings]

var comboData = {}

func _ready() -> void:
	for setting in comboSettings:
		comboData[setting.comboName] = {
			"stage" : 0,
			"maxStage" : setting.maxStages,
			"timer" : 0.0,
			"canChain" : false,
			"inCombo" : false,
			"timeout" : setting.timeout 
		}

func start_combo(comboType: String):
	var data = comboData[comboType]
	data["stage"] = 1
	data["timer"] = 0.0
	data["canChain"] = false
	data["inCombo"] = true
	comboData[comboType] = data

func continue_combo(comboType: String):
	var data = comboData[comboType]
	data["stage"] += 1
	if data["stage"] >= data["maxStage"]:
		reset_combo(comboType)
	
	data["canChain"] = false
	data["timer"] = 0.0
	comboData[comboType] = data
	
func allow_chain(comboType: String):
	var data = comboData[comboType]
	data["canChain"] = true
	comboData[comboType] = data

func update(delta: float):
	for comboType in comboData.keys():
		var data = comboData[comboType]
		if data["inCombo"]:
			data["timer"] += delta
			if data["timer"] > data["timeout"]:
				reset_combo(comboType)
			else:
				comboData[comboType] = data
		

func reset_combo(comboType: String):
	var data = comboData[comboType]
	data["stage"] = 0
	data["timer"] = 0.0
	data["canChain"] = false
	data["inCombo"] = false
	comboData[comboType] = data

func is_chaining_allowed(comboType: String) -> bool:
	return comboData[comboType]["canChain"]

func is_in_combo(comboType: String) -> bool:
	return comboData[comboType]["inCombo"]

func get_stage(comboType: String) -> int:
	return comboData[comboType]["stage"]

func time_left(comboType: String) -> float:
	return comboData[comboType]["timeout"] - comboData[comboType]["timer"]

func max_stage_reached(comboType) -> bool:
	return get_stage(comboType) >= comboData[comboType]["maxStage"]
