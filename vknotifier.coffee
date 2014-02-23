@WatchRepository =
  get: (group) ->
    Watches.find(userId: Meteor.userId(), gid: group.gid).fetch()[0]

  isWatched: (group) ->
    @get(group)

  addToWatching: (group) ->
    unless @isWatched group
      Watches.insert userId: Meteor.userId(), gid: group.gid, name: group.name, start: Math.floor Date.now() / 1000

  stopWatching: (group) ->
    watch = @get(group)
    Watches.remove _id: watch._id

  getForUser: (userId) ->
    Watches.find(userId: userId).fetch()

  refresh: (watch) ->
    Watches.update watch._id, $set: start: Math.floor Date.now() / 1000

if Meteor.isClient

  Template.hello.events =
    'click .js-watch': ->
      WatchRepository.addToWatching @

    'click .js-unwatch': ->
      WatchRepository.stopWatching @

  Template.hello.groups = ->
    Groups.find().fetch()?[0]?.groups or []

  Template.hello.watched = (group) ->
    WatchRepository.isWatched group