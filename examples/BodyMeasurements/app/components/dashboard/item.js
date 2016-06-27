/**
 * Created by greg on 2016-06-27.
 */

import React, { Component } from 'react';
import {
    AppRegistry,
    StyleSheet,
    Navigator,
    TouchableOpacity,
    TouchableHighlight,
    ScrollView,
    Image,
    Text,
    View
} from 'react-native';
import styles from '../../styles/styles';

const ICONS = {
    "scale": require("../../assets/images/scale.png"),
    "ruler": require("../../assets/images/ruler.png"),
    "bmi": require("../../assets/images/bmi.png"),
    "bodyfat": require("../../assets/images/bodyfat.png"),
    "musclemass": require("../../assets/images/muscle-mass.png"),
    "arrowright": require('../../assets/images/arrow-right.png'),
    "heartbeat": require('../../assets/images/heartbeat.png')
};


class DashboardItem extends Component {

    constructor(props) {
        super(props);
        this.state = this._getStateObject(this.props);
    }

    componentWillReceiveProps(newProps) {
        this.setState(this._getStateObject(newProps));
    }

    _getStateObject(props) {
        let label = props.label ? props.label : 'Label';
        let value = props.value ? props.value : 'Value';
        let iconSource = (props.icon && ICONS.hasOwnProperty(props.icon)) ? ICONS[props.icon] : ICONS.heartbeat;
        return {label,value,iconSource};
    }

    render() {
        return (
            <TouchableHighlight onPress={this.props.onPress} style={ styles.dashboardListItemHighlight } underlayColor="#0088cc">
                <View style={ styles.dashboardListItemView }>
                    <View style={ styles.dashboardListItem }>
                        <Image source={this.state.iconSource}
                               style={styles.dashboardListItemIcon}/>

                        <Text style={styles.dashboardListItemLabel}>
                            {this.state.label}
                        </Text>

                        <Text style={styles.dashboardListItemValue}>
                            {this.state.value}
                        </Text>

                        <Image source={ICONS.arrowright}
                               style={styles.dashboardListItemIcon}/>
                    </View>
                </View>
            </TouchableHighlight>
        )
    }
}

DashboardItem.propTypes = {
    icon: React.PropTypes.string,
    label: React.PropTypes.string,
    value: React.PropTypes.string,
    onPress: React.PropTypes.func
};

DashboardItem.defaultProps = {
    onPress: function(){
        console.log('default onPress()');
    }
};

module.exports = DashboardItem;
export default DashboardItem;
