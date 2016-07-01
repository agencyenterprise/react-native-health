'use strict'

const PERMISSIONS = {
	READ: {
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
	},
	WRITE: {
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
		DietaryEnergy: 'DietaryEnergy',
	}
};


const UNITS = {
	gram: 'gram',
	pound: 'pound',
	meter: 'meter',
	inch: 'inch',
	foot: 'foot',
	second: 'second',
	minute: 'minute',
	hour: 'hour',
	day: 'day',
	joule: 'joule',
	calorie: 'calorie',
	count: 'count',
	percent: 'percent'
};



const CONSTANTS = {
	Permissions: PERMISSIONS,
	Units: UNITS,
};

export default CONSTANTS;
export const Constants = CONSTANTS;
