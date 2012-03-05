// Define the basic namespace, and a way to safely define more.
define("luolis", { });

(function () {

    luolis.Instance = function () {
        return {
            run: function () {
                this.canvas = document.createElement("canvas");
                document.body.appendChild(this.canvas);

                this.world = new luolis.game.model.World(window.innerWidth*1.4, window.innerHeight*1.4);
                this.world.initialize();

                this.game = new luolis.game.Game(this.world);
                this.game.initialize();
                var ship = this.game.startSinglePlayerGame(this.input);

                this.renderer = new luolis.game.rendering.Renderer(this.canvas);
                this.renderer.initialize();
                this.renderer.attachShip(ship);

                this.input = new luolis.game.input.KeyboardInput(this.world);
                this.input.initialize();
                this.input.attachShip(ship);

                this.resize = this.resize.bind(this);
                this.render = this.render.bind(this);
                this.resize();
                this.render();
            },
            resize: function () {
                this.renderer.width = this.canvas.width = window.innerWidth;
                this.renderer.height = this.canvas.height = window.innerHeight;
            },
            render: function () {
                this.game.updateFrame();
                this.renderer.render(this.world);
                requestAnimFrame(this.render);
            }
        };
    };

    luolis.initialize = function () {
        var instance = new luolis.Instance();
        instance.run();
        document.body.onresize = instance.resize;
    };

})();
