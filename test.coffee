COLS = 26
ROWS = 26

EMPTY = 0
SNAKE = 1
FRUIT = 2

LEFT = 0
UP = 1
RIGHT = 2
DOWN = 3

KEY_LEFT = 37
KEY_UP = 38
KEY_RIGHT = 39
KEY_DOWN = 40

canvas = null
ctx = null
keystate = null
frames = null
score = null
highscore = 0

grid =
    width: null
    height: null
    _grid: null

    init: (d, c, r) ->
        this.width = c
        this.height = r
        this._grid = []

        for x in [0..c] by 1
            this._grid.push([])
            for y in [0..r] by 1
                this._grid[x].push(d)

    set: (val, x, y) -> this._grid[x][y] = val

    get: (x, y) -> this._grid[x][y]

snake =
    direction: null
    last: null
    _queue: null

    init: (d, x, y) ->
        this.direction = d
        this._queue = []
        this.insert(x, y)

    insert: (x, y) ->
        this._queue.unshift({x:x, y:y})
        this.last = this._queue[0]

    remove: () -> this._queue.pop()

setFood = () ->
    empty = []
    for x in [0..grid.width-1] by 1
        for y in [0..grid.height-1] by 1
            empty.push({x:x, y:y}) if grid.get(x, y) is EMPTY

    randpos = empty[Math.floor(Math.random() * empty.length)]
    grid.set(FRUIT, randpos.x, randpos.y)

main = () ->
    canvas = document.createElement("canvas")
    canvas.width = COLS * 20
    canvas.height = ROWS * 20
    ctx = canvas.getContext("2d")
    document.body.appendChild(canvas)
    ctx.font = "bold 15px Calibri"

    frames = 0
    keystate = {}

    document.addEventListener("keydown", (evt) -> keystate[evt.keyCode] = true)
    document.addEventListener("keyup", (evt) -> keystate[evt.keyCode] = false)

    init()
    gameloop()

init = () ->
    highscore = score if score > highscore
    score = 0

    grid.init(EMPTY, COLS, ROWS)

    sp = {x:Math.floor(COLS/2), y:ROWS-1}
    snake.init(UP, sp.x, sp.y)
    grid.set(SNAKE, sp.x, sp.y)

    setFood()

gameloop = () ->
    update()
    draw()

    window.requestAnimationFrame(gameloop, canvas)

update = () ->
    frames++

    snake.direction = LEFT if keystate[KEY_LEFT] and snake.direction isnt RIGHT
    snake.direction = RIGHT if keystate[KEY_RIGHT] and snake.direction isnt LEFT
    snake.direction = UP if keystate[KEY_UP] and snake.direction isnt DOWN
    snake.direction = DOWN if keystate[KEY_DOWN] and snake.direction isnt UP

    if frames % 5 is 0
        nx = snake.last.x
        ny = snake.last.y

        switch snake.direction
            when LEFT then nx--
            when UP then ny--
            when RIGHT then nx++
            when DOWN then ny++

        if nx < 0 or nx > grid.width - 1 or ny < 0 or ny > grid.height - 1 or grid.get(nx, ny) is SNAKE
            return init()

        if grid.get(nx, ny) is FRUIT
            tail = {x:nx, y:ny}
            score++
            setFood()
        else
            tail = snake.remove()
            grid.set(EMPTY, tail.x, tail.y)
            tail.x = nx
            tail.y = ny

        grid.set(SNAKE, tail.x, tail.y)
        snake.insert(tail.x, tail.y)

draw = () ->
    tw = canvas.width/grid.width
    th = canvas.height/grid.height

    for x in [0..grid.width-1] by 1
        for y in [0..grid.height-1] by 1
            switch grid.get(x, y)
                when EMPTY then ctx.fillStyle = "#fff"
                when SNAKE then ctx.fillStyle = "#0f0"
                when FRUIT then ctx.fillStyle = "#f00"
            ctx.fillRect(x * tw, y * th, tw, th)

    ctx.fillStyle = "#000"
    ctx.fillText("HIGHSCORE: " + highscore, 10, 20)
    ctx.fillText("SCORE: " + score, 10, canvas.height - 10)

main()