/**
 * Created by greg on 2016-06-30.
 */

import React, { Component } from 'react';
import {
    AppRegistry,
    StyleSheet,
    Navigator,
    Text,
    View
} from 'react-native';


let Home = require('./components/home/index');
let Add = require('./components/add/index');


class StepsDemoApp extends Component {
    render() {
        return (
            <Navigator
                style={{ flex:1 }}
                initialRoute={{ name: 'Home' }}
                renderScene={ this.renderScene } />
        );
    }

    renderScene(route, navigator) {
        if(route.name == 'Home') {
            return <Home navigator={navigator} />
        }
        if(route.name == 'Add') {
            return <Add navigator={navigator} />
        }
    }
}

module.exports = StepsDemoApp;
export default StepsDemoApp;
