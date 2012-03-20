var io = require('socket.io');

exports.open = function (app) {
    var ioApp = io.listen(app);
    var lastClientId = 0
    var game = require("./nodeLuolisGame.js").createGame();

    ioApp.sockets.on("connection", function (socket) {
        socket.on("register", function (data, fn) {
            fn(""+lastClientId);
            game.join(socket);
            console.log("Registered client with id=" + lastClientId);
            lastClientId++;
        });
    });
};