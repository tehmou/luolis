exports.createGame = function (centralSocket) {
    var sockets = [];

    enablePublicSignals(centralSocket);

    function publishPublicSignal (signal, data) {
        console.log("Broadcasting " + signal);
        sockets.forEach(function (socket) {
            socket.emit(signal, data);
        });
    }

    function enablePublicSignal (signal, socket) {
        console.log("Enabling public signal '" + signal + "'");
        socket.on(signal, function (data) {
            publishPublicSignal(signal, data);
        });
    }

    function enablePublicSignals (socket) {
        [
            "worldJSON",
            "joined",
            "parted",
            "input",
            "requestInput"
        ].forEach(function (signal) {
            enablePublicSignal(signal, socket);
        });
        sockets.push(socket);
    }

    return {
        join: function (socket, clientId) {
            console.log("Joining client" + clientId);
            enablePublicSignals(socket);
            publishPublicSignal("joined", clientId);
        },
        part: function (socket, clientId) {
            console.log("Parting " + clientId);
            publishPublicSignal("parted", clientId);
            sockets = sockets.filter(function (s) { return s !== socket; });
        },
        getStatus: function () {
            return "running";
        },
        getNumPlayers: function () {
            return sockets.length-1;
        }
    }
};