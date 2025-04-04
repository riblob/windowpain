extends CharacterBody2D
var anim_player: AnimationPlayer

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@export var inv: Inv
func _ready():
	anim_player = $AnimationPlayer
	
func _physics_process(delta: float) -> void:
	# Add the gravity.
	#if not is_on_floor():
		#velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("up") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("Left", "Right")
	if Input.is_action_pressed("Right"):
		anim_player.play("walk_right")
	if Input.is_action_pressed("Left"):
		anim_player.play("walk_right", -1)
	if Input.is_action_just_released("Right") or Input.is_action_just_released("Left"):
		anim_player.stop()
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
