var io = require('socket.io'),
    createGame = require("./nodeLuolisGame.js").createGame;

exports.open = function (app) {
    var ioApp = io.listen(app);
    var lastClientId = 0
    var games = [];

    games.push(createGame());

    ioApp.sockets.on("connection", function (socket) {
        socket.on("register", function (data, fn) {
            var clientId = ""+lastClientId;
            fn(clientId);
            games[0].join(socket, clientId);
            console.log("Registered client with id=" + lastClientId);
            lastClientId++;
        });

        socket.on("admin", function (data, fn) {

        });
    });
};