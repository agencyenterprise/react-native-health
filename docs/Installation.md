Install the `rn-apple-healthkit` npm package

- Run `npm install rn-apple-healthkit --save`
- Run `react-native link rn-apple-healthkit`

Update `info.plist` in your React Native project
```
<key>NSHealthShareUsageDescription</key>
<string>Read and understand health data.</string>
<key>NSHealthUpdateUsageDescription</key>
<string>Share workout data with other apps.</string>
```
