var io = require('socket.io'),
    createGame = require("./nodeLuolisGame.js").createGame;

exports.open = function (app) {
    var ioApp = io.listen(app);
    var games = [];

    games.push(createGame());

    var getNextClientId = (function () {
        var lastClientId = -1;
        return function () {
            return ""+(++lastClientId);
        }
    })();

    ioApp.sockets.on("connection", function (socket) {
        socket.on("registerClient", function (data, fn) {
            var clientId = getNextClientId();
            fn(clientId);
            games[0].join(socket, clientId);
            console.log("Registered client with id=" + clientId);

            socket.on("disconnect", function () {
                console.log("Client disconnected, id=" + clientId);
                games[0].part(socket, clientId);
            });
        });

        socket.on("registerEngine", function (data, fn) {
            var clientId = getNextClientId();
            fn(clientId);
            games[0].joinEngine(socket, clientId);
            console.log("Registered engine with id=" + clientId);

            socket.on("disconnect", function () {
                console.log("Engine disconnected, id=" + clientId);
                games[0].partEngine(socket, clientId);
            });
        });

        socket.on("admin", function (data, fn) {
            var gamesJSON = [];
            games.forEach(function (game, index) {
                gamesJSON.push({
                    id: index,
                    status: game.getStatus()
                })
            });
            fn(gamesJSON);
        });
    });
};