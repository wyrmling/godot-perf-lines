extends Node2D

var line_num : int
var lines : Array
#var obstacles_of_vectors : PoolVector3Array

func _draw():
    for arr in lines:
        draw_line(
            arr[0],
            arr[1],
            Color("#b2d90a"),
            3.0
        )
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
    line_num = value
    $gui/block/label.text = str(value)

func drawLines():
    lines.clear()
    for i in range(line_num):
        lines.append([Vector2(randi()%640, randi()%360), Vector2(randi()%640, randi()%360)])
    update()

func _ready():
    $gui/block/label.text = str($gui/block/lines_num.value)
    $gui/block/lines_num.connect('value_changed', self, 'setLines')
#    $gui/block/lines_num.connect('valueChanged', self, 'setLines', ['test'])
    $gui/b_draw.connect('pressed', self, 'drawLines')


#    $gui/Start.connect('valueChanged', self, 'calculatePath')
#    $gui/End.connect('valueChanged', self, 'calculatePath')

func _process(delta):
    $fps_container/fps.text = str(Engine.get_frames_per_second())