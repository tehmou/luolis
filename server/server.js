var coffee = require("coffee-script"),
    express = require("express"),
    fs = require("fs"),
    path = require("path"),
    io = require('socket.io');

var webroot = './public';

exports.open = function (port) {

    var app = express.createServer(),
        ioApp = io.listen(app);

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
                    var coffeeJS = coffee.compile(""+fs.readFileSync(coffeePath));
                    res.send(coffeeJS);
                } catch (err) {
                    res.send(err.message);
                }
            } else {
                console.log("Serving JS file " + reqPath);
                res.sendfile(reqPath);
            }
        } else {
            console.log("Serving file " + reqPath);
            res.sendfile(reqPath);
        }
    });

    ioApp.sockets.on("connection", function (socket) {
        socket.emit("news", { hello: "world" });
        socket.on("my other event", function (data) {
            console.log(data);
        });
    });

    app.listen(port);

    console.log("express running at http://localhost:%d", port);
};