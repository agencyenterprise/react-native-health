'use strict'

const PERMISSIONS = {
	DateOfBirth: 'DateOfBirth',
	BiologicalSex: 'BiologicalSex',
	Height: 'Height',
	Weight: 'Weight',
	BodyMass: 'BodyMass',
	BodyFatPercentage: 'BodyFatPercentage',
	BodyMassIndex: 'BodyMassIndex',
	LeanBodyMass: 'LeanBodyMass',
	Steps: 'Steps',
	StepCount: 'StepCount',
	DistanceWalkingRunning: 'DistanceWalkingRunning',
	DistanceCycling: 'DistanceCycling',
	BasalEnergyBurned: 'BasalEnergyBurned',
	ActiveEnergyBurned: 'ActiveEnergyBurned',
	FlightsClimbed: 'FlightsClimbed',
	NikeFuel: 'NikeFuel',
	AppleExerciseTime: 'AppleExerciseTime',
	DietaryEnergy: 'DietaryEnergy',
	HeartRate: 'HeartRate',
  BodyTemperature: 'BodyTemperature',
  BloodPressureSystolic: 'BloodPressureSystolic',
  BloodPressureDiastolic: 'BloodPressureDiastolic',
  RespiratoryRate: 'RespiratoryRate',
  BloodGlucose: 'BloodGlucose',
	SleepAnalysis: 'SleepAnalysis',
  MindfulSession: 'MindfulSession',
};


const UNITS = {
	gram: 'gram',
	pound: 'pound',
	meter: 'meter',
	mile: 'mile',
	inch: 'inch',
	foot: 'foot',
	second: 'second',
	minute: 'minute',
	hour: 'hour',
	day: 'day',
	joule: 'joule',
	calorie: 'calorie',
	count: 'count',
	percent: 'percent',
	bpm: 'bpm',
	fahrenheit: 'fahrenheit',
	celsius: 'celsius',
	mmhg: 'mmhg',
	mmolPerL: 'mmolPerL',
	mgPerdL: 'mgPerdL',
};



const CONSTANTS = {
	Permissions: PERMISSIONS,
	Units: UNITS,
};

export default CONSTANTS;
export const Constants = CONSTANTS;
