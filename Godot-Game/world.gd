extends StaticBody2D

func _ready():
	$Portal1.monitoring = false
	$Portal1.monitorable = false
	$Portal2.monitoring = false
	$Portal2.monitorable = false
	$Portal3.monitoring = false
	$Portal3.monitorable = false
	$Portal4.monitoring = false
	$Portal4.monitorable = false
	$Portal5.monitoring = false
	$Portal5.monitorable = false
	for lantern in get_tree().get_nodes_in_group("lantern"):
		lantern.burn_tree.connect(_on_burn_tree)

func _on_burn_tree(tree_number):
	if tree_number == "DeadTree1":
		$DeadTree1.queue_free()
		$Portal1.monitoring = true
		$Portal1.monitorable = true
	if tree_number == "DeadTree2":
		$DeadTree2.queue_free()
		$Portal2.monitoring = true
		$Portal2.monitorable = true
	if tree_number == "DeadTree3":
		$DeadTree3.queue_free()
		$Portal3.monitoring = true
		$Portal3.monitorable = true
	if tree_number == "DeadTree4":
		$DeadTree4.queue_free()
		$Portal4.monitoring = true
		$Portal4.monitorable = true
	if tree_number == "DeadTree5":
		$DeadTree5.queue_free()
		$Portal5.monitoring = true
		$Portal5.monitorable = true
