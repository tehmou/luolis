define("luolis.game.physics.Physics", function () {
    this.gravity = 0.1;
});

luolis.game.physics.Physics.prototype.apply = function (world) {
    var gravity = this.gravity;

    world.ships.forEach(applyGravity);
    world.ships.forEach(processShip);

    function applyGravity (ship) {
        ship.yv += gravity;
    }

    function processShip (ship) {
        ship.x += ship.xv;
        ship.y += ship.yv;
        if (ship.x < 0) {
            ship.xv = 0;
            ship.x = 0;
        }
        if (ship.x > world.width) {
            ship.xv = 0;
            ship.x = world.width;
        }
        if (ship.y < 0) {
            ship.yv = 0;
            ship.y = 0;
        }
        if (ship.y > world.height) {
            ship.yv = 0;
            ship.y = world.height;
        }
    }
};