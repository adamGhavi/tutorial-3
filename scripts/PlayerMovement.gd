extends KinematicBody2D

export var grav = 500
export var m_hspd = 10000
export var slide_spd = 50000
export var jump_height = -18000

var velocity = Vector2.ZERO
var state = 0

onready var animated_sprite = get_node("AnimatedSprite")
onready var slide_dust = get_node("SlideDust")

func _process(delta):
	var lspd = .1
	
	animated_sprite.scale.x = lerp(animated_sprite.scale.x, 1, lspd)
	animated_sprite.scale.y = lerp(animated_sprite.scale.y, 1, lspd)

func _physics_process(delta):
	# this movement system is how i normally would code it in gms, translated into godot w/ a betterjump implementation
	
	# normal walking state
	if state == 0:
		# horizontal movement
		if Input.is_action_pressed("ui_right"):
			velocity.x = m_hspd
			
			if is_on_floor():
				animated_sprite.animation = "walk"
				animated_sprite.playing = true
				animated_sprite.flip_h = false
			
		elif Input.is_action_pressed("ui_left"):
			velocity.x = -m_hspd
			
			if is_on_floor():
				animated_sprite.animation = "walk"
				animated_sprite.playing = true
				animated_sprite.flip_h = true
			
		else:
			velocity.x = lerp(velocity.x, 0, .2)
			
			if is_on_floor():
				animated_sprite.animation = "idle"
				animated_sprite.playing = false
		
		# vertical movement
		if Input.is_action_just_pressed("ui_up") && is_on_floor():
			velocity.y = jump_height
			
			animated_sprite.animation = "jump"
			animated_sprite.playing = false
			
			animated_sprite.scale += Vector2(-.25, .25)
			
		elif !is_on_floor():
			var r_grav = grav
			
			if !Input.is_action_pressed("ui_up") || velocity.y > 0:
				r_grav *= 4
			
			velocity.y += r_grav
			
		# slide
		if Input.is_action_just_pressed("ui_down") && is_on_floor():
			var facing = 1
			if animated_sprite.flip_h:
				facing = -1
			velocity.x = facing*slide_spd
			
			animated_sprite.animation = "slide"
			
			slide_dust.emitting = true
			
			state = 1
	
	elif state == 1:
		if Input.is_action_just_released("ui_down") || abs(velocity.x) < 1:
			slide_dust.emitting = false
			
			state = 0
		
		velocity.x = lerp(velocity.x, 0, .05)
		
		if !is_on_floor():
			velocity.y += grav
	
	# update coordinates
	move_and_slide(velocity*delta, Vector2.UP)
