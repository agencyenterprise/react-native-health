import AppleHealthKit from "react-native-health";

const initializeAHK = () => {
  /* Permission options */
  const permissions = {
    permissions: {
      read: [AppleHealthKit.Constants.Permissions.HeartRate],
      write: [AppleHealthKit.Constants.Permissions.Steps],
    },
  };

  AppleHealthKit.initHealthKit(permissions, (error) => {
    /* Called after we receive a response from the system */

    if (error) {
      console.log("[ERROR] Cannot grant permissions!");
    }

    /* Can now read or write to HealthKit */

    const options = {
      startDate: new Date(2020, 1, 1).toISOString(),
    };

    AppleHealthKit.getHeartRateSamples(options, (callbackError, results) => {
      console.log("error: ", callbackError);
      console.log("results", results);
    });
  });
};

export default initializeAHK;
