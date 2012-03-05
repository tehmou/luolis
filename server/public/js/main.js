var luolis = {};

(function () {

    var canvas;

    luolis.createInstance = function () {

        return {
            run: function () {
                this.canvas = document.createElement("canvas");
                document.body.appendChild(this.canvas);

                this.ctx = this.canvas.getContext("2d");

                this.resize = this.resize.bind(this);
                this.render = this.render.bind(this);

                this.resize();
                this.render();
            },
            resize: function () {
                this.canvas.width = this.width = window.innerWidth;
                this.canvas.height = this.height = window.innerHeight;
            },
            render: function () {
                this.ctx.fillStyle = "rgb(0,0,0)";
                this.ctx.fillRect(0, 0, this.width, this.height);
                requestAnimFrame(this.render);
            }
        };

    };

    luolis.initialize = function () {
        var instance = luolis.createInstance();
        instance.run();
        document.body.onresize = instance.resize;
    };

})();
