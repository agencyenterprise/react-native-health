/**
 * Created by greg on 2016-06-30.
 */


import {
    Platform,
    StyleSheet
} from 'react-native';



const styles = StyleSheet.create({

    sceneContainerWithNavbar: {
        flex: 1,
        flexDirection: 'column',
        //justifyContent: 'flex-start',
        //alignItems: 'flex-start',
        marginTop: (Platform.OS === 'ios') ? 64 : 54,
        backgroundColor: '#FFFFFF'
    },

    navigationBar: {
        borderBottomWidth: 1,
        borderBottomColor: '#cccccc',
        backgroundColor: '#f5f5f5'
    },

    navbarTitleTouchable: {
        flex: 1,
        justifyContent: 'center'
    },
    navbarTitle: {
        color: '#FD2D55',
        margin: 10,
        fontSize: 18
    },
    navbarPlusButton: {
        fontSize:33,
        marginRight:13,
        color: '#FD2D55',
        top: -3
    },


    stepsContainer: {
        height:100,
        backgroundColor: '#FAFAFA',
        //backgroundColor: '#FF8000',
    },

    stepsIcon: {
        width: 60,
        height: 60,
        marginLeft: 20,
        marginTop: 20,
        //marginTop: 50,
        //backgroundColor: 'transparent',
        alignSelf: 'flex-start',
    },

    stepsLabel: {
        fontSize:12,
        color: '#FD2D55',
        position:'absolute',
        left: 105,
        top:11,
    },

    stepsValue: {
        fontSize:50,
        color: '#47a292',
        position:'absolute',
        left: 105,
        top:25,
    },


    historyContainer: {
        flex: 1,
        //backgroundColor: '#0088cc',
    },



    titleRow: {
        height:40,
        alignItems: 'center',
        //backgroundColor: '#FF00FF'
        borderTopColor: '#DDDDDD',
        borderBottomColor: '#DDDDDD',
        borderTopWidth: 1,
        borderBottomWidth: 1,
        paddingTop:10,
        backgroundColor: '#EFEFEF',
    },


    listViewRow: {
        flexDirection: 'row',
        justifyContent: 'center',
        padding: 10,
        backgroundColor: '#F6F6F6',
        borderBottomColor: '#DADADA',
        borderBottomWidth: 1,
    },






    row_1_3: {
        flex: 0.33,
        flexDirection:'column',
        padding:10,
        //backgroundColor: '#FF8000'
    },

    row_2_3: {
        flex: 0.66,
        flexDirection:'column',
        padding:10,
        //backgroundColor: '#0088cc'
    },


    col_1_3: {
        flex: 0.33,
        flexDirection:'row',
        padding:10,
        //backgroundColor: '#FF8000'
    },

    col_2_3: {
        flex: 0.66,
        flexDirection:'row',
        padding:10,
        //backgroundColor: '#0088cc'
    },


    borderTopLightGrey: {
        borderTopColor: '#CCCCCC',
        borderTopWidth: 1,
    },

    largeCenteredText: {
        textAlign: 'center',
        flexDirection:'row',
        fontSize:34,
        marginTop:60,
    },

    dashboardListItemLabel: {
        fontSize:12,
        color: '#FD2D55',
        position:'absolute',
        left: 70,
        top:0,
    },

    dashboardListItemValue: {
        fontSize:22,
        color: '#47a292',
        position:'absolute',
        left: 70,
        top:15,
    },

    sceneContainerFull: {
        flex: 1,
        flexDirection: 'column',
        //justifyContent: 'flex-start',
        //alignItems: 'flex-start',
        marginTop: 0,
        backgroundColor: '#FFFFFF'
    },


    dashboardToday: {
        height: 30,
        alignItems: 'stretch',
        justifyContent: 'center',
        alignItems: 'center',
        backgroundColor: 'rgba(162, 162, 162, 0.2)',
    },
    dashboardTodayText: {

        color: '#a2a2a2',
    },

    dashboardListItemHighlight: {
        flexDirection: 'row',
        alignSelf: 'stretch',
        justifyContent: 'center',
        //flex:1,
        //alignSelf: 'stretch',
        //overflow: 'hidden',
    },

    dashboardListItemView: {
        flex: 1,
        //backgroundColor: '#FDFDFD',
        backgroundColor: '#FDFDFD',
        //paddingTop:74,
        //flexDirection: 'row',
        flexDirection: 'column',
        alignSelf: 'stretch',
        justifyContent: 'flex-start',
        alignItems: 'flex-start',
        paddingTop:15,
        paddingBottom: 15,

        //flexWrap: 'wrap',

        borderBottomColor: '#AAAAAA',
        borderBottomWidth: 1,
    },

    dashboardListItemViewTransparent: {
        flex: 1,
        //backgroundColor: '#FDFDFD',
        backgroundColor: 'transparent',
        //paddingTop:74,
        //flexDirection: 'row',
        flexDirection: 'column',
        alignSelf: 'stretch',
        justifyContent: 'flex-start',
        alignItems: 'flex-start',
        paddingTop:15,
        paddingBottom: 15,

        //flexWrap: 'wrap',

        borderBottomColor: '#AAAAAA',
        borderBottomWidth: 1,
    },

    dashboardListItem: {
        flexDirection: 'row',
        alignSelf: 'stretch',
        justifyContent: 'space-between',
        flex:1,
        backgroundColor: 'transparent',
    },


    dashboardListItemIcon: {
        width: 40,
        height: 40,
        marginLeft: 10,
        opacity:0.7,
        //marginTop: 50,
        //backgroundColor: 'transparent',
        alignSelf: 'flex-start',
    },

    dashboardListItemText: {
        flex: 1,
        flexDirection: 'column',
        alignSelf: 'flex-start',
        marginLeft: 20,
        fontSize: 29,
        color: '#47a292',
        //color: '#98CA3F',
        //color: '#644496',
        flexWrap: 'wrap',
        backgroundColor:'transparent',
    },

});

module.exports = styles;
export default styles;