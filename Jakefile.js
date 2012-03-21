(function () {

    var sys = require("sys"),
        fs = require("fs"),
        path = require("path");

    task("default", function () {
        sys.puts("Run 'jake --tasks' to see possible tasks")
    });

    desc("Run the server in the port given in first argument")
    task("run-server", function (port) {
        require("./server/server.js").open(port || 9876, "./client");
    });

    desc("Deploy the app onto the server");
    task("deploy", function () {
        sys.puts("Not implemented!");
    });

})();