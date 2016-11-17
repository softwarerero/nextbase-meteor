{ Meteor } = require 'meteor/meteor'
{ Random } = require 'meteor/random'
{ RedisOplog } = require 'meteor/cultofcoders:redis-oplog'


Meteor.startup ->
  if Meteor.isDevelopment and Meteor.isServer
    createUsers()

createUsers = ->
  if Meteor.users.find().count() then return
  userId = Meteor.users.insert
    username: 'test'
    emails: ['test@localhost']
  Accounts.setPassword userId, 'password'
