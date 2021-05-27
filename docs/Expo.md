# Expo installation

> This package cannot be used in the "Expo Go" app because [it requires custom native code](https://docs.expo.io/workflow/customizing/).

First install the package with yarn, npm, or [`expo install`](https://docs.expo.io/workflow/expo-cli/#expo-install).

```sh
expo install react-native-health
```

After installing this npm package, add the [config plugin](https://docs.expo.io/guides/config-plugins/) to the [`plugins`](https://docs.expo.io/versions/latest/config/app/#plugins) array of your `app.json` or `app.config.js`:

```json
{
  "expo": {
    "plugins": ["react-native-health"]
  }
}
```

Next, rebuild your app as described in the ["Adding custom native code"](https://docs.expo.io/workflow/customizing/) guide.

## API

The plugin provides props for extra customization. Every time you change the props or plugins, you'll need to rebuild (and `prebuild`) the native app. If no extra properties are added, defaults will be used.

- `healthSharePermission` (_string_): Sets the iOS `NSHealthShareUsageDescription` permission message to the `Info.plist`. Defaults to `Allow $(PRODUCT_NAME) to check health info`.
- `healthUpdatePermission` (_string_): Sets the iOS `NSHealthUpdateUsageDescription` permission message to the `Info.plist`. Defaults to `Allow $(PRODUCT_NAME) to update health info`.
- `isClinicalDataEnabled` (_boolean_): Adds `health-records` to the `com.apple.developer.healthkit.access` entitlement in the iOS project. Defaults to false.

`app.config.js`

```json
{
  "expo": {
    "plugins": [
      [
        "react-native-health",
        {
          "isClinicalDataEnabled": true,
          "healthSharePermission": "Custom health share permission",
          "healthUpdatePermission": "Custom health update permission"
        }
      ]
    ]
  }
}
```

## Background Processing

Background processing is not currently supported by this plugin.

## Capabilities

This plugin will enable the iOS `com.apple.developer.healthkit` entitlement, but in order to sync this with the bundle identifier' production capabilities you'll need to do one of two things:

- Automatic: Build the app with [EAS build](https://docs.expo.io/build/introduction/)
- Manual: Visit [Apple developer portal](https://developer.apple.com/account/resources/identifiers/list) and enable the HealthKit capability for your bundle identifier before building for production. This can also be done via Xcode.
