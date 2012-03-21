exports.createGame = function (centralSocket) {
    var playerSockets = [];

    forwardPublicSignalToPlayers("requestInput", centralSocket);
    forwardPublicSignalToPlayers("worldJSON", centralSocket);

    function publishPublicSignal (signal, data) {
        centralSocket.emit(signal, data);
        publishPublicSignalToPlayers(signal, data);
    }

    function publishPublicSignalToPlayers (signal, data) {
        console.log("Broadcasting " + signal);
        playerSockets.forEach(function (socket) {
            socket.emit(signal, data);
        });
    }

    function forwardPublicSignalToPlayers (signal, socket) {
        console.log("Enabling public signal '" + signal + "'");
        socket.on(signal, function (data) {
            publishPublicSignal(signal, data);
        });
    }

    function forwardOneWaySignal (signal, fromSocket, toSocket) {
        console.log("Enabling one way signal '" + signal + "'");
        fromSocket.on(signal, function (data) {
            toSocket.emit(signal, data);
        });
    }

    return {
        join: function (socket, clientId) {
            console.log("Joining client" + clientId);
            playerSockets.push(socket);
            forwardOneWaySignal("input", socket, centralSocket);
            publishPublicSignal("joined", clientId);
        },
        part: function (socket, clientId) {
            console.log("Parting " + clientId);
            publishPublicSignal("parted", clientId);
            playerSockets = playerSockets.filter(function (s) { return s !== playerSockets; });
        },
        disconnected: function () {
            playerSockets = [];
        },
        getStatus: function () {
            return "running";
        },
        getNumPlayers: function () {
            return playerSockets.length-1;
        }
    }
};