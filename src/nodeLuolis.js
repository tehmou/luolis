var io = require('socket.io'),
    createGame = require("./nodeLuolisGame.js").createGame;

exports.open = function (app) {
    var ioApp = io.listen(app);
    var games = [];

    var getNextClientId = (function () {
        var lastClientId = -1;
        return function () {
            return ""+(++lastClientId);
        }
    })();

    ioApp.sockets.on("connection", function (socket) {
        socket.on("createGame", function (data, fn) {
            var game = createGame(socket);
            var index = games.push(game);
            fn(index);

            socket.on("disconnect", function () {
                game.disconnected();
                delete games[index];
            });
        });
        socket.on("register", function (data, fn) {
            var clientId = getNextClientId();
            fn(clientId);
            console.log("Registered client with id=" + clientId);

            socket.on("joinGame", function (data, fn) {
                if (games.hasOwnProperty(data)) {
                    fn("ok");
                    games[data].join(socket, clientId);
                    socket.on("disconnect", function () {
                        console.log("Client disconnected, id=" + clientId);
                        games[data].part(socket, clientId);
                    });
                } else {
                    fn("Could not find game '" + data + "'");
                }
            });
        });
        socket.on("listGames", function (data, fn) {
            var gamesJSON = [];
            games.forEach(function (game, index) {
                gamesJSON.push({
                    id: index,
                    status: game.getStatus(),
                    numPlayers: game.getNumPlayers()
                })
            });
            fn(gamesJSON);
        });
    });
};