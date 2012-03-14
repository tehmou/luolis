(function () {

    var sys = require("sys"),
        exec = require("child_process").exec,
        fs = require("fs"),
        path = require("path");

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
        var folderStructure = { _name: "luolis" },
            indexCoffee = "";

        exec("mkdir docs/js", null, function () {
            readNamespaceInfo(JS_DIR);
            processDir(JS_DIR, folderStructure);
            fs.writeFileSync("docs/js/index.coffee", indexCoffee);
            exec("cd docs/js && node ../../node_modules/docco/bin/docco index.coffee", null, function () {
                exec("rm -rf docs/js/index.coffee");
            });
        });

        function readNamespaceInfo (currentPath) {
            var nsFilepath = currentPath + "/namespace.coffee";
            if (path.existsSync(nsFilepath)) {
                indexCoffee += "\n" + fs.readFileSync(nsFilepath) + "\n#\n";
            }
        }

        function processDir (dir, folder) {
            var contents = fs.readdirSync(dir);
            contents.forEach(function (item) {
                if (item === "lib") {
                    return;
                }
                var currentPath = dir + "/" + item;
                if (fs.statSync(currentPath).isDirectory()) {
                    indexCoffee += "# " + currentPath.replace("src/public/js/", "").replace(/\//g, ".") + "\n";
                    indexCoffee += "# --\n";
                    readNamespaceInfo(currentPath);
                    processDir(currentPath, folder[item] = { _name: item });
                } else {
                    if (item === "namespace.coffee") {
                        return;
                    }
                    folder[item] = "file";
                    indexCoffee += "# <a href='" + item.replace(".coffee", "") + ".html'>" + item + "</a><br />\n";

                    // FIXME: Must wait!!!

                    exec("cd docs/js && node ../../node_modules/docco/bin/docco ../../" + currentPath);
                }
                console.log(currentPath);
            });
        }
    });

    desc("Run the local server at port given in first argument");
    task("run-server", function (port) {
        port = port === undefined ? 9876 : port;
        require("./src/server.js").open(port, "./src/public");
    });

})();