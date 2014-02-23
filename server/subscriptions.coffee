Meteor.publish 'user-groups', ->
  user = Meteor.users.findOne(@userId)
  vk = VkontakteApi(user.services.vkontakte.accessToken)
  vk 'groups.get', extended: 1, (error, result) =>
    @added 'groups', @userId, groups: result.slice(1)
  @ready()

Meteor.publish 'user-watches', ->
  Watches.find userId: @userId