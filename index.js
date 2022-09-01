import { Activities, Observers, Permissions, Units } from './src/constants';

const { AppleHealthKit } = require('react-native').NativeModules;

const HealthKit = Object.assign({}, AppleHealthKit, {
  Constants: {
    Activities,
    Observers,
    Permissions,
    Units,
  },
});

export const BloodGlucoseMealTime = {
  Preprandial: 1,
  Postprandial: 2,
};

export const SexualActivityProtectionUsed = {
  Protected: 1,
  Unprotected: 0,
};

export const ClinicalRecordType = {
  AllergyRecord: 'AllergyRecord',
  ConditionRecord: 'ConditionRecord',
  CoverageRecord: 'CoverageRecord',
  ImmunizationRecord: 'ImmunizationRecord',
  LabResultRecord: 'LabResultRecord',
  MedicationRecord: 'MedicationRecord',
  ProcedureRecord: 'ProcedureRecord',
  VitalSignRecord: 'VitalSignRecord'
};

export const ElectrocardiogramClassification = {
  NotSet: 'NotSet',
  SinusRhythm: 'SinusRhythm',
  AtrialFibrillation: 'AtrialFibrillation',
  InconclusiveLowHeartRate: 'InconclusiveLowHeartRate',
  InconclusiveHighHeartRate: 'InconclusiveHighHeartRate',
  InconclusivePoorReading: 'InconclusivePoorReading',
  InconclusiveOther: 'InconclusiveOther',
  Unrecognized: 'Unrecognized',
};

export const HealthStatusCode = {
  NotDetermined: 0,
  SharingDenied: 1,
  SharingAuthorized: 2,
}

export const HealthActivity = Activities;
export const HealthObserver = Observers;
export const HealthPermission = Permissions;
export const HealthUnit = Units;

export default HealthKit;
