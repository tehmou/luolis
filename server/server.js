var coffee = require("coffee-script"),
    express = require("express"),
    fs = require("fs");

var webroot = './public';

exports.open = function (port) {

    var app = express.createServer();

    app.get("*", function (req, res) {
        var path = "./public/" + req.params[0];
        if (path.substr(path.length-1) === "/") {
            path += "index.html";
        }
        res.sendfile(path);
    });

    app.listen(port);

    console.log("express running at http://localhost:%d", port);
};