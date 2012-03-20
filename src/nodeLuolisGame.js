exports.createGame = function () {
    var sockets = [];

    function enablePublicSignal (signal, socket) {
        console.log("Enabling public signal '" + signal + "'");
        socket.on(signal, function (data) {
            console.log("Broadcasting " + signal);
            sockets.forEach(function (socket) {
                socket.emit(signal, data);
            });
        });
    }

    function enablePublicSignals (socket) {
        [
            "worldJSON",
            "requestJoin",
            "joined",
            "requestPart",
            "parted",
            "input",
            "requestInput"
        ].forEach(function (signal) {
            enablePublicSignal(signal, socket);
        });
    }

    return {
        join: function (socket) {
            enablePublicSignals(socket);
            sockets.push(socket);

        }
    }
};