define("luolis.game.input.KeyboardInput", function () {
    this.inputMap = {};

    var keyCodes = {
        37: "LEFT",
        39: "RIGHT",
        38: "UP",
        40: "DOWN"
    };

    document.body.onkeydown = function (e) {
        if (keyCodes.hasOwnProperty(e.keyCode)) {
            this.inputMap[keyCodes[e.keyCode]] = true;
        }
    }.bind(this);

    document.body.onkeyup = function (e) {
        if (keyCodes.hasOwnProperty(e.keyCode)) {
            this.inputMap[keyCodes[e.keyCode]] = false;
        }
    }.bind(this);
});
