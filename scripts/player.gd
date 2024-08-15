extends CharacterBody2D
class_name Player

const JUMP_VELOCITY = -300.0
const MAX_ROTATION_DEGREE = -30

@onready var animated_sprite = $AnimatedSprite2D
@onready var animation_player = $AnimationPlayer

signal died
var is_alive = true
var started = false
var gravity = 0

func start():
	if started : return
	started = true
	# Get the gravity from the project settings to be synced with RigidBody nodes.
	gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
	animation_player.stop()
	animated_sprite.position.y = 0

func _physics_process(delta):
	if is_on_floor():
		die()	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	# Handle jump.
	if is_alive:
		if Input.is_action_just_pressed("flap"):
			if !started:
				start()
			velocity.y = JUMP_VELOCITY
		# Controlling the animation
		if started:
			if velocity.y < -100:
				animated_sprite.play("flap")
			elif velocity.y > 0:
				animated_sprite.play("fall")
			else:
				animated_sprite.play("transition")
		else:
			animated_sprite.play("idle")
	move_and_slide()
	
	
func die():
	if is_alive == false : return
	is_alive = false
	animated_sprite.stop()
	emit_signal("died")
