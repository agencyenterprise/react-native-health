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
        this._fetchHealthKitUserBiologicalSex = this._fetchHealthKitUserBiologicalSex.bind(this);
        this._fetchHealthKitUserDateOfBirth = this._fetchHealthKitUserDateOfBirth.bind(this);
        this._fetchHealthKitUserWeight = this._fetchHealthKitUserWeight.bind(this);
        this._fetchHealthKitUserWeightSamples = this._fetchHealthKitUserWeightSamples.bind(this);
        this._fetchHealthKitUserHeight = this._fetchHealthKitUserHeight.bind(this);
        this._fetchHealthKitUserHeightSamples = this._fetchHealthKitUserHeightSamples.bind(this);
        this._fetchHealthKitUserBmi = this._fetchHealthKitUserBmi.bind(this);
        this._fetchHealthKitStepCountToday = this._fetchHealthKitStepCountToday.bind(this);
        this._fetchHealthKitStepCountForDay = this._fetchHealthKitStepCountForDay.bind(this);
        this._fetchDailyStepCounts = this._fetchDailyStepCounts.bind(this);
        this._fetchHealthKitBodyFatPercentage = this._fetchHealthKitBodyFatPercentage.bind(this);
        this._fetchHealthKitLeanBodyMass = this._fetchHealthKitLeanBodyMass.bind(this);
        this._saveHeight = this._saveHeight.bind(this);
        this._saveBmi = this._saveBmi.bind(this);

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
                read: ["Height", "Weight", "Steps", "DateOfBirth", "BodyMassIndex", "LeanBodyMass", "BodyFatPercentage", "BiologicalSex"],
                write: ["Weight", "Height", "BodyMassIndex"]
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

            self._fetchHealthKitStepCountForDay();
            self._fetchDailyStepCounts();

            self._fetchHealthKitUserWeightSamples();
            self._fetchHealthKitUserHeightSamples();

            self._fetchHealthKitUserBiologicalSex();
            self._fetchHealthKitUserDateOfBirth();

            //setTimeout(() => {self._saveBmi(27)}, 1000);
            //setTimeout(() => {self._onactn_addWeight({
            //    weight: 215,
            //})}, 1000);

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
            AppleHealthKit.saveWeight({value:weightVal}, (err, res) => {
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


    _fetchHealthKitUserBiologicalSex() {
        let self = this;
        AppleHealthKit.getBiologicalSex(null, (err, sex) => {
            if(this._handleHealthKitError(err, 'getBiologicalSex')){
                return;
            }
            console.log('BiologicalSex: ', sex);
        });
    }

    _fetchHealthKitUserDateOfBirth() {
        let self = this;
        AppleHealthKit.getDateOfBirth(null, (err, dob) => {
            if(this._handleHealthKitError(err, 'getDateOfBirth')){
                return;
            }
            console.log('DateOfBirth: ', dob);
        });
    }



    _saveHeight(height_inches) {
        let self = this;
        let options = {
            value: height_inches
        };

        AppleHealthKit.saveHeight(options, (err, res) => {
            if(this._handleHealthKitError(err, 'saveHeight')){
                return;
            }
            console.log('Height Saved Successfully...');
            DATA.height = height_inches;
            self.trigger({
                name: 'change:height',
                target: null,
                data: DATA.height
            });
        });
    }


    _fetchHealthKitUserWeight() {
        let self = this;
        let options = {
            unit: "pound"
        };
        AppleHealthKit.getLatestWeight(options, (err, res) => {
            if(this._handleHealthKitError(err, 'getLatestWeight')){
                return;
            }
            let weight = res.value;
            weight = _.round(weight,1);

            DATA.weight = weight;
            self.trigger({
                name: 'change:weight',
                target: null,
                data: weight
            });
        });
    }



    _fetchHealthKitUserWeightSamples() {
        let self = this;
        let d = new Date(2016,4,27);
        let options = {
            unit: "gram",
            startDate: d.toISOString(),
            ascending: false,
            limit:3,
        };
        AppleHealthKit.getWeightSamples(options, (err, samples) => {
            if(this._handleHealthKitError(err, 'getWeightSamples')){
                return;
            }
            console.log('weight samples: ', samples);
        });
    }


    _fetchHealthKitUserHeight() {
        let self = this;
        let options = {
            unit: "inch"
        };
        AppleHealthKit.getLatestHeight(options, (err, res) => {
            if(this._handleHealthKitError(err, 'getLatestHeight')){
                return;
            }
            let height = res.value;
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


    _fetchHealthKitUserHeightSamples() {
        let self = this;
        let d = new Date(2016,1,1);
        let options = {
            unit: "inch",
            startDate: d.toISOString(),
            //ascending: false,
            //limit:2,
        };
        AppleHealthKit.getHeightSamples(options, (err, samples) => {
            if(this._handleHealthKitError(err, 'getHeightSamples')){
                return;
            }
            console.log('height samples: ', samples);
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

    _saveBmi(bmi_value) {
        let self = this;
        let options = {
            value: bmi_value
        };

        AppleHealthKit.saveBmi(options, (err, res) => {
            if(this._handleHealthKitError(err, 'saveBmi')){
                return;
            }
            console.log('BMI Saved Successfully...');
            DATA.bmi = bmi_value;
            self.trigger({
                name: 'change:bmi',
                target: null,
                data: DATA.bmi
            });
        });
    }


    _fetchHealthKitBodyFatPercentage() {
        let self = this;
        AppleHealthKit.getLatestBodyFatPercentage({blah:true}, (err, res) => {
            if(this._handleHealthKitError(err, 'getLatestBodyFatPercentage')){
                return;
            }
            let fatPercentage = res.value;

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
        AppleHealthKit.getLatestLeanBodyMass({blah:true}, (err, res) => {
            if(this._handleHealthKitError(err, 'getLatestLeanBodyMass')){
                return;
            }
            let leanMass = res.value;
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
        AppleHealthKit.getStepCount({options:"true"}, (err, steps) => {
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


    _fetchHealthKitStepCountForDay() {
        let self = this;
        let d = new Date(2016,5,27);
        let options = {
            date: d.toISOString()
        };
        AppleHealthKit.getStepCount(options, (err, steps) => {
            if(this._handleHealthKitError(err, 'getStepCountForDay')){
                return;
            }
            console.log("STEPS FOR DAY : ", steps);
            //steps = _.round(steps,0);
            //
            //DATA.steps = steps;
            //self.trigger({
            //    name: 'change:steps',
            //    target: null,
            //    data: steps
            //});
        });
    }


    _fetchDailyStepCounts() {
        let self = this;
        let d = new Date(2016,4,1);
        let options = {
            startDate: d.toISOString()
        };
        AppleHealthKit.getDailyStepCountSamples(options, (err, res) => {
            if(this._handleHealthKitError(err, 'getMultiDayStepCounts')){
                return;
            }
            console.log("DAILY STEP COUNTS: ", res);
        });
    }




    GetHeightValue() {
        return DATA.height;
    }

    GetHeightFormatted() {
        let feet = _.floor((DATA.height / 12));
        let inches = _.floor((DATA.height % 12));
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