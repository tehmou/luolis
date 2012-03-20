exports.createGame = function () {
    var sockets = [];

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
    }

    return {
        join: function (socket, clientId) {
            console.log("Joining client" + clientId);
            enablePublicSignals(socket);
            sockets.push(socket);
            publishPublicSignal("joined", clientId);
        },
        joinEngine: function (socket, clientId) {
            console.log("Joining engine" + clientId);
            enablePublicSignals(socket);
            sockets.push(socket);
        },
        part: function (socket, clientId) {
            console.log("Parting " + clientId);
            publishPublicSignal("parted", clientId);
            sockets = sockets.filter(function (s) { return s !== socket; });
        },
        partEngine: function (socket, clientId) {
            sockets = sockets.filter(function (s) { return s !== socket; });
        },
        getStatus: function () {
            return {
                status: "running"
            };
        }
    }
};