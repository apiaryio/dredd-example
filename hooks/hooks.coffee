{before, after} = require 'hooks'

db = require("mongous").Mongous
gists = db('test.gists')
stars = db('test.stars')

fixtures = require './fixtures'

before "Gist > Gist > Retrieve a Single Gist", (transaction) ->
  gists.insert fixtures.gist


before "Gist > Gists Collection > List All Gists", (transaction) ->
  gists.insert fixtures.gist


before "Gist > Star > Check if a Gist is Starred", (transaction) ->
  stars.insert fixtures.star