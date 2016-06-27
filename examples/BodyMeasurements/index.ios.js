/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 * @flow
 */

import React, { Component } from 'react';
import {
  AppRegistry,
  StyleSheet,
  Navigator,
  Text,
  View
} from 'react-native';

let App = require('./app/app');

class BodyMeasurements extends Component {
  render() {
    return (
        <App />
    )
  }
}

AppRegistry.registerComponent('BodyMeasurements', () => BodyMeasurements);
