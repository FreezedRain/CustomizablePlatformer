class_name Player extends CharacterBody2D

# Movement
const SPEED = 152
const JUMP_VELOCITY = 230
const GRAVITY = -450
const COYOTE_TIME = 0.1
const JUMP_QUEUE_TIME = 0.1
const DASH_SPEED = 14

var was_grounded = false
var t_jump = 0.0
var t_left_ground = 0.0
var did_jump = false
var just_landed = false
var last_velocity: Vector3 = Vector3.ZERO
var extra_speed: float = 0.0

@onready var sprite = $Sprite
@onready var interactor = $Interactor

func _ready():
	Global.player = self
	#var tset = get_node("../TileMap").tile_set
	#tset.get_source(tset.get_source_id(0)).texture = load("res://sprites/tiles/ground_evil.png")
	#sprite.sprite_frames.set_frame("move", 0, load("res://sprites/player/char_sheet_evil.png"))
		
func _process(delta):
	if Input.is_action_just_pressed("interact"):
		interactor.try_interact()

func _physics_process(delta):
	var is_grounded = is_on_floor()
	var speed = velocity.length()
	
	t_jump += delta
	if not is_grounded:
		t_left_ground += delta
	
	if is_grounded and not was_grounded:
		# Landed
		_on_landed()
	elif not is_grounded and was_grounded:
		_on_left_ground()
	# Add the gravity.
	if not is_grounded:
		var gravity_multiplier = 1
		if velocity.y > 0:
			gravity_multiplier = 1.85
		elif not Input.is_action_pressed("jump"):
			gravity_multiplier = 1.5
		velocity.y -= GRAVITY * gravity_multiplier * delta

	# Handle Jump.
	if Input.is_action_just_pressed("jump"):
		if is_on_floor() or (t_left_ground <= COYOTE_TIME and not did_jump): # or coyote
			jump()
		else:
			t_jump = 0

	var input = Input.get_axis("left", "right")
	var has_input: bool = input != 0
	#var accel = 100 if is_grounded else 4
	var amount = SPEED if input else 0
	amount += extra_speed
	if is_grounded:
		velocity.x = input * amount
	else:
		velocity.x = lerp(velocity.x, input * amount, delta * 4)
	
	# Update animation
	if is_grounded:
		sprite.play("move" if has_input else "idle")
	else:
		sprite.play("fall" if velocity.y > 0 else "jump")
	if has_input:
		sprite.flip_h = input < 0

	move_and_slide()
	was_grounded = is_grounded
	just_landed = false
	
func jump(multiplier=1):
	global_position += Vector2.UP * 0.025 * multiplier
	velocity.y = -JUMP_VELOCITY * multiplier
	did_jump = true

func _on_landed():
	t_left_ground = 0
	did_jump = false
	just_landed = true
	if t_jump <= JUMP_QUEUE_TIME:
		jump()
	
func _on_left_ground():
	pass

func _on_collision(collider):
	pass
