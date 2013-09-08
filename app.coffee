express = require 'express'
db = require("mongous").Mongous

#cleanup and setup database
db('test.$cmd').find({'drop': 'machines'},1)
db('test.$cmd').find({'drop': 'machine_types'},1)

db('test.$cmd').find({"create": "machines"},1)
db('test.$cmd').find({"create": "machine_types"},1)

machines = db('test.machines')
machineTypes = db('test.machine_types')

app = express()
app.use(express.bodyParser())

app.post '/machines', (req, res) ->
  if db('test.machines').insert req.body
    res.send 202
  else
    res.send 500

app.put '/machines', (req, res) ->
  if db('test.machines').save req.body
    res.send 202
  else
    res.send 500

app.get '/machines/:name', (req, res) ->
  db('test.machines').find {name: req.query.name}, 1, (reply) ->
    documents = reply['documents']
    if not documents.length == 0
      doc = reply['documents'][0]
      res.send 200, JSON.stringify doc
    else
      res.send 404

app.delete '/machines/:name', (req, res) ->
  if db('test.machines').remove {name: req.query.name}
    res.send 204
  else
    res.send 404

app.listen 3000