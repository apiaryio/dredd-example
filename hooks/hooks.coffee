{before, after} = require 'hooks'

responseStash = {}

after "Machines > Machines collection > Create a Machine", (transaction) ->
  responseStash['Machines > Machines collection > Create a Machine'] = transaction.real

before "Machines > Machine > Retrieve a Machine", (transaction) ->
  stash = responseStash['Machines > Machines collection > Create a Machine']
  bodyObject = JSON.parse stash.body
  newId = bodyObject['_id']
  transaction.request.uri = transaction.request.uri.replace '52341870ed55224b15ff07ef', newId
  transaction.fullPath = transaction.fullPath.replace '52341870ed55224b15ff07ef', newId
  
before "Machines > Machine > Delete a Machine", (transaction) ->
  stash = responseStash['Machines > Machines collection > Create a Machine']
  bodyObject = JSON.parse stash.body
  newId = bodyObject['_id']
  transaction.request.uri = transaction.request.uri.replace '52341870ed55224b15ff07ef', newId
  transaction.fullPath = transaction.fullPath.replace '52341870ed55224b15ff07ef', newId