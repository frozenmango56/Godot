# bomb.gd
extends Area2D

## The explosive force of the bomb.
@export var blast_impulse: float = 1000.0

# A reference to the Timer node for the fuse.
@onready var fuse_timer: Timer = $Timer
# reference the cpuparticles2d explosion
@onready var explosion = $explosion


func _ready() -> void:
	# When the bomb is placed in the world, start the fuse.
	fuse_timer.start()


# This function will be called when the Timer finishes.
func _on_timer_timeout() -> void:
	explode()


## The main explosion logic.
func explode() -> void:
	#hide the sprite
	$Icon.visible = false
	# Start the particle explosion effect! 
	explosion.emitting = true

	# --- Optional: Add sound effects here ---
	# $ExplosionSound.play()

	# Get a list of all physics bodies currently overlapping the Area2D.
	var bodies_in_radius = get_overlapping_bodies()
	
	for body in bodies_in_radius:
		# We only want to affect RigidBody2D nodes.
		if body is RigidBody2D:
			# Calculate direction from bomb center to the body's center.
			var direction = (body.global_position - self.global_position).normalized()
			
			# Apply a powerful, one-time push from the center.
			body.apply_central_impulse(direction * blast_impulse)
			
	# The bomb has exploded, so remove it from the game.
	# Note: Since the particles are now a child of the bomb, they will be
	# removed when queue_free() is called. If you want the particles to
	# finish their animation, you would need to reparent them or handle
	# the bomb's deletion differently. For a simple effect, this is fine.
	await get_tree().create_timer(3).timeout
	queue_free()
	$"..".queue_free()
