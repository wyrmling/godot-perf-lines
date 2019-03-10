extends Node2D

var obj_num : int
var obj_type : int = -1
#var obstacles_of_vectors : PoolVector3Array

enum {LINE, POLYLINE, CIRCLE, RECT}

func _draw():
    match obj_type:
        LINE:
            for i in obj_num:
                draw_line(
                    Vector2(randi()%640, randi()%360),
                    Vector2(randi()%640, randi()%360),
#                    Color("#b2d90a"),
                    Color(randf(), randf(), randf()),
                    2.0
                )
        POLYLINE:
            var pool : Array = []
            for i in obj_num:
                pool.append(Vector2(randi()%640, randi()%360))
            draw_polyline(
                PoolVector2Array(pool),
#                    Color("#b2d90a"),
                Color(randf(), randf(), randf()),
                2.0
            )
        CIRCLE:
            for i in obj_num:
                draw_circle(
                    Vector2(randi()%640+10, randi()%360+10),
                    randi()%30,
#                    Color("#b2d90a"),
                    Color(randf(), randf(), randf())
                )
        RECT:
            for i in obj_num:
                draw_rect(
                    Rect2(Vector2(randi()%640, randi()%360), Vector2(randi()%640, randi()%360)),
                    Color(randf(), randf(), randf()),
                    $gui/ScrollContainer/VBoxContainer/Container/CheckButton.pressed
                )
        _:
            print("Type not set")

#    var pool_vectors : PoolVector2Array
#    for path_vector in path_of_vectors:
#        pool_vectors.append(Vector2(path_vector.x*16, path_vector.y*16))
#    draw_polyline(
#        pool_vectors,
#        Color("#b2d90a"),
#        3.0
#    )


#    var previous
#    for path_vector in path_of_vectors:
#        if previous != null:
#            draw_line(
#                Vector2(previous.x + 0.5, previous.y + 0.5)*16,
#                Vector2(path_vector.x + 0.5, path_vector.y + 0.5)*16,
#                Color("#b2d90a"),
#                3.0
#            )
#        previous = path_vector
#
#    for tile_id in obstacles_of_ids:
#        var v = astar.get_point_position(tile_id)
#        draw_rect(Rect2(v.x*16, v.y*16, 16, 16), Color('#0000aa'))


#        var x = path_vector
#    for path_tile_id in self.path:
#
#        var t5 = astar.get_point_connections( path_tile_id )
#        var t7 = astar.get_point_position( path_tile_id )
#        var t8 = astar.get_point_weight_scale( path_tile_id )
#
#
#        var v = Vector3(grid[path_tile_id].center.x*tileWidth, grid[path_tile_id].center.y*tileHeight, 0)
#        pass
#        draw_line(
#            Vector2(grid[path_tile_id].center.x, grid[path_tile_id].center.y),
#            Vector2(randi()%100, randi()%100),
#            Color("#b2d90a"),
#            3.0
#        )

func setLines(value):
    obj_num = value
    $gui/block/label.text = str(value)

func drawCustom(type):
    obj_type = type
    update()

func drawLines2D():
    for c in $"2dlines_container".get_children():
        c.queue_free()
    for i in range(obj_num):
        var l = Line2D.new()
        l.add_point(Vector2(randi()%640, randi()%360))
        l.add_point(Vector2(randi()%640, randi()%360))
        l.width = 2
        $"2dlines_container".add_child(l)

func clearAll():
    for c in $"2dlines_container".get_children():
        c.queue_free()
    obj_type = -1
    update()

func _ready():
    randomize()

    var num = $gui/block/lines_num.value
    obj_num = num
    $gui/block/label.text = str(num)

    $gui/block/lines_num.connect('value_changed', self, 'setLines')

    $gui.find_node('b_draw_line').connect('pressed', self, 'drawCustom', [LINE])
    $gui.find_node('b_draw_polyline').connect('pressed', self, 'drawCustom', [POLYLINE])
    $gui.find_node('b_draw_circles').connect('pressed', self, 'drawCustom', [CIRCLE])
    $gui.find_node('b_draw_rect').connect('pressed', self, 'drawCustom', [RECT])
    $gui/b_draw_line2d.connect('pressed', self, 'drawLines2D')

    $gui/clear.connect('pressed', self, 'clearAll')

func _process(delta):
    $fps_container/fps.text = str(Engine.get_frames_per_second())