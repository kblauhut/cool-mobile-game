extends KinematicBody

var velocity = Vector3()

var gravity = -9.8;

const MAX_VELOCITY = 40;
const ACCEL = 3;
const STRAFE_SPEED = 5;
const STRAFE_ACCEL = 2;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	velocity = Vector3()
	
	if Input.is_action_pressed("move_left"):
		velocity.z = -5
	if Input.is_action_pressed("move_right"):
		velocity.z = 5
	
	
	velocity.y += gravity * delta
	velocity.x = 1
	move_and_slide(velocity)
	
