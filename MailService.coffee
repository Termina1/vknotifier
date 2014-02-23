@MailService =
  notifyWatch: (watch, posts) ->
    text = posts.map( (post) -> post.text ).join('\n\n');
    Email.send
      from: 'notifier@thoughtsync.me'
      to: 'terminal2010@gmail.com'
      subject: 'You have new messages in ' + watch.name
      text: "Group #{watch.name} was updated. \n #{text}"
