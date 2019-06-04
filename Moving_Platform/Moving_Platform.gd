extends KinematicBody2D

# Declare member variables here. Examples:
enum PLATFORM_TYPES {Horizontal, Vertical, DiagBLTR, DiagTLBR}
export(PLATFORM_TYPES) var platform_type=PLATFORM_TYPES.Horizontal

export var platform_range = 100
export var platform_speed = 100

var direction = Vector2(0,0)

var tween

# Called when the node enters the scene tree for the first time.
func _ready():
	
	#Horizontal Movement
	if platform_type == 0:
		direction = Vector2(1,0)
	#Vertical Movement
	if platform_type == 1:
		direction = Vector2(0,-1)
	#Diagonal Movement (Bottom Left to Top Right)
	if platform_type == 2:
		direction = Vector2(1,-1)
	#Diagonal Movement (Bottom Right to Top Left)
	if platform_type == 3:
		direction = Vector2(-1,-1)
		
	#Linear Movement Tween
	tween = Tween.new()
	tween.connect("tween_completed",self,"_on_Tween_tween_completed")
	add_child(tween)
	_start_tween()

func _start_tween():
	var duration = platform_range/platform_speed
	tween.interpolate_property(self,"position", position, position + direction * platform_range, duration, Tween.TRANS_LINEAR,Tween.EASE_IN_OUT) 
	tween.start()

func _on_Tween_tween_completed(object, key):
	direction *= -1
	_start_tween()