define("luolis.game.model.World", function (width, height) {
    this.width = width;
    this.height = height;
});

luolis.game.model.World.prototype.initialize = function () {
    this.reset();
};

luolis.game.model.World.prototype.reset = function () {
    this.ships = [];
};