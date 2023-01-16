/**
 * @format
 */

import { AppRegistry, NativeEventEmitter, NativeModules } from 'react-native';
import App from './App';
import { name as appName } from './app.json';

AppRegistry.registerComponent(appName, () => {
    new NativeEventEmitter(NativeModules.AppleHealthKit).addListener('healthKit:HeartRate:new', async () => {
        console.log('new sample')
    })
    return App
});
