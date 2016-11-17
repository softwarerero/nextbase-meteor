{ Meteor } = require 'meteor/meteor'
{ RedisOplog } = require 'meteor/cultofcoders:redis-oplog'

RedisOplog.init
  redis:
    port: 6379
    host: '127.0.0.1'
  debug: true
  overridePublishFunction: false

Meteor.startup ->

Accounts.onCreateUser (options, user) ->
  console.dir options
  console.dir user

Accounts.registerLoginHandler (serviceData) ->
  console.dir serviceData

Accounts.onLogin (user) ->
  console.log 'onLogin: ' + Meteor.userId()

Meteor.methods
  test: (data) ->
    unless Meteor.userId()
      throw new Meteor.Error 'not logged in'
    data.userId = Meteor.userId()
    console.dir data
    Test.insert data

Meteor.publishWithRedis 'test', (filters, options) ->
  filters = filters || {}
  filters.userId = @userId
  Test.find(filters, options)
