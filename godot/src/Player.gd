extends KinematicBody

var velocity = Vector3()

var gravity = -9.8 * 5

const MAX_VELOCITY = 10
const ACCEL = 3
const STRAFE_SPEED = 5
const STRAFE_ACCEL = 2

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	velocity = Vector3()
	
	if Input.is_action_pressed("move_left"):
		velocity.z = -STRAFE_SPEED
	if Input.is_action_pressed("move_right"):
		velocity.z = STRAFE_SPEED
	
	
	velocity.y += gravity * delta
	velocity.x = MAX_VELOCITY
	move_and_slide(velocity)
	
