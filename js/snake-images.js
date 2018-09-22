// If Snake doesn't exist yet make it an empty object
var Snake = Snake || {};

Snake.loadImages = function()
{
    // set up image
    // First = image file, Second = actual image object
    Snake.imageFiles[Snake.gridTypes.FLOOR] = ['https://raw.githubusercontent.com/davethesoftwaredev/SnakeGame/master/1/img/floor.png', null];
    Snake.imageFiles[Snake.gridTypes.WALL] = ['https://raw.githubusercontent.com/davethesoftwaredev/SnakeGame/master/1/img/wall.png', null];
    Snake.imageFiles[Snake.gridTypes.SNAKE] = ['https://raw.githubusercontent.com/davethesoftwaredev/SnakeGame/master/1/img/snake.png', null];
    Snake.imageFiles[Snake.gridTypes.FOOD] = ['https://raw.githubusercontent.com/davethesoftwaredev/SnakeGame/master/1/img/food.png', null];
    
    // callback will change this
    Snake.imagesLoaded = 0;
    
    for(var i = 0; i < Snake.imageFiles.length; i++)
    {
        // using the img urls, we create the actual image objects
        var item = Snake.imageFiles[i];
        item[1] = new Image();
        item[1].src = item[0];
        item[1].onload = Snake.onImageLoaded;
    }
}

// everytime an image is loaded, increment the counter
Snake.onImageLoaded = function()
{
    Snake.imagesLoaded++;
}

// function that waits for the images to finish loading before calling the callback function
Snake.waitForImages = function(callback)
{
    window.setTimeout(function()
    {
        if (Snake.imagesLoaded != Snake.imageFiles.length)
        {
            window.setTimeout(arguments.callee, 10);
        }
        else
        {
            callback();
        }
    }, 0);
}













