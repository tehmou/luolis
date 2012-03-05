define("luolis.game.rendering.Renderer", function (canvas) {
    this.canvas = canvas;
});

luolis.game.rendering.Renderer.prototype.initialize = function () { };

luolis.game.rendering.Renderer.prototype.attachShip = function (ship) {
    this.ship = ship;
};

(function () {

luolis.game.rendering.Renderer.prototype.render = function (world) {
    var ctx = this.canvas.getContext("2d");
    ctx.fillStyle = "rgb(0,0,0)";
    ctx.fillRect(0, 0, this.width, this.height);

    var offsetX = this.ship.x - this.width/2;
    offsetX = Math.max(offsetX, 0);
    offsetX = Math.min(offsetX, world.width-this.width);

    var offsetY = this.ship.y - this.height/2;
    offsetY = Math.max(offsetY, 0);
    offsetY = Math.min(offsetY, world.height-this.height);

    renderAt(ctx, world, offsetX, offsetY);
};

function renderAt (ctx, world, offsetX, offsetY) {

    world.ships.forEach(drawShip);

    ctx.strokeStyle = "rgb(255,255,255)";
    ctx.beginPath();
    drawPolygon([[6,6],[6,world.height-6],[world.width-6,world.height-6],[world.width-6,6]],-offsetX,-offsetY);
    ctx.stroke();

    function drawShip (ship) {
        ctx.fillStyle = "rgb(255,255,255)";
        ctx.beginPath();
        drawPolygon(ship.shape, ship.x-offsetX, ship.y-offsetY);
        ctx.fill();
        //ctx.font = "10px Arial";
        //ctx.fillStyle = "white";
        //ctx.fillText(~~ship.x+","+~~ship.y, ship.x-offsetX, ship.y+10-offsetY);
    }

    function drawPolygon (polygon, x, y) {
        for (var i = 0; i < polygon.length; i++) {
            if (i === 0) {
                ctx.moveTo(x+polygon[i][0], y+polygon[i][1]);
            } else {
                ctx.lineTo(x+polygon[i][0], y+polygon[i][1]);
            }
        }
        ctx.closePath();
    }
}

})();
