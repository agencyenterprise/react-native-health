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


let Index = require('./src/components/Index');


class BodyMeasurements extends Component {
  render() {
    return (
        <Navigator
            style={{ flex:1 }}
            initialRoute={{ name: 'Index' }}
            renderScene={ this.renderScene } />
    );

    //
    //
    //return (
    //  <View style={styles.container}>
    //    <Text style={styles.welcome}>
    //      Welcome to React Native!
    //    </Text>
    //    <Text style={styles.instructions}>
    //      To get started, edit index.ios.js
    //    </Text>
    //    <Text style={styles.instructions}>
    //      Press Cmd+R to reload,{'\n'}
    //      Cmd+D or shake for dev menu
    //    </Text>
    //  </View>
    //);
  }


  renderScene(route, navigator) {
    if(route.name == 'Index') {
      return <Index navigator={navigator} />
    }
    //if(route.name == 'Home') {
    //  return <Index navigator={navigator} />
    //}
  }


}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#F5FCFF',
  },
  welcome: {
    fontSize: 20,
    textAlign: 'center',
    margin: 10,
  },
  instructions: {
    textAlign: 'center',
    color: '#333333',
    marginBottom: 5,
  },
});

AppRegistry.registerComponent('BodyMeasurements', () => BodyMeasurements);
