export enum WorkoutMetadataKey {
  ActivityType = "HKMetadataKeyActivityType",
  AppleFitnessPlusSession = "HKMetadataKeyAppleFitnessPlusSession",
  CoachedWorkout = "HKMetadataKeyCoachedWorkout",
  GroupFitness = "HKMetadataKeyGroupFitness",
  IndoorWorkout = "HKMetadataKeyIndoorWorkout",
  WorkoutBrandName = "HKMetadataKeyWorkoutBrandName",
  CyclingFunctionalThresholdPowerTestType = "HKMetadataKeyCyclingFunctionalThresholdPowerTestType",
  FitnessMachineDuration = "HKMetadataKeyFitnessMachineDuration",
  CrossTrainerDistance = "HKMetadataKeyCrossTrainerDistance",
  IndoorBikeDistance = "HKMetadataKeyIndoorBikeDistance",
  AverageMETs = "HKMetadataKeyAverageMETs",
  PhysicalEffortEstimationType = "HKMetadataKeyPhysicalEffortEstimationType",
  AlpineSlopeGrade = "HKMetadataKeyAlpineSlopeGrade",
  ElevationAscended = "HKMetadataKeyElevationAscended",
  ElevationDescended = "HKMetadataKeyElevationDescended",
  AverageSpeed = "HKMetadataKeyAverageSpeed",
  MaximumSpeed = "HKMetadataKeyMaximumSpeed",
  SwimmingLocationType = "HKMetadataKeySwimmingLocationType",
  SwimmingStrokeStyle = "HKMetadataKeySwimmingStrokeStyle",
  LapLength = "HKMetadataKeyLapLength",
  SWOLFScore = "HKMetadataKeySWOLFScore",
  WaterSalinity = "HKMetadataKeyWaterSalinity",
}

export type QuantityType = {
  unit: string;
  doubleValue: number;
}

export enum WaterSalinityType {
  freshWater = 0,
  saltWater = 1,
}

export type WorkoutMetadata = {
    [WorkoutMetadataKey.ActivityType]?: string; // ?
    [WorkoutMetadataKey.AppleFitnessPlusSession]?: string; // ?
    [WorkoutMetadataKey.CoachedWorkout]?: boolean;
    [WorkoutMetadataKey.GroupFitness]?: boolean;
    [WorkoutMetadataKey.IndoorWorkout]?: boolean;
    [WorkoutMetadataKey.WorkoutBrandName]?: string;  
    [WorkoutMetadataKey.CyclingFunctionalThresholdPowerTestType]?: string; // ?
    [WorkoutMetadataKey.FitnessMachineDuration]?: QuantityType;
    [WorkoutMetadataKey.CrossTrainerDistance]?: QuantityType;
    [WorkoutMetadataKey.IndoorBikeDistance]?: QuantityType;
    [WorkoutMetadataKey.AverageMETs]?: QuantityType;
    [WorkoutMetadataKey.PhysicalEffortEstimationType]?: string; // ?
    [WorkoutMetadataKey.AlpineSlopeGrade]?: QuantityType;
    [WorkoutMetadataKey.ElevationAscended]?: QuantityType;
    [WorkoutMetadataKey.ElevationDescended]?: QuantityType;
    [WorkoutMetadataKey.AverageSpeed]?: QuantityType;
    [WorkoutMetadataKey.MaximumSpeed]?: QuantityType;
    [WorkoutMetadataKey.SwimmingLocationType]?: number;
    [WorkoutMetadataKey.SwimmingStrokeStyle]?: number;
    [WorkoutMetadataKey.LapLength]?: QuantityType;
    [WorkoutMetadataKey.SWOLFScore]?: string; // ?
    [WorkoutMetadataKey.WaterSalinity]?: WaterSalinityType;
};

// Reference:
// https://developer.apple.com/documentation/healthkit/hkworkout/workout_metadata_keys