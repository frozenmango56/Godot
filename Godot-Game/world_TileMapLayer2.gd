extends TileMapLayer

func _ready():
	for lantern in get_tree().get_nodes_in_group("lantern"):
		lantern.burn_tree.connect(_on_burn_tree)

func _on_burn_tree(tree_number):
	if tree_number == "DeadTree1":
		erase_cell(Vector2i(224,-18))
		erase_cell(Vector2i(225,-18))
		erase_cell(Vector2i(224,-19))
		erase_cell(Vector2i(225,-19))
		$"../Hiddendoors".set_cell(Vector2i(224, -18), 0, Vector2i(9, 3))
	if tree_number == "DeadTree2":
		erase_cell(Vector2i(95,-31))
		erase_cell(Vector2i(96,-31))
		erase_cell(Vector2i(95,-32))
		erase_cell(Vector2i(96,-32))
		$"../Hiddendoors".set_cell(Vector2i(95, -31), 0, Vector2i(9, 3))
	if tree_number == "DeadTree3":
		erase_cell(Vector2i(104,2))
		erase_cell(Vector2i(105,2))
		erase_cell(Vector2i(104,1))
		erase_cell(Vector2i(105,1))
		$"../Hiddendoors".set_cell(Vector2i(104, 2), 0, Vector2i(9, 3))
	if tree_number == "DeadTree4":
		erase_cell(Vector2i(-6,-32))
		erase_cell(Vector2i(-5,-32))
		erase_cell(Vector2i(-6,-33))
		erase_cell(Vector2i(-5,-33))
		$"../Hiddendoors".set_cell(Vector2i(-6, -32), 0, Vector2i(9, 3))
	if tree_number == "DeadTree5":
		erase_cell(Vector2i(27,-3))
		erase_cell(Vector2i(28,-3))
		erase_cell(Vector2i(27,-4))
		erase_cell(Vector2i(28,-4))
		$"../Hiddendoors".set_cell(Vector2i(27, -3), 0, Vector2i(9, 3))
