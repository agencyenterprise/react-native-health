/**
 * Created by greg on 2016-06-30.
 */

import React, { Component } from 'react';
import {
    Navigator,
    TouchableOpacity,
    ScrollView,
    Text,
    View
} from 'react-native';

import TimerMixin from 'react-timer-mixin';
var reactMixin = require('react-mixin');
import styles from '../../styles/styles';

//var AppleHealthKit = require('react-native-apple-healthkit');
import AppleHealthKit from 'react-native-apple-healthkit';

import History from './history';

const WPERMS = AppleHealthKit.Constants.Permissions.WRITE;
const RPERMS = AppleHealthKit.Constants.Permissions.READ;

const HKOPTIONS = {
    permissions: {
        read:  [RPERMS.StepCount, RPERMS.DistanceWalkingRunning],
        write: [WPERMS.StepCount],
    }
};


class Home extends Component {

    constructor(props) {
        super(props);
        this.state = {
            stepsToday: 0,
            stepHistory: [],
        };
    }

    componentDidMount() {

        console.log('CONSTANTS: ', AppleHealthKit.Constants);
        //console.log('balls: ', ahk);

        AppleHealthKit.isAvailable((err,available) => {
            if(available){
                AppleHealthKit.initHealthKit(HKOPTIONS, (err, res) => {
                    if(this._handleHKError(err, 'initHealthKit')){
                        return;
                    }
                    this._fetchStepsToday();
                    this._fetchStepsHistory();
                });
            }
        });
    }

    componentWillUnmount() {

    }

    _fetchStepsToday() {
        AppleHealthKit.getStepCountForToday(null, (err, steps) => {
            if(this._handleHKError(err, 'getStepCountForToday')){
                return;
            }
            this.setState({stepsToday: steps});
        });
    }

    _fetchStepsHistory() {
        let options = {
            startDate: (new Date(2016,4,1)).toISOString(),
        };
        AppleHealthKit.getDailyStepSamples(options, (err, res) => {
            if(this._handleHKError(err, 'getDailyStepSamples')){
                return;
            }
            this.setState({stepHistory: res});
        });

        AppleHealthKit.getDistanceWalkingRunning(null, (err, res) => {
            if(this._handleHKError(err, 'getDistanceWalkingRunning')){
                return;
            }
            console.log('getDistanceWalkingRunning -res-> ', res);
        });

    }

    _onPressItem(key) {
        console.log('_onPressItem() ==> ', key);
        let self = this;
        this.requestAnimationFrame(() => {
            this.props.navigator.push({
                name: key
            });
        })
    }

    render() {
        return (
            <Navigator
                renderScene={this.renderScene.bind(this)}
                navigator={this.props.navigator}
                navigationBar={
                    <Navigator.NavigationBar style={styles.navigationBar}
                                             routeMapper={NavigationBarRouteMapper} />
                }/>
        );
    }

    renderScene(route, navigator) {
        return (
            <View style={styles.sceneContainerWithNavbar}>

                <View style={styles.stepsContainer}>
                    <Text>
                        STEPS: {this.state.stepsToday}
                    </Text>
                </View>

                <View style={styles.historyContainer}>
                    <History data={this.state.stepHistory} />
                </View>

            </View>
        );
    }

    _handleHKError(err, method) : boolean {
        if(err){
            let errStr = 'HealthKit_ERROR['+method+'] : ';
            if(typeof err === 'string'){
                errStr += err;
            } else if (typeof err === 'object' && err.message){
                errStr += err.message;
            }
            console.log(errStr);
            return true;
        }
        return false;
    }

}

reactMixin(Home.prototype, TimerMixin);

var NavigationBarRouteMapper = {
    LeftButton(route, navigator, index, nextState) {
        return null;
    },
    RightButton(route, navigator, index, nextState) {
        return null;
    },
    Title(route, navigator, index, nextState) {
        return (
            <TouchableOpacity style={styles.navbarTitleTouchable}>
                <Text style={styles.navbarTitle}>
                    HealthKit Steps
                </Text>
            </TouchableOpacity>
        );
    }
};


module.exports = Home;
export default Home;
