import React, { useContext, useReducer, useEffect, useState } from 'react';
// import DeviceInfo from 'react-native-device-info';
import { Activities, Observers, Permissions, Units } from './src/constants'
import { View, Image, Animated, Easing, Platform, Text, PermissionsAndroid, NativeAppEventEmitter, DeviceEventEmitter, EventEmitter, NativeEventEmitter } from 'react-native';
import { Fragment } from 'react';
const { AppleHealthKit } = require('react-native').NativeModules

export const HealthKitContext = React.createContext('HealthKitContext');

const HealthKitReducer = () => {
    const oReducer = useReducer(healthKitAction, {
        sources: null, healthData: null
    });
    return oReducer;
}

function healthKitAction(state, action) {
    let newState = { ...state }
    switch (action.type) {
        case 'SET_LOCAL_DEVICES':
            newState.localDevices = action.data;
            return newState;
        case 'SET_SYNCED_DEVICES':
            newState.syncedDevices = action.data;
            return newState;
        default: return state;
    };
}


export const useHealthKit = (permissions) => {
    const healthKitContext = useContext(HealthKitContext);
    const [state, dispatch] = healthKitContext;

    useEffect(() => {
        if (Platform.OS === 'ios')
            initHealthKit()
        return () => { }
    }, [permissions])

    const initHealthKit = () => {
        const defaultPermissions = {
            permissions: {
                read: [Permissions.HeartRate,
                Permissions.BloodPressureDiastolic,
                Permissions.BloodPressureSystolic,
                    // AppleHealthKit.Constants.Permissions.Steps
                ],
                // write: [AppleHealthKit.Constants.Permissions.Steps],
            },
        }
        if (permissions)
            defaultPermissions = permissions

        AppleHealthKit.initHealthKit(defaultPermissions, (error) => {
            /* Called after we receive a response from the system */

            if (error) {
                onPermissionDenied();
                return;
            }

            /* Can now read or write to HealthKit */


            /* Register native listener that will be triggered when successfuly enabled */
            // NativeAppEventEmitter.addListener('healthKit:HeartRate:setup:success', collectHeartInfo)

            /* Register native listener that will be triggered on each update */
            NativeAppEventEmitter.addListener('healthKit:HeartRate:new', getHeartRate);
            // DeviceEventEmitter.addListener('healthKit:HeartRate:new', getHeartRate);
            // NativeEventEmitter.addListener('healthKit:HeartRate:new', getHeartRate);
            // .addListener('healthKit:HeartRate:new', getHeartRate)
            // const eventEmitter = new EventEmitter()
            // eventEmitter.addListener('healthKit:HeartRate:new', getHeartRate);
            collectHeartInfo();
        })
    }

    const onPermissionDenied = () => {

        console.log('[ERROR] Cannot grant permissions!', error)
        //Show error message
    }

    const collectHeartInfo = () => {
        AppleHealthKit.getHealthDataSources(null, (err, results) => {
            if (err) {
                console.log("ERROR WHEN GET ALL DATA: ", err)
                return
            }
            console.log("===========ALL HEALTH SOURCE: ", results)
            dispatch({ type: 'SET_LOCAL_DEVICES', data: results })
        })
    }

    const getHeartRate = (data) => {

        console.log("DETECT NEW HEART RATE..............", data)

        const options = {
            startDate: new Date(2022, 0, 0).toISOString(),
            limit: 100,
            ascending: false,
            unit: 'bpm'
            // includeManuallyAdded: false
        }

        AppleHealthKit.getHeartRateSamples(
            options,
            (callbackError, results) => {
                /* Samples are now collected from HealthKit */
                // setHeartRate(JSON.stringify(results[10]))
                let listSample = []
                results.forEach(element => {
                    if ((element.metadata && element.metadata.hasOwnProperty("HKDeviceName")) || element.value == 90)
                        listSample.push(element)
                });
                console.log("HEALTH SAMPLE: ", listSample)
                // setHeartRate(JSON.stringify(listSample))
            },
        )
    }

    const getBloodPressure = () => {
        let optionsPressure = {
            unit: 'mmhg', // optional; default 'mmhg'
            startDate: new Date(2021, 0, 0).toISOString(), // required
            endDate: new Date().toISOString(), // optional; default now
            ascending: false, // optional; default false
            limit: 10, // optional; default no limit,
            // type: HealthObserver.HeartRate,
            // includeManuallyAdded:true
        }
        AppleHealthKit.getBloodPressureSamples(
            optionsPressure,
            (err, pressureResults) => {
                if (err) {
                    console.log("ERROR When get BloodPressure: ", err)
                    return;
                }
                // setPressure(pressureResults)
                console.log("Blood Pressure: ", pressureResults)
            },
        )
    }

    return {
        localDevices: state.localDevices,
        syncedDevices: state.syncedDevices,
    }
}


export function HealthKitProvider(props) {
    const healthKitReducer = HealthKitReducer();

    return (
        <HealthKitContext.Provider value={healthKitReducer}>
            <HealthKitDataSource {...props}>
                {props.children}
            </HealthKitDataSource>
        </HealthKitContext.Provider>
    )
}

export function HealthKitDataSource({onGetSourcesDone, children}) {
    const { localDevices, syncedDevices } = useHealthKit();

    useEffect(()=>{
        if(localDevices && Array.isArray(localDevices)){
            onGetSourcesDone && onGetSourcesDone(localDevices)
            // setDevices(localDevices)
        }
    }, [localDevices])

    return <>
        {children}
    </>
}