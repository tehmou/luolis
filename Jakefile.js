(function () {

    var sys = require("sys");

    task("default", function () {
        sys.puts("Run 'jake --tasks' to see possible tasks")
    });

    desc("Build the documentation");
    task("build-docs", function () {

    });

    desc("Run the local server at port given in first argument");
    task("run-server", function (port) {
        port = port === undefined ? 9876 : port;
        require("./src/server.js").open(port);
    });

})();