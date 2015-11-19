#
# Runs Passport.js setup code including mounting strategies, serializers, etc.
#

passport = require 'passport'
FacebookStrategy = require('passport-facebook').Strategy
TwitterStrategy = require('passport-twitter').Strategy
LocalStrategy = require('passport-local').Strategy
callbacks = require './callbacks'
{ serialize, deserialize } = require './serializers'
opts = require '../options'

module.exports = ->
  passport.serializeUser serialize
  passport.deserializeUser deserialize
  passport.use new LocalStrategy(
    { usernameField: 'email', passReqToCallback: true }
    callbacks.local
  )
  passport.use new FacebookStrategy
    clientID: opts.FACEBOOK_ID
    clientSecret: opts.FACEBOOK_SECRET
    passReqToCallback: true
    callbackURL: "#{opts.APP_URL}#{opts.facebookCallbackPath}"
  , callbacks.facebook
  passport.use new TwitterStrategy
    consumerKey: opts.TWITTER_KEY
    consumerSecret: opts.TWITTER_SECRET
    passReqToCallback: true
    callbackURL: "#{opts.APP_URL}#{opts.twitterCallbackPath}"
  , callbacks.twitter

