define("luolis.game.Game", function (world) {
    this.world = world;
});

luolis.game.Game.prototype.initialize = function () { };

luolis.game.Game.prototype.updateFrame = function () {

};

luolis.game.Game.prototype.startSinglePlayerGame = function () {
    var ship = {
        x: this.world.width/2,
        y: this.world.height/2,
        angle: 0,
        shape: [ [0, -30], [-8, -8], [8, -8] ]
    };

    this.world.ships.push(ship);

    return ship;
};