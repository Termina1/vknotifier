@Watches = new Meteor.Collection 'watches'
Watches.allow
  insert: (userId, record) ->
    record.userId is userId

  remove: (userId, record) ->
    record.userId is userId