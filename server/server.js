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
                    var contents = fs.readFileSync(coffeePath);
                    var name =/\/([a-zA-Z0-9]*)\..*$/.exec(reqPath)[1];
                    var fnc = 'log = () -> Function.prototype.bind.call(console.log, console).apply(console, ["[' + name + ']"].concat(Array.prototype.slice.call(arguments)));\n';
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
        } else {
            console.log("Serving file " + reqPath);
            res.sendfile(reqPath);
        }
    });



    ioApp.sockets.on("connection", function (socket) {
        socket.on("start", function (data, fn) {
            fn("started");
            console.log(data);
        });
    });

    app.listen(port);

    console.log("express running at http://localhost:%d", port);
};