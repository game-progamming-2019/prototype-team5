extends KinematicBody2D

const initial_speed = 200
var speed = initial_speed
var direction = Vector2(0,0)
var velocity = Vector2(0,0)
var friction = 0.95
var gravity = 500
var fir = 1

func is_traveling():
	if !is_on_floor()&&!is_on_ceiling():
		return 1

func _ready():
	pass # Replace with function body.
	get_node("Sprite/AnimationPlayer").set_speed_scale(2)

func _physics_process(delta):
	
	if Input.is_action_pressed("ui_focus_next")&&!is_traveling():
		fir=fir*-1
		$Sprite.flip_v=!$Sprite.flip_v
		
	velocity.y += gravity*delta*fir

	direction = Vector2(0,0)
	
	##########
	
	
	#Walk Left
	if Input.is_action_pressed("ui_left"):
		direction.x = -1
		get_node("Sprite/AnimationPlayer").play("Walk_Left")
	
	#Walk Right	
	if Input.is_action_pressed("ui_right"):
		direction.x = 1
		get_node("Sprite/AnimationPlayer").play("Walk_Right")
	
	#Stop
	if !Input.is_action_pressed("ui_left")&&!Input.is_action_pressed("ui_right"):
		get_node("Sprite/AnimationPlayer").play("Idle")
	
	#Actions avaliable on floor
	if !is_traveling():
		#Activate Sprint
		if Input.is_action_just_pressed("ui_run"):
			speed*=3/1
			get_node("Sprite/AnimationPlayer").set_speed_scale(6)
		#Jump
		if Input.is_action_pressed("ui_jump"):
			velocity.y = -500*fir
	#Reset Sprint
	if Input.is_action_just_released("ui_run"):
		speed=initial_speed
		get_node("Sprite/AnimationPlayer").set_speed_scale(2)
		
	#delta MUST NOT be factored into velocity here, since the _physics_process function is synced (see project settings)
	velocity.x = speed*direction.x
	
	velocity=move_and_slide(velocity, Vector2(0,-1))