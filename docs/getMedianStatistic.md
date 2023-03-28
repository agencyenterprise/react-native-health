#  getMedianStatistic

Query for median between entries. The options object is used to setup a query to retrieve relevant data.

Example input options:

```javascript
const options = {
    types: [AppleHealthKit.Constants.MedianStatisticsDataTypes.Weight,
        AppleHealthKit.Constants.MedianStatisticsDataTypes.HeartRate,
        AppleHealthKit.Constants.MedianStatisticsDataTypes.Running,
        AppleHealthKit.Constants.MedianStatisticsDataTypes.Workout]
};
```
```javascript
AppleHealthKit.getMedianStatistic(
    input,
    (callbackError: string, results: HealthValue[]) => {    
        console.log(results);
    },
);
```

Example output:
```json
[ 
    { 
        "parameterName": "Weight",
        "firstEntry": "2023-03-13T21:28:00.000+0300",
        "medianSeconds": 69660,
        "lastEntry": "2023-03-17T17:32:00.000+0300",
        "medianDays": 0,
        "entryCount": 11 },
    { 
        "parameterName": "HeartRate",
        "firstEntry": "2023-03-14T22:49:00.000+0300",
        "medianSeconds": 86400,
        "lastEntry": "2023-03-16T22:49:00.000+0300",
        "medianDays": 1,
        "entryCount": 3         
    } 
]
```

Permissions for input data types should be requested before calling the method, otherwise method will return no data for unresolved data types.   


Median statistics available for any data type, which is possible to request permissions for (see [Permissions](permissions.md)), and also for Activity types (see [Activities](activities.md)). It means, that could be requested both type 'Workout' for common workout data and 'Running' or any other Activity type.   


Median statistic not available for HKCharacteristicType according to HealthKit documentation.   


Median counted for intervals between entries from 00:00:00 UTC on 1 January 1970 till current Date and returned in days and seconds.


