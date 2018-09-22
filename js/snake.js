// {} is an empty object
// || if the variable on the left exists,
// set it to that.
// if the variable on the left doesn't exist,
// set it to what's on the right.
// ..
// If snake is already made set it to itself.
// If snake is not defined set to an empty object
var Snake = Snake || {};

// An associative array for grid types
Snake.gridTypes = {FLOOR: 0, WALL: 1, SNAKE: 2, FOOD: 3};

// create empty grid array
Snake.grid = [];

// create empty image array
Snake.imageFiles = [];

// Initialization
// pass in the id of the canvas, the level number, and
// a callback funtion to call when everything has loaded -- Game Loop preferably
Snake.init = function (canvas, level, loadingCompleteCallback)
{
    // load canvas
    Snake.canvasElement = document.getElementById(canvas);
    Snake.context = this.canvasElement.getContext("2d");
    
    // Load stuff
    Snake.loadImages();
    //Snake.loadGrid();
    Snake.loadGrid();
    
    // once the images are done loading, call the callback function
    Snake.waitForImages(loadingCompleteCallback);
}