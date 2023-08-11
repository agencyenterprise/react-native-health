import { useState, useEffect } from 'react';
import {
  SafeAreaView,
  StyleSheet,
  ScrollView,
  View,
  Text,
  StatusBar,
  Button,
} from 'react-native';

import RNHealthKitWrapper, { HealthType } from 'react-native-health';

RNHealthKitWrapper.initHealthKit(
  Object.values(HealthType),
  [HealthType.HeartRate],
);

async function runQuery() {
  const result = await RNHealthKitWrapper.getQuantitySamples(
    HealthType.HeartRate,
    {
      "startDate": new Date(2023, 7, 1).toISOString(),
      "endDate": new Date().toISOString(),
      "unit": 'count/min',
    }
  )
  console.log(result)
}

async function runAggregationQuery() {
  const result = await RNHealthKitWrapper.getQuantitySamplesAggregation(
    HealthType.ActiveEnergyBurned,
    {
      "startDate": new Date(2023, 7, 1).toISOString(),
      "endDate": new Date().toISOString(),
      "unit": 'kcal',
      "option": 'cumulativeSum'
    }
  )
  console.log(result)
}

export default function App() {
  const [authStatus, setAuthStatus] = useState<any>({});

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
                title="Run Query"
                onPress={() => {
                  runQuery();
                }}
              />
              <Button
                title="Run Aggregation Query"
                onPress={() => {
                  runAggregationQuery();
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