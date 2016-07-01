/**
 * Created by greg on 2016-06-30.
 */

import React, { Component } from 'react';
import {
    Navigator,
    TouchableOpacity,
    TouchableHighlight,
    ScrollView,
    ListView,
    RecyclerViewBackedScrollView,
    Text,
    View
} from 'react-native';
import _ from 'lodash';
import moment from 'moment';

//import TimerMixin from 'react-timer-mixin';
//var reactMixin = require('react-mixin');
import styles from '../../styles/styles';


class History extends Component {

    constructor(props) {
        super(props);
        let ds = new ListView.DataSource({rowHasChanged: (r1, r2) => r1 !== r2});
        if(_.isArray(this.props.data)){
            ds = ds.cloneWithRows(this.props.data);
        }
        this.state = {
            dataSource: ds,
        };
    }

    componentDidMount() {}

    componentWillUnmount() {}


    componentWillReceiveProps(newProps) {
        if(newProps && newProps.data && _.isArray(newProps.data)){
            this.setState({
                dataSource: this.state.dataSource.cloneWithRows(newProps.data),
            });
        }
    }


    render() {
        return (
            <ListView
                dataSource={this.state.dataSource}
                enableEmptySections={true}
                renderRow={this._renderRow}
                renderScrollComponent={props => <RecyclerViewBackedScrollView {...props} />}
            />
        );
    }

    _renderRow(rowData: Object, sectionID: number, rowID: number, highlightRow: (sectionID: number, rowID: number) => void) {

        let m = moment(rowData.startDate);
        let formattedDate = m.format('MMM Do YYYY');

        return (
            <TouchableHighlight onPress={() => {
              //this._pressRow(rowID);
              highlightRow(sectionID, rowID);
            }}>
                <View>
                    <View style={styles.listViewRow}>
                        <View style={styles.col_1_3}>
                            <Text style={{flex:1, fontWeight: '600'}}>
                                {rowData.value}
                            </Text>
                        </View>
                        <View style={styles.col_2_3}>
                            <Text style={{flex:1, textAlign: 'right',}}>
                                {formattedDate}
                            </Text>
                        </View>
                    </View>
                </View>
            </TouchableHighlight>
        );
    }

}

//reactMixin(History.prototype, TimerMixin);


module.exports = History;
export default History;
