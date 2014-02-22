express = require 'express'
db = require("mongous").Mongous

machines = db('test.machines')
machineTypes = db('test.machine_types')

app = express()
app.use(express.bodyParser())


app.use(express.logger())

app.use (req, res, next) ->
  res.contentType('application/json')
  next()

app.post '/machines', (req, res) ->
  console.log "BODY: " + JSON.stringify(req.body)
  if db('test.machines').insert req.body
    res.send 202 , {'message': 'Accepted'}
  else
    res.send 500

app.get '/machines', (req, res)  ->
  db('test.machines').find (reply) ->
    documents = reply['documents']
    res.send 200, documents

app.get '/machines/:name', (req, res) ->
  console.log "NANE: " + req.params.name
  db('test.machines').find {name: req.params.name}, (reply) ->
    documents = reply['documents']
    if documents.length != 0
      res.send 200, documents[0]
    else
      res.send 400

app.delete '/machines/:name', (req, res) ->
  if db('test.machines').remove {name: req.params.name}
    res.send 204
  else
    res.send 404

app.post '/v2/machines', (req, res) ->
  console.log "BODY: " + JSON.stringify(req.body)
  console.log 'VERSION 2'
  if db('test.machines').insert req.body
    res.send 202 , {'message': 'Accepted'}
  else
    res.send 500

app.get '/v2/machines', (req, res)  ->
  db('test.machines').find (reply) ->
    documents = reply['documents']
    res.send 200, documents

app.get '/v2/machines/:name', (req, res) ->
  console.log "NANE: " + req.params.name + ' VERSION 2'
  db('test.machines').find {name: req.params.name}, (reply) ->
    documents = reply['documents']
    if documents.length != 0
      res.send 200, documents[0]
    else
      res.send 400

app.delete '/v2/machines/:name', (req, res) ->
  if db('test.machines').remove {name: req.params.name}
    res.send 204
  else
    res.send 404


app.listen 3000
console.log 'Listening on port 3000'
