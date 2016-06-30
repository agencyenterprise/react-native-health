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


class Add extends Component {

    constructor(props) {
        super(props);
        this.state = {};
    }

    componentDidMount() {

    }

    componentWillUnmount() {

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
                <Text>Add Steps</Text>
            </View>
        );
    }
}

reactMixin(Add.prototype, TimerMixin);

var NavigationBarRouteMapper = {
    LeftButton(route, navigator, index, nextState) {
        return (
            <TouchableOpacity style={styles.navbarTitleTouchable} onPress={() => {navigator.parentNavigator.pop()}}>
                <Text style={styles.navbarTitle}>
                    Back
                </Text>
            </TouchableOpacity>
        );
    },
    RightButton(route, navigator, index, nextState) {
        return null;
    },
    Title(route, navigator, index, nextState) {
        return (
            <TouchableOpacity style={styles.navbarTitleTouchable}>
                <Text style={styles.navbarTitle}>
                    Add Steps
                </Text>
            </TouchableOpacity>
        );
    }
};


module.exports = Add;
export default Add;