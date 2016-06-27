/**
 * Created by greg on 2016-06-27.
 */

import React, { Component } from 'react';
import {
    Navigator,
    TouchableOpacity,
    Text,
    View
} from 'react-native';

import styles from '../../styles/styles';
import BodyStore from '../../stores/body';


class Weight extends Component {

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
        };
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
                <View style={styles.row_1_3}>
                    <Text style={styles.largeCenteredText}>
                        {this.state.weightFormatted}
                    </Text>
                </View>

                <View style={[styles.row_2_3, styles.borderTopLightGrey]}>
                    <Text></Text>
                </View>
            </View>
        );
    }
}

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
                    Weight
                </Text>
            </TouchableOpacity>
        );
    }
};


module.exports = Weight;
export default Weight;
