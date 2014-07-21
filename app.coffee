express = require 'express'
db = require("mongous").Mongous

gists = db('test.gists')
stars = db('test.stars')

app = express()
app.use(express.bodyParser())


app.use(express.logger())

app.use (req, res, next) ->
  res.contentType('application/hal+json')
  next()

app.get '/', (req, res) ->
  res.set 'Link', '<http:/api.gistfox.com/>;rel="self",<http:/api.gistfox.com/gists>;rel="gists"'
  document = {
    "_links": {
      "self": { "href": "/" },
      "gists": { "href": "/gists?{since}", "templated": true }
    }
  }
  res.send 200, document

app.get '/gists/:id', (req, res) ->
  id = req.params.id
  gists.find {id: id}, (reply) ->
    documents = reply['documents']
    if documents.length != 0
      body = documents[0]
      body['_links'] = {
        "self": { "href": "/gists/#{id}" },
        "star": { "href": "/gists/#{id}/star" }        
      }
      res.set 'Link', "<http:/api.gistfox.com/gists/#{id}>;rel=\"self\", <http:/api.gistfox.com/gists/#{id}/star>;rel=\"star\""
      res.send 200, body
    else
      res.send 404

app.patch '/gists/:id', (req, res) ->
  id = req.params.id
  gists.find {id: id}, (reply) ->
    documents = reply['documents']
    if documents.length != 0
      doc = documents[0]
      delete req.body['id']
      delete req.body['_id']
      for key, value of req.body
        doc['key'] = value
      if gists.update {id: id}, doc, {upsert: true, multi: false}      
        body = documents[0]
        body['_links'] = {
          "self": { "href": "/gists/#{id}" },
          "star": { "href": "/gists/#{id}/star" }        
        }
        res.set 'Link', "<http:/api.gistfox.com/gists/#{id}>;rel=\"self\", <http:/api.gistfox.com/gists/#{id}/star>;rel=\"star\""
        res.send 200, body
      else
        res.send 500
    else
      res.send 404

app.delete '/gists/:id', (req, res) ->
  id = req.params.id
  if gists.remove {id: id}
    res.send 204
  else
    res.send 404

app.get '/gists', (req, res)  ->
  gists.find (reply) ->
    documents = reply['documents']
    
    body = {}
    body['_links'] = { "self": { "href": "/gists" }}
    body['_embedded'] = {}
    body['_embedded']['gists'] = []
    body['total'] = documents.length

    for doc in documents
      doc['_links'] = { "self": {"href": "/gists/#{doc['id']}"}}
      body['_embedded']['gists'].push doc

    res.set 'Link', '<http:/api.gistfox.com/gists>;rel="self"'
    res.send 200, body

app.post '/gists', (req, res) ->
  id = 42 #Math.floor((Math.random() * 100) + 1)
  doc = req.body
  doc['id'] = id
  doc['created_at'] = new Date().getTime()
  if gists.insert doc
    doc['_links'] = {
      "self": { "href": "/gists/#{id}" },
      "star": { "href": "/gists/#{id}/star" }        
    }
    res.set 'Link', "<http:/api.gistfox.com/gists/#{id}>;rel=\"self\", <http:/api.gistfox.com/gists/#{id}/star>;rel=\"star\""
    res.send 201 , doc
  else
    res.send 500

app.put '/gists/:id/star', (req, res) ->
  id = req.params.id 

  doc = {
    'gist_id': id
    'starred': true
  }

  if stars.insert doc
    res.send 204
  else
    res.send 500

app.delete '/gists/:id/star', (req, res) ->
  id = req.params.id 

  if stars.remove {gist_id: id}
    res.send 204
  else
    res.send 500


app.get '/gists/:id/star', (req, res) ->
  id = req.params.id
  stars.find {gist_id: id}, (reply) ->
    documents = reply['documents']
    if documents.length != 0
      body = documents[0]
      body['_links'] = {
        "self": { "href": "/gists/#{id}/star" },     
      }
      res.set 'Link', "<http:/api.gistfox.com/gists/#{id}/star>;rel=\"self\""
      res.send 200, body
    else
      res.send 404
      
app.listen 3000
console.log('Listening on port 3000');
