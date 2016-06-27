/**
 * Created by greg on 2016-06-27.
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
import BodyStore from '../../stores/body';
import DashboardItem from './item';


class Dashboard extends Component {

    constructor(props) {
        super(props);
        this.state = this._getStateObject();
    }

    componentDidMount() {
        this.unsub = BodyStore.listen(this._onBodyStoreEvent.bind(this));
    }

    componentWillUnmount() {
        this.unsub();
    }

    _onBodyStoreEvent(evt) {
        this.setState(this._getStateObject())
    }

    _getStateObject() {
        return {
            weightFormatted: BodyStore.GetWeightFormatted(),
            heightFormatted: BodyStore.GetHeightFormatted(),
            bmiFormatted: BodyStore.GetBMIFormatted(),
            bodyFatFormatted: BodyStore.GetBodyFatPercentageFormatted(),
            leanBodyMassFormatted: BodyStore.GetLeanBodyMassFormatted(),
        };
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
            <View style={styles.sceneContainerNavbar}>
                <ScrollView automaticallyAdjustContentInsets={false} style={{flex:1,}}>

                    <DashboardItem icon="scale"
                                   label="Weight"
                                   value={this.state.weightFormatted}
                                   onPress={this._onPressItem.bind(this, 'Weight')} />
                    <DashboardItem icon="ruler"
                                   label="Height"
                                   value={this.state.heightFormatted}
                                   onPress={this._onPressItem.bind(this, 'Height')} />
                    <DashboardItem icon="bmi"
                                   label="BMI"
                                   value={this.state.bmiFormatted}
                                   onPress={this._onPressItem.bind(this, 'BodyMassIndex')} />
                    <DashboardItem icon="bodyfat"
                                   label="Body Fat Percentage"
                                   value={this.state.bodyFatFormatted}
                                   onPress={this._onPressItem.bind(this, 'BodyFatPercentage')} />
                    <DashboardItem icon="musclemass"
                                   label="Lean Body Mass"
                                   value={this.state.leanBodyMassFormatted}
                                   onPress={this._onPressItem.bind(this, 'LeanBodyMass')} />

                </ScrollView>
            </View>
        );
    }
}

reactMixin(Dashboard.prototype, TimerMixin);

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
                    HealthKit Body Measurements
                </Text>
            </TouchableOpacity>
        );
    }
};


module.exports = Dashboard;
export default Dashboard;
