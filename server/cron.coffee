checkWatch = (instance, userId, watch) ->
  instance 'wall.get', v: '5.11', filter: 'owner', owner_id: '-' + watch.gid,  Meteor.bindEnvironment (error, result) ->
    newposts = result.items.filter (post) -> post.date > watch.start
    if newposts.length
      WatchRepository.refresh watch
      MailService.notifyWatch watch, newposts


scrapper = new Cron(1000)
scrapper.addJob 10, ->
  for user in Meteor.users.find().fetch()
    token = user.services?.vkontakte?.accessToken
    if token
      instance = VkontakteApi(token)
      WatchRepository.getForUser(user._id).forEach (watch) ->
        checkWatch instance, user._id, watch
