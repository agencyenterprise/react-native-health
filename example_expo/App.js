import { StatusBar } from 'expo-status-bar'
import {
  NativeEventEmitter,
  NativeModules,
  StyleSheet,
  Text,
  View,
} from 'react-native'

import initializeAHK from './initializeAHK'

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#fff',
    alignItems: 'center',
    justifyContent: 'center',
  },
})

initializeAHK()

new NativeEventEmitter(NativeModules.AppleHealthKit).addListener(
  'healthKit:HeartRate:new',
  async () => {
    console.log('--> observer triggered')
  },
)

export default function App() {
  return (
    <View style={styles.container}>
      <Text>Checkout the Expo console</Text>
      <StatusBar style="auto" />
    </View>
  )
}
