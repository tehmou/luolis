(function () {

    var sys = require("sys"),
        exec = require("child_process").exec,
        fs = require("fs"),
        path = require("path"),
        docs = require("./docs/docs.js");

    var JS_DIR = "src/public/js";
    var DOCS_DIR = "docs";

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

    desc("Build the documentation");
    task("build-docs", ["clean-docs", "build-server-docs", "build-client-docs"]);

    desc("Clean documentation");
    task("clean-docs", function () {
        docs.clean(DOCS_DIR, JS_DIR);
    });

    desc("Build server documentation");
    task("build-server-docs", function () {
        docs.buildServerDocs(DOCS_DIR, JS_DIR, complete);
    }, true);

    desc("Build client documentation");
    task("build-client-docs", function () {
        docs.buildClientDocs(DOCS_DIR, JS_DIR, complete);
    }, true);

})();