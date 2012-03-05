define("luolis.game.rendering.Renderer", function (canvas) {
    this.canvas = canvas;
});

luolis.game.rendering.Renderer.prototype.initialize = function () { };

luolis.game.rendering.Renderer.prototype.render = function (world) {
    var ctx = this.canvas.getContext("2d");
    ctx.fillStyle = "rgb(0,0,0)";
    ctx.fillRect(0, 0, this.width, this.height);

    world.ships.forEach(drawShip);

    function drawShip (ship) {
        ctx.fillStyle = "rgb(255,255,255)";
        ctx.fillRect(ship.x-4, ship.y-4, 8, 8);
    }
};
