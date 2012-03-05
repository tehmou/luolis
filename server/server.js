var static = require('node-static'),
    coffee = require('coffee-script'),
    http = require('http');

var webroot = './public';

exports.open = function (port) {
    var file = new(static.Server)(webroot, {
        cache: 600,
        headers: { 'X-Powered-By': 'node-static' }
    });

    http.createServer(function(req, res) {

        req.addListener('end', function() {
            file.serve(req, res, function(err, result) {
                if (err) {
                    console.error('Error serving %s - %s', req.url, err.message);
                    if (err.status === 404 || err.status === 500) {
                        file.serveFile(err.status+'.html', err.status, {}, req, res);
                    } else {
                        res.writeHead(err.status, err.headers);
                        res.end();
                    }
                } else {
                    console.log(res);
                    console.log('%s - %s', req.url, res.message);
                }
            });
        });
    }).listen(port);

    console.log('node-static running at http://localhost:%d', port);
};