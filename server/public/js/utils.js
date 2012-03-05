// Polyfill for bind function on Safari.
Function.prototype.bind = Function.prototype.bind || function (obj) {
    var fnc = this;
    return function () {
        fnc.apply(obj, arguments);
    };
};

// Provides requestAnimationFrame in a cross browser way.
window.requestAnimFrame = (function() {
    return window.requestAnimationFrame ||
        window.webkitRequestAnimationFrame ||
        window.mozRequestAnimationFrame ||
        window.oRequestAnimationFrame ||
        window.msRequestAnimationFrame ||
        function(/* function FrameRequestCallback */ callback, /* DOMElement Element */ element) {
            window.setTimeout(callback, 1000/60);
        };
})();

function define (path, obj) {
    defineWithRoot(window, path, obj);
}

function defineWithRoot (root, path, obj) {
    var part, parts = path.split(".");
    while (part = parts.shift()) {
        if (parts.length) {
            if (!root.hasOwnProperty(part)) {
                root[part] = {};
            }
        } else {
            if (root.hasOwnProperty(part)) {
                _.extend(root[part], obj);
            } else {
                root[part] = obj;
            }
        }
        root = root[part];
    }
}