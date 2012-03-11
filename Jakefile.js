(function () {

    var sys = require("sys"),
        exec = require("child_process").exec,
        fs = require("fs");

    var JS_DIR = "src/public/js";

    task("default", function () {
        sys.puts("Run 'jake --tasks' to see possible tasks")
    });

    desc("Build the documentation");
    task("build-docs", ["clean-docs", "build-server-docs", "build-client-docs"]);

    desc("Clean documentation");
    task("clean-docs", function () {
        exec("rm -rf docs", null, function () {
            exec("mkdir docs", null, complete);
        });
    }, true);

    desc("Build server documentation");
    task("build-server-docs", function () {
        exec("mkdir docs/server", null, function () {
            exec("cd docs/server && node ../../node_modules/docco/bin/docco ../../src/server.js", null, complete);
        });
    }, true);

    // FIXME: This task should be async, but it is very difficult to make it so..
    desc("Build client documentation");
    task("build-client-docs", function () {
        exec("mkdir docs/js", null, function () {
            processDir(JS_DIR);
        });
        function processDir (dir) {
            var contents = fs.readdirSync(dir);
            contents.forEach(function (item) {
                if (item === "lib") {
                    return;
                }
                var path = dir + "/" + item;
                if (fs.statSync(path).isDirectory()) {
                    processDir(path);
                } else {
                    // FIXME: Must wait!!!
                    exec("cd docs/js && node ../../node_modules/docco/bin/docco ../../" + path);
                }
                console.log(path);
            });
        }
    });

    desc("Run the local server at port given in first argument");
    task("run-server", function (port) {
        port = port === undefined ? 9876 : port;
        require("./src/server.js").open(port);
    });

})();