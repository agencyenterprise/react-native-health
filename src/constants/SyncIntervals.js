/**
 * Named aliases for common background-sync intervals.
 * Pass to configureBackgroundSync({ syncInterval }).
 * Default when omitted: every24Hours.
 *
 * You may also pass a raw number of seconds instead of a named alias,
 * e.g. { syncInterval: 60 } for a 1-minute interval.
 *
 * @type {Object}
 */
export const SyncIntervals = {
  every1Hour:   'every1hour',
  every6Hours:  'every6hours',
  every12Hours: 'every12hours',
  every24Hours: 'every24hours',
  every48Hours: 'every48hours',
  everyWeek:    'everyweek',
}
