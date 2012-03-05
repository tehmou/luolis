define("luolis.game.input.KeyboardInput", function (world) {
    this.world = world;
});

luolis.game.input.KeyboardInput.prototype.initialize = function () { };

luolis.game.input.KeyboardInput.prototype.attachShip = function (ship) {
    var LEFT = 37,
        RIGHT = 39,
        UP = 38,
        DOWN = 40;

    document.body.onkeydown = function (e) {
        switch (e.keyCode) {
            case LEFT:
                ship.x -= 3;
                break;

            case RIGHT:
                ship.x += 3;
                break;

            case UP:
                ship.y -= 3;
                break;

            case DOWN:
                ship.y += 3;
                break;
        }
    };
};