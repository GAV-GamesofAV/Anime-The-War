extends Controller
class_name AIController

var isReady: bool = false

enum AIStates{
	IDLE,
	CHASE,
	RUN,
	ATTACK
}

var aiState := AIStates.IDLE

var player: Character

#Values
var direction: int = 0
var jump: bool = false
var lightAttack: bool = false

var minRunningDistance: int = 50#How many pixels to run before stopping
var maxRunningDistance: int = 200
var runningDistance: int = 0 #The variable that stores how much to run
var distanceRan: int = 0 #The variable that tracks how much the bot has ran

var attackRange: int = 50

#Max stages of each combo
var lightAttackComboMaxStage: int

#Tracking vars
var runStartPos: int

var curAttackComboLastStage: int #The variable that says how many comnbos it will strike
var curAttackComboStage: int = 0#The var that tracks how many stages have been striked

func _ready() -> void:
	lightAttackComboMaxStage = character.lightAttackComboStatesNames.size()
	isReady = true

func get_input():
	if isReady:
		print("Running get_input of AI Controllre")
		#Only if the bot is in idle, then it will decide
		if aiState == AIStates.IDLE:
			aiState = pick_ai_state()

		match aiState:
			AIStates.IDLE:
				print("decided IDLE")
				_handle_idle()
			AIStates.CHASE:
				print("decided Chase")
				_handle_chase()
			AIStates.RUN:
				print("decided Run")
				_handle_run()
			AIStates.ATTACK:
				print("decided Atack")
				_handle_attack()
			_:
				pass

	return{
		moveKey: direction,
		jumpKey: jump,
		lightAttackKey: lightAttack
	}

#Pick a random value from the AI states
func pick_ai_state():
	return AIStates.values().pick_random()

func _handle_idle():
	#Reset all the values
	direction = 0
	lightAttack = false

func _handle_chase():
	direction = sign(player.position.x - character.position.x)

	if abs(character.position.x - player.position.x) <= attackRange:
		aiState = AIStates.IDLE

	#Reset the remaining actions
	lightAttack = false

func _handle_run():
	#Do only once
	if runningDistance == 0:
		runningDistance = randi_range(minRunningDistance, maxRunningDistance)
		runStartPos = int(character.position.x)

	direction = -(sign(player.position.x - character.position.x)) #Set directipn to opposite of player

	distanceRan = abs(character.position.x - runStartPos)

	

	if distanceRan >= runningDistance:
		aiState = AIStates.IDLE
		runningDistance = 0
	
	#Reset values
	lightAttack = false

func _handle_attack():

	if can_attack():
		#Pick an attack
		#Set the combo stages
		
		if curAttackComboStage == 0:
			curAttackComboLastStage = randi_range(1, lightAttackComboMaxStage)
		curAttackComboStage += 1
		lightAttack = true

		if curAttackComboStage >= curAttackComboLastStage:
			aiState = AIStates.IDLE
			curAttackComboStage = 0

	else:
		aiState = AIStates.CHASE
	#Rest remaining actions
	direction = 0

func can_attack() -> bool:
	return abs(player.position.x - character.position.x) <= attackRange
