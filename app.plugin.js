const { withEntitlementsPlist, withInfoPlist } = require('@expo/config-plugins')

const HEALTH_SHARE = 'Allow $(PRODUCT_NAME) to check health info'
const HEALTH_UPDATE = 'Allow $(PRODUCT_NAME) to update health info'

const withHealthKit = (
  config,
  { healthSharePermission, healthUpdatePermission, isClinicalDataEnabled } = {},
) => {
  // Add permissions
  config = withInfoPlist(config, (config) => {
    config.modResults.NSHealthShareUsageDescription =
      healthSharePermission ||
      config.modResults.NSHealthShareUsageDescription ||
      HEALTH_SHARE
    config.modResults.NSHealthUpdateUsageDescription =
      healthUpdatePermission ||
      config.modResults.NSHealthUpdateUsageDescription ||
      HEALTH_UPDATE

    return config
  })

  // Add entitlements. These are automatically synced when using EAS build for production apps.
  config = withEntitlementsPlist(config, (config) => {
    config.modResults['com.apple.developer.healthkit'] = true
    if (
      !Array.isArray(config.modResults['com.apple.developer.healthkit.access'])
    ) {
      config.modResults['com.apple.developer.healthkit.access'] = []
    }

    if (isClinicalDataEnabled) {
      config.modResults['com.apple.developer.healthkit.access'].push(
        'health-records',
      )

      // Remove duplicates
      config.modResults['com.apple.developer.healthkit.access'] = [
        ...new Set(config.modResults['com.apple.developer.healthkit.access']),
      ]
    }

    return config
  })

  return config
}
module.exports = withHealthKit
