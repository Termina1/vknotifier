@MailService =
  notifyWatch: (watch, posts) ->
    text = posts.map( (post) -> post.text ).join('\n\n')
    user = Meteor.users.findOne(watch.userId)
    if user and user.profile.email
      Email.send
        from: 'notifier@thoughtsync.me'
        to: user.profile.email
        subject: 'You have new messages in ' + watch.name
        text: "Group #{watch.name} was updated. \n #{text}"
