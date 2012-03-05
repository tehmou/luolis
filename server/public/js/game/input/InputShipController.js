define("luolis.game.input.InputShipController", function (ship, input) {
    this.ship = ship;
    this.input = input;
});

luolis.game.input.InputShipController.prototype.update = function () {
    if (this.input.LEFT) {
        this.ship.xv -= 1;
    }
    if (this.input.RIGHT) {
        this.ship.xv += 1;
    }
    if (this.input.UP) {
        this.ship.yv -= 1;
    }
    if (this.input.DOWN) {
        this.ship.yv += 1;
    }
};