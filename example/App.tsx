import React, { useEffect } from 'react';
import {
  SafeAreaView,
  StyleSheet,
  ScrollView,
  View,
  Text,
  StatusBar,
  Button,
} from 'react-native';

import RNHealthKit, { HealthType, HealthUnit, StatisticsOption, Interval, WorkoutActivityType } from 'react-native-health';

RNHealthKit.initHealthKit(
  [HealthType.HeartRate, HealthType.Workout],
  [HealthType.HeartRate, HealthType.Workout],
);

async function runQuantityQuery() {
  const result = await RNHealthKit.getQuantitySamples(
    {
      type: HealthType.HeartRate,
      startDate: new Date(2023, 7, 1).toISOString(),
      endDate: new Date().toISOString(),
      unit: HealthUnit.BeatsPerMinute,
    },
  );
  console.log(result);
}

async function runStatisticsQuery() {
  const result = await RNHealthKit.getQuantitySamplesStatistics(
    {
      type: HealthType.ActiveEnergyBurned,
      startDate: new Date(2022, 0, 1).toISOString(),
      endDate: new Date(2024, 0, 1).toISOString(),
      interval: Interval.Year,
      anchorDate: new Date(2023, 0, 1).toISOString(),
      unit: HealthUnit.Kilocalories,
      option: StatisticsOption.CumulativeSum,
    },
  );
  console.log(result);
}

async function saveQuantitySample() {
  const result = await RNHealthKit.saveQuantitySample(
    HealthType.HeartRate,
    {
      startDate: new Date().toISOString(),
      endDate: new Date().toISOString(),
      value: 82,
      unit: HealthUnit.BeatsPerMinute,
      metadata: {
        "TestingMetadata": "TestingValue"
      },
    },
  );
  console.log(result);
}

async function runWorkoutQuery() {
  const result = await RNHealthKit.getWorkouts(
    {
      startDate: new Date(2023, 7, 1).toISOString(),
      endDate: new Date().toISOString(),
      activityTypes: [WorkoutActivityType.Pickleball]
    },
  );
  console.log(result);
}

async function saveWorkout() {
  const result = await RNHealthKit.saveWorkout(
    {
      activityType: WorkoutActivityType.Pickleball,
      startDate: new Date(2023, 8, 8, 4).toISOString(),
      endDate: new Date(2023, 8, 8, 5).toISOString(),
    },
  );
  console.log(result);
}

export default function App() {
  // const [authStatus, setAuthStatus] = useState<any>({});

  useEffect(() => {
    // new NativeEventEmitter(NativeModules.AppleHealthKit).addListener(
    //   'healthKit:HeartRate:new',
    //   async () => {
    //     console.log('--> observer triggered');
    //   },
    // );
  });

  return (
    <>
      <StatusBar barStyle="dark-content" />
      <SafeAreaView>
        <ScrollView
          contentInsetAdjustmentBehavior="automatic"
          style={styles.scrollView}>
          <View style={styles.body}>
            <View style={styles.sectionContainer}>
              <Text style={styles.sectionTitle}>
                React Native Health Example
              </Text>
              <Button
                title="Run Quantity Query"
                onPress={() => {
                  runQuantityQuery();
                }}
              />
              <Button
                title="Run Statistics Query"
                onPress={() => {
                  runStatisticsQuery();
                }}
              />
              <Button
                title="Save Quantity Sample"
                onPress={() => {
                  saveQuantitySample();
                }}
              />
              <Button
                title="Get Workout Samples"
                onPress={() => {
                  runWorkoutQuery();
                }}
              />
              <Button
                title="Save Workout"
                onPress={() => {
                  saveWorkout();
                }}
              />
            </View>
          </View>
        </ScrollView>
      </SafeAreaView>
    </>
  );
}

const styles = StyleSheet.create({
  scrollView: {
    backgroundColor: '#f5f5f5',
  },
  engine: {
    position: 'absolute',
    right: 0,
  },
  body: {
    backgroundColor: '#ffffff',
  },
  sectionContainer: {
    marginTop: 32,
    paddingHorizontal: 24,
  },
  sectionTitle: {
    fontSize: 24,
    fontWeight: '600',
    color: '#000000',
  },
  sectionDescription: {
    marginTop: 8,
    fontSize: 18,
    fontWeight: '400',
    color: '#000000',
  },
  highlight: {
    fontWeight: '700',
  },
  footer: {
    color: '#000000',
    fontSize: 12,
    fontWeight: '600',
    padding: 4,
    paddingRight: 12,
    textAlign: 'right',
  },
});
