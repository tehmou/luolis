define("luolis.game.Game", function (world) {
    this.world = world;
});

luolis.game.Game.prototype.initialize = function () { };

luolis.game.Game.prototype.updateFrame = function () {

};

luolis.game.Game.prototype.startSinglePlayerGame = function (input) {
    var ship = {
        x: this.world.width/2,
        y: this.world.height/2
    };

    this.world.ships.push(ship);

    input.attachShip(ship);
};