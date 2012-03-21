(function () {

    var sys = require("sys"),
        fs = require("fs"),
        path = require("path");

    task("default", function () {
        sys.puts("Run 'jake --tasks' to see possible tasks")
    });

    desc("Deploy the app onto the server");
    task("deploy", function () {
        sys.puts("Not implemented!");
    });

    desc("Run the local server");
    task("run-server", function () {
        require("./src/runServer.js");
    });

})();