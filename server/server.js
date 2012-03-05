var coffee = require("coffee-script"),
    express = require("express");

var webroot = './public';

exports.open = function (port) {

    var app = express.createServer();
    app.use(express.static(webroot));
    app.listen(port);

    console.log("express running at http://localhost:%d", port);
};