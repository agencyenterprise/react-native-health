import { StatusBar } from 'expo-status-bar'
import { useEffect } from 'react'
import { StyleSheet, Text, View } from 'react-native'
// import AppleHealthKit, { HealthType, WorkoutQuery } from 'react-native-health'
import * as AppleHealthKit from 'react-native-health'

export default function App() {
  const startHK = async () => {
    console.log('--> Initializing HealthKit...')
    console.log(AppleHealthKit)

    try {
      // const initialized = await AppleHealthKit.initHealthKit(
      //   [HealthType.HeartRate],
      //   [],
      // )
      // const workouts = await AppleHealthKit.getWorkouts({
      //   startDate: new Date(2021, 0, 1).toISOString(),
      //   endDate: new Date().toISOString(),
      // } as WorkoutQuery)
      // console.log({ initialized })
    } catch (error) {
      console.log({ error })
    }
  }

  useEffect(() => {
    startHK()
  }, [])

  return (
    <View style={styles.container}>
      <Text>React Native Health typescript!</Text>
      <StatusBar style="auto" />
    </View>
  )
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#fff',
    alignItems: 'center',
    justifyContent: 'center',
  },
})
