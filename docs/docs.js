var sys = require("sys"),
    exec = require("child_process").exec,
    fs = require("fs"),
    wrench = require("wrench"),
    path = require("path"),
    jodoc = require("./lib/jodoc-lib.js");

var BUILD_DIR = "build";

exports.clean = function (DOCS_DIR) {
    var dir = DOCS_DIR + "/" + BUILD_DIR;
    wrench.rmdirSyncRecursive(dir, true);
    fs.mkdirSync(dir, 0775);
};

exports.buildServerDocs = function (DOCS_DIR, JS_DIR, complete) {

};

exports.buildClientDocs = function (DOCS_DIR, JS_DIR, complete) {

};