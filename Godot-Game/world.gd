extends StaticBody2D

func _ready():
	for lantern in get_tree().get_nodes_in_group("lantern"):
		lantern.burn_tree.connect(_on_burn_tree)

func _on_burn_tree(tree_number):
	if tree_number == "DeadTree1":
		$DeadTree1.queue_free()
	if tree_number == "DeadTree2":
		$DeadTree2.queue_free()
	if tree_number == "DeadTree3":
		$DeadTree3.queue_free()
	if tree_number == "DeadTree4":
		$DeadTree4.queue_free()
	if tree_number == "DeadTree5":
		$DeadTree5.queue_free()
