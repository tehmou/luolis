(function () {

    var sys = require("sys"),
        exec = require("child_process").exec,
        spawn = require("child_process").spawn,
        fs = require("fs");

    task("default", function () {
        sys.puts("Run 'jake --tasks' to see possible tasks")
    });

    desc("Build the documentation");
    task("build-docs", ["clean-docs", "build-server-docs", "build-client-docs"]);

    desc("Clean documentation");
    task("clean-docs", function () {
        exec("rm -rf docs");
        exec("mkdir docs");
    });

    desc("Build server documentation");
    task("build-server-docs", function () {
        exec("node ./node_modules/docco/bin/docco src/server.js");
    });

    desc("Build client documentation");
    task("build-client-docs", function () {
        var jsDir = "src/public/js/";

        exec("mkdir docs/js");
        function processDir (dir) {
            var contents = fs.readdirSync(dir);
            contents.forEach(function (item) {
                var path = dir + "/" + item;
                if (fs.statSync(path).isDirectory()) {
                    processDir(path);
                }
                console.log(path);
                //spawn("node", ["./node_modules/docco/bin/docco", "src/public/js/luolis.coffee", "src/public/js/broker/LocalBroker.coffee"])
            });
        }

        processDir(jsDir);
    });

    desc("Run the local server at port given in first argument");
    task("run-server", function (port) {
        port = port === undefined ? 9876 : port;
        require("./src/server.js").open(port);
    });

})();