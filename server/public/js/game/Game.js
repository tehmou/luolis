define("luolis.game.Game", function (world, physics) {
    this.world = world;
    this.physics = physics;
});

luolis.game.Game.prototype.updateFrame = function () {

    this.physics.apply(this.world);
};

luolis.game.Game.prototype.startSinglePlayerGame = function () {
    var ship = {
        x: this.world.width/2,
        y: this.world.height/2,
        xv: 0,
        yv: 0,
        angle: 0,
        shape: [ [0, -30], [-8, -8], [8, -8] ]
    };

    this.world.ships.push(ship);

    return ship;
};