/**
 * Created by greg on 2016-06-27.
 */


var airflux = require( 'airflux' );
var _ = require('lodash');
var moment = require('moment');
var Immutable = require('immutable');
//var actions = require('../actions/actions');

var AppleHealthKit = require('react-native-apple-healthkit');

var DATA = {
    weight: 0,
    height: 0,
    bmi: 0,
    bodyFatPercentage: 0,
    leanBodyMass: 0,
    steps: 0,
};

/**
 * @namespace Stores
 */

/**
 * @class WeightStore
 * @classdesc Airflux store to handle data, actions, and events relating to the WeightStore
 * @memberof Stores
 */
class BodyStore extends airflux.Store {

    /**
     * Initialize the WeightStore, optionally with 'props' object
     * @constructs Stores.TestingEventService
     * @param {object} props - an optional properties object to initialize the store with
     *
     */
    constructor(props) {
        //console.log("WeightStore props --> ", props);
        super(props);
        let self = this;

        //this.listenTo(actions.addWeight, this._onactn_addWeight)

        this._initHealthKit = this._initHealthKit.bind(this);
        this._fetchHealthKitUserWeight = this._fetchHealthKitUserWeight.bind(this);
        this._fetchHealthKitUserHeight = this._fetchHealthKitUserHeight.bind(this);
        this._fetchHealthKitUserBmi = this._fetchHealthKitUserBmi.bind(this);
        this._fetchHealthKitStepCountToday = this._fetchHealthKitStepCountToday.bind(this);
        this._fetchHealthKitBodyFatPercentage = this._fetchHealthKitBodyFatPercentage.bind(this);
        this._fetchHealthKitLeanBodyMass = this._fetchHealthKitLeanBodyMass.bind(this);
        this.GetWeightValue = this.GetWeightValue.bind(this);
        this.GetWeightFormatted = this.GetWeightFormatted.bind(this);
        this.GetSteps = this.GetSteps.bind(this);
        this.GetHeightFormatted = this.GetHeightFormatted.bind(this);
        this.GetHeightValue = this.GetHeightValue.bind(this);
        this.GetBMIValue = this.GetBMIValue.bind(this);
        this.GetBMIFormatted = this.GetBMIFormatted.bind(this);
        this.GetBodyFatPercentageValue = this.GetBodyFatPercentageValue.bind(this);
        this.GetBodyFatPercentageFormatted = this.GetBodyFatPercentageFormatted.bind(this);
        this.GetLeanBodyMassValue = this.GetLeanBodyMassValue.bind(this);
        this.GetLeanBodyMassFormatted = this.GetLeanBodyMassFormatted.bind(this);

        AppleHealthKit.isAvailable((err,available) => {
            console.log('AppleHealthKit.isAvailable(): ', available);
            if(available){
                self._initHealthKit();
            }
        });

        //AppleHealthKit.getInfo({init:"true"}, (err,res) => {
        //    if(err) {
        //        console.log("ERROR GETTING HEALTHKIT MODULE INFO");
        //        console.log(err);
        //        return;
        //    }
        //    console.log("HEALTHKIT MODULE INFO: ", res);
        //});
    }


    _initHealthKit() {
        let self = this;

        let healthKitOptions = {
            permissions: {
                read: ["Height", "Weight", "Steps", "DateOfBirth", "BodyMassIndex", "LeanBodyMass", "BodyFatPercentage"],
                write: ["Weight"]
            }
        };

        AppleHealthKit.initHealthKit(healthKitOptions, (err, res) => {
            if(this._handleHealthKitError(err, 'initHealthKit')){
                return;
            }
            console.log("HEALTHKIT INITIALIZED!! ", res);

            self._fetchHealthKitUserWeight();
            self._fetchHealthKitUserBmi();
            self._fetchHealthKitStepCountToday();
            self._fetchHealthKitUserHeight();
            self._fetchHealthKitBodyFatPercentage();
            self._fetchHealthKitLeanBodyMass();
        });
    }


    _handleHealthKitError(err, method) : boolean {
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

    _onactn_addWeight(options) {
        console.log('_onactn_addWeight() --> ', options);
        if(options && options.weight){
            let weightVal = parseFloat(options.weight);
            let self = this;
            AppleHealthKit.saveWeight({weight:weightVal}, (err, res) => {
                if(this._handleHealthKitError(err, 'saveWeight')){
                    return;
                }
                DATA.weight = weightVal;
                self.trigger({
                    name: 'change:weight',
                    target: null,
                    data: DATA.weight
                });
            });
        }
    }


    _fetchHealthKitUserWeight() {
        let self = this;
        AppleHealthKit.getLatestWeight(null, (err, weight) => {
            if(this._handleHealthKitError(err, 'getLatestWeight')){
                return;
            }
            weight = _.round(weight,1);

            DATA.weight = weight;
            self.trigger({
                name: 'change:weight',
                target: null,
                data: weight
            });
        });
    }


    _fetchHealthKitUserHeight() {
        let self = this;
        AppleHealthKit.getLatestHeight(null, (err, height) => {
            if(this._handleHealthKitError(err, 'getLatestHeight')){
                return;
            }
            console.log("HEIGHT: ", height);

            if(typeof height === "number" && height > 0){
                DATA.height = height;
                self.trigger({
                    name: 'change:height',
                    target: null,
                    data: height
                });
            }
        });
    }


    _fetchHealthKitUserBmi() {
        let self = this;
        AppleHealthKit.getLatestBmi({blah:true}, (err, bmi) => {
            if(this._handleHealthKitError(err, 'getLatestBmi')){
                return;
            }
            console.log("LATEST BMI: ", bmi);
            if(bmi && bmi.value){
                DATA.bmi = _.round(bmi.value,1);
                self.trigger({
                    name: 'change:bmi',
                    target: null,
                    data: DATA.bmi
                });
            }
        });
    }


    _fetchHealthKitBodyFatPercentage() {
        let self = this;
        AppleHealthKit.getLatestBodyFatPercentage({blah:true}, (err, fatPercentage) => {
            if(this._handleHealthKitError(err, 'getLatestBodyFatPercentage')){
                return;
            }
            console.log("BODY FAT PERCENTAGE: ", fatPercentage);
            DATA.bodyFatPercentage = fatPercentage;
            self.trigger({
                name: 'change:body_fat_percentage',
                target: null,
                data: DATA.bodyFatPercentage
            });
        });
    }


    _fetchHealthKitLeanBodyMass() {
        let self = this;
        AppleHealthKit.getLatestLeanBodyMass({blah:true}, (err, leanMass) => {
            if(this._handleHealthKitError(err, 'getLatestLeanBodyMass')){
                return;
            }
            console.log("LEAN BODY MASS: ", leanMass);
            DATA.leanBodyMass = _.round(leanMass,0);
            self.trigger({
                name: 'change:lean_body_mass',
                target: null,
                data: DATA.leanBodyMass
            });
        });
    }



    _fetchHealthKitStepCountToday() {
        let self = this;
        AppleHealthKit.getStepCountForToday({options:"true"}, (err, steps) => {
            if(this._handleHealthKitError(err, 'getStepCountForToday')){
                return;
            }
            console.log("STEPS : ", steps);
            steps = _.round(steps,0);

            DATA.steps = steps;
            self.trigger({
                name: 'change:steps',
                target: null,
                data: steps
            });
        });
    }


    GetHeightValue() {
        return DATA.height;
    }

    GetHeightFormatted() {
        let feet = _.floor((DATA.height / 12));
        let inches = DATA.height % 12;
        let formatted = '' + feet + '\'' + inches + '"';
        return formatted;
    }

    GetWeightValue() {
        return DATA.weight;
    }

    GetWeightFormatted() {
        return DATA.weight + ' lbs';
    }

    GetBMIValue() {
        return DATA.bmi;
    }

    GetBMIFormatted() {
        return '' + DATA.bmi;
    }

    GetBodyFatPercentageValue() {
        return DATA.bodyFatPercentage;
    }

    GetBodyFatPercentageFormatted() {
        return '' + DATA.bodyFatPercentage + '%';
    }

    GetLeanBodyMassValue() {
        return DATA.leanBodyMass;
    }

    GetLeanBodyMassFormatted() {
        return '' + DATA.leanBodyMass + ' lbs';
    }


    GetSteps() {
        return DATA.steps;
    }

}


let storeInstance = new BodyStore();
export default storeInstance;
module.exports = storeInstance;