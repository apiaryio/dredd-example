express = require 'express'

app = express()

app.get '/hello.txt', (req, res) ->
  body = "Hello world"
  res.setHeader 'Content-Type', 'text/plain'
  res.setHeader 'Content-Length', body.length
  res.send body

app.listen 3000