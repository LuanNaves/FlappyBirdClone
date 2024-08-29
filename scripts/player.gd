extends CharacterBody2D
class_name Player

const JUMP_VELOCITY = -300.0
const MAX_UPWARD_ROTATION = -30.0
const MAX_DOWNWARD_ROTATION = 90.0
const UP_ROTATION_SPEED = 400.0
const DOWN_ROTATION_SPEED = 300.0


@onready var animated_sprite = $AnimatedSprite2D
@onready var animation_player = $AnimationPlayer
@onready var collision_shape = $CollisionShape2D
@onready var hit = $Hit
@onready var wing = $Wing

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
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	# Handle jump.
	if Input.is_action_just_pressed("flap") and is_alive:
		if !started:
			start()
		velocity.y = JUMP_VELOCITY
		wing.play()
		
	# Update rotation
	if velocity.y < 0:  # Subindo
		rotation_degrees = max(rotation_degrees - UP_ROTATION_SPEED * delta, MAX_UPWARD_ROTATION)
	elif velocity.y > 0:  # Caindo
		rotation_degrees = min(rotation_degrees + DOWN_ROTATION_SPEED * delta, MAX_DOWNWARD_ROTATION)

	# Controlling the animation
	if started and is_alive:
		if velocity.y < -100:
			animated_sprite.play("flap")
		elif velocity.y > 0:
			animated_sprite.play("fall")
		else:
			animated_sprite.play("transition")
	
	if !started:
		animated_sprite.play("idle")
		
	move_and_slide()
	
	
func die():
	if !is_alive : return
	is_alive = false
	hit.play()
	animated_sprite.stop()
	emit_signal("died")
