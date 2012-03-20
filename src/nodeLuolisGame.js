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
            console.log("Joining " + clientId);
            enablePublicSignals(socket);
            sockets.push(socket);
            publishPublicSignal("joined", clientId);
        },
        getStatus: function () {
            return {
                status: "running"
            };
        }
    }
};