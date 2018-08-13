var isRun = false;

module.exports = function(dormain, callback) {
    if (isRun) {
        return callback(new Error('command is running!'));
    }

    isRun = true;
    cordova.exec(function(res) {
        isRun = false;
        callback(null, res);
    }, function(err) {
        isRun = false;
        callback(err);
    }, "netdiagno", "execRouteCheck", [dormain]);
};