(function () {

    var sys = require("sys"),
        fs = require("fs"),
        path = require("path"),
        wrench = require("wrench");

    var JS_DIR = "src/public/js";
    var DOCS_DIR = "docs";
    var BUILD_DIR = "build";

    task("default", ["build-docs"]);

    desc("Build the documentation");
    task("build-docs", ["clean-docs", "build-server-docs", "build-client-docs"]);

    desc("Clean documentation");
    task("clean-docs", function () {
        var dir = path.join(DOCS_DIR, BUILD_DIR);
        wrench.rmdirSyncRecursive(dir, true);
        fs.mkdirSync(dir, 0775);
    });

    desc("Build server documentation");
    task("build-server-docs", function () {
        sys.puts("Not implemented!");
    }, true);

    desc("Build client documentation");
    task("build-client-docs", function () {
        sys.puts("Not implemented!");
    }, true);

})();