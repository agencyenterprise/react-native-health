/**
 * Apple Health Data Types For Median Statistic
 *
 * @type {Object}
 */

 import { Activities } from './Activities'
 import { Permissions } from './Permissions'

 export const MedianStatisticsDataTypes = {
   ...Activities,
   ...Permissions
 }
