/**
 * Created by greg on 2016-06-28.
 */

var airflux = require('airflux');

let actions = {
    saveWeight: new airflux.Action().asFunction,
    saveHeight: new airflux.Action().asFunction,
};

module.exports = actions;
export default actions;
