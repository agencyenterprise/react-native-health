/**
 * Created by greg on 2016-06-27.
 */

import React, { Component } from 'react';
import {
    AppRegistry,
    StyleSheet,
    Navigator,
    Text,
    View
} from 'react-native';


let Dashboard = require('./components/dashboard/dashboard');
let Weight = require('./components/weight/weight');
let Height = require('./components/height/height');
let BodyMassIndex = require('./components/bodyMassIndex/bodyMassIndex');
let BodyFatPercentage = require('./components/bodyFatPercentage/bodyFatPercentage');
let LeanBodyMass = require('./components/leanBodyMass/leanBodyMass');


class BodyMeasurementsApp extends Component {
    render() {
        return (
            <Navigator
                style={{ flex:1 }}
                initialRoute={{ name: 'Dashboard' }}
                renderScene={ this.renderScene } />
        );
    }

    renderScene(route, navigator) {
        if(route.name == 'Dashboard') {
            return <Dashboard navigator={navigator} />
        }
        if(route.name == 'Weight') {
            return <Weight navigator={navigator} />
        }
        if(route.name == 'Height') {
            return <Height navigator={navigator} />
        }
        if(route.name == 'BodyMassIndex') {
            return <BodyMassIndex navigator={navigator} />
        }
        if(route.name == 'BodyFatPercentage') {
            return <BodyFatPercentage navigator={navigator} />
        }
        if(route.name == 'LeanBodyMass') {
            return <LeanBodyMass navigator={navigator} />
        }
    }
}

module.exports = BodyMeasurementsApp;
export default BodyMeasurementsApp;
