express = require 'express'

mongoose = require('mongoose')
mongoose.connect('mongodb://localhost/test')

machineSchema = mongoose.Schema {}, {strict: false}
Machines = mongoose.model 'Machines', machineSchema

app = express()
app.use(express.bodyParser())

app.use(express.logger())

app.use (req, res, next) ->
  res.contentType('application/json')
  next()

app.post '/machines', (req, res) ->
  machine = new Machines req.body
  machine.save (err, machine) ->
    if err
      return res.send 500
    
    res.send 201 , machine
  
app.get '/machines', (req, res)  ->
  Machines.find {}, (err, machines) ->      
    if err
      return res.send 500
    res.send 200, machines

app.get '/machines/:id', (req, res) ->
  Machines.findOne {_id: req.params.id}, (err, machine) ->
    if err
      return res.send 500
    
    unless machine?
      return res.send 404
    
    res.send 200, machine

app.delete '/machines/:id', (req, res) ->
  Machines.findOne {_id: req.params.id}, (err, machine) ->
    if err
      return res.send 500

    unless machine?
      return res.send 404

    Machines.remove {_id: req.params.id}, (err) ->
      if err
        return res.send 500
      res.send 204

app.listen 3000
console.log('Listening on port 3000');
