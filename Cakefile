exec = require('child_process').exec
ssh = require './.node_modules/NodeSSH'
scp = require './.node_modules/scp'
deploy = (host, name, pass, path, start = true, port=3001) ->
  client = new ssh host, name, pass
  console.log 'connecting to server'
  client.connect ->
    client.once 'data', ->
      console.log 'cleaning old code'
      client.write "cd #{path}\r\n"
      client.write 'rm -rf bundle\r\n'
      console.log "creating bundle for deploy"
      exec 'meteor bundle myapp.tgz', {}, ->
        console.log "bundle created, uploading to server"
        scp.send file: 'myapp.tgz', user: name, password: pass, host: host, path: path, ->
          client.write 'tar -xzf myapp.tgz\r\n'
          console.log 'unpacking files'
          client.write 'rm myapp.tgz\r\n'
          client.write 'cd bundle/programs/server\r\n'
          client.write 'rm -rf node_modules/fibers\r\n'
          client.write 'npm install fibers\r\n'
          client.write "cd #{path}\r\n"
          client.write 'exit\r\n'

task 'deploy', ->
  deploy '192.81.223.179', 'terminal', false, './vknotifier', true, 3005
