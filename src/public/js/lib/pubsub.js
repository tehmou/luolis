function createPubSub (obj) {

    // the topic/subscription hash
    var cache = {};

    obj.publish = function(topic, args){
        cache[topic] && cache[topic].forEach(function(item) {
            item.apply(obj, args || []);
        });
    };

    obj.subscribe = function(topic, callback){
        if(!cache[topic]){
            cache[topic] = [];
        }
        cache[topic].push(callback);
        return [topic, callback];
    };

    obj.unsubscribe = function(handle){
        var t = handle[0];
        cache[t] && _.each(cache[t], function(idx){
            if(this == handle[1]){
                cache[t].splice(idx, 1);
            }
        });
    };

}
