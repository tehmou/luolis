//
// Server that serves static files and compiles coffee script
// on the fly. Initial web sockets support included.
//
// For files it uses [express.js] and [socket.io] for web sockets.
//
//  [express.js]: http://expressjs.com/
//  [socket.io]: http://socket.io/
//
var coffee = require("coffee-script"),
    express = require("express"),
    fs = require("fs"),
    path = require("path"),
    nodeLuolis = require("./nodeLuolis.js");


exports.open = function (port, webroot) {

    webroot = webroot || './public';
    var app = express.createServer();

    app.get("*", function (req, res) {
        var reqPath = webroot + req.params[0];
        if (reqPath.substr(reqPath.length-1) === "/") {
            reqPath += "index.html";
        }

        console.log("Requested file " + reqPath);

        if (reqPath.match(/\.js$/)) {
            var coffeePath = reqPath.replace(/\.js$/, ".coffee");
            if (path.existsSync(coffeePath)) {
                console.log("Compile coffee for " + coffeePath);
                try {
                    var contents = fs.readFileSync(coffeePath);
                    var name =/\/([a-zA-Z0-9]*)\..*$/.exec(reqPath)[1];
                    var fnc = 'log = () -> window.log.apply(console, ["[' + name + ']"].concat(Array.prototype.slice.call(arguments)));\n';
                    contents = fnc + contents;
                    var coffeeJS = coffee.compile(contents);
                    res.send(coffeeJS);
                } catch (err) {
                    res.send(err.message);
                }
            } else {
                console.log("Serving JS file " + reqPath);
                res.sendfile(reqPath);
            }
        } else if (reqPath.match(/\.html$/)) {
            res.send((""+fs.readFileSync(reqPath)).replace("${SERVER_ADDRESS}", SERVER_ADDRESS));
        } else {
            console.log("Serving file " + reqPath);
            res.sendfile(reqPath);
        }
    });

    nodeLuolis.open(app);

    app.listen(port);

    var SERVER_ADDRESS = "http://" + app.address().address + ":" + app.address().port;
    console.log("express running at " + SERVER_ADDRESS);
};