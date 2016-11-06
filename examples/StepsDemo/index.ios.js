/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 * @flow
 */

import React, { Component } from 'react';
import {
  AppRegistry,
  StyleSheet,
  Text,
  View
} from 'react-native';

require('RCTNativeAppEventEmitter')

import App from './app/app';

class StepsDemo extends Component {
  render() {
    return (
      <App />
    );
  }
}

AppRegistry.registerComponent('StepsDemo', () => StepsDemo);
