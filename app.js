const express = require('express');
const expressMongoDb = require('express-mongo-db');
const bodyParser = require('body-parser');


// creating Express.js server
app = express();

// parse incoming data as JSON
app.use(bodyParser.json());

// setup Mongo connection
const mongoURI = process.env.MONGO_URI || 'mongodb://localhost';
app.use(expressMongoDb(`${mongoURI}/dredd-example`));

// return HAL by default
app.use((req, res, next) => {
  res.contentType('application/hal+json');
  next();
});


// Returns buffer object with stringified JSON object. The buffer object
// prevents Express.js to add 'charset=utf-8', which is against JSON spec.
function toJSON(obj) {
  return Buffer.from(JSON.stringify(obj, null, 2));
}


app.get('/', (req, res) => {
  res.set('Link', '<http://api.example.com/>;rel="self",<http://api.example.com/gists>;rel="gists"');
  res.status(200).send(toJSON({
    '_links': {
      'self': {'href': '/'},
      'gists': {'href': '/gists?{since}', 'templated': true},
    }
  }));
});

app.get('/gists/:id', (req, res) => {
  const gists = req.db.collection('gists');

  gists.find({'_id': req.params.id}).toArray((err, docs) => {
    if (err) {
      console.error(err);
      res.sendStatus(500);
    } else if (docs.length != 0) {
      doc = docs[0];
      doc.id = doc._id;
      delete doc._id;
      doc._links = {
        'self': {'href': `/gists/#{id}`},
        'star': {'href': `/gists/#{id}/star`},
      };

      res.set('Link', `<http://api.example.com/gists/${doc.id}>;rel="self", <http://api.example.com/gists/${doc.id}/star>;rel="star"`);
      res.status(200).send(toJSON(doc));
    } else {
      res.sendStatus(404);
    }
  });
});

app.patch('/gists/:id', (req, res) => {
  const gists = req.db.collection('gists');

  const update = {};
  for (const key in req.body) {
    const value = {};
    value[key] = req.body[key];
    update['$set'] = value;
  }

  gists.updateOne({'_id': req.params.id}, update, (err, result) => {
    if (err) {
      console.error(err);
      res.sendStatus(500);
    } else {
      gists.find({'_id': req.params.id}).toArray((err, docs) => {
        if (err) {
          console.error(err);
          res.sendStatus(500);
        } else if (docs.length != 0) {
          doc = docs[0];
          doc.id = doc._id;
          delete doc._id;
          doc._links = {
            'self': {'href': `/gists/#{id}`},
            'star': {'href': `/gists/#{id}/star`},
          };

          res.set('Link', `<http://api.example.com/gists/${doc.id}>;rel="self", <http://api.example.com/gists/${doc.id}/star>;rel="star"`);
          res.status(200).send(toJSON(doc));
        } else {
          res.sendStatus(404);
        }
      });
    }
  });
});

app.delete('/gists/:id', (req, res) => {
  const gists = req.db.collection('gists');

  gists.deleteOne({'_id': req.params.id}, (err, result) => {
    if (err) {
      console.error(err);
      res.sendStatus(500);
    } else {
      res.sendStatus(204);
    }
  });
});

app.get('/gists', (req, res) => {
  const gists = req.db.collection('gists');

  gists.find({}).toArray((err, docs) => {
    if (err) {
      console.error(err);
      res.sendStatus(500);
    } else {
      body = {
        '_links': {'self': { 'href': '/gists'}},
        '_embedded': {'gists': []},
        'total': docs.length,
      };
      for (const doc of docs) {
        doc.id = doc._id;
        delete doc._id;
        doc._links = {'self': {'href': `/gists/${doc.id}`}};
        body._embedded.gists.push(doc);
      }

      res.set('Link', '<http://api.example.com/gists>;rel="self"');
      res.status(200).send(toJSON(body));
    }
  });
});

app.post('/gists', (req, res) => {
  const gists = req.db.collection('gists');

  const doc = req.body;
  doc.created_at = new Date().toISOString();

  gists.insert(doc, (err) => {
    if (err) {
      console.error(err);
      res.sendStatus(500);
    } else {
      doc.id = doc._id;
      delete doc._id;
      doc._links = {
        'self': {'href': `/gists/${doc.id}`},
        'star': {'href': `/gists/${doc.id}/star`},
      };

      res.set('Link', `<http://api.example.com/gists/${doc.id}>;rel="self", <http://api.example.com/gists/${doc.id}/star>;rel="star"`)
      res.status(201).send(toJSON(doc));
    }
  });
});

app.get('/gists/:id/star', (req, res) => {
  const stars = req.db.collection('stars');

  stars.find({'gist_id': req.params.id}).toArray((err, docs) => {
    if (err) {
      console.error(err);
      res.sendStatus(500);
    } else if (docs.length != 0) {
      doc = docs[0];
      delete doc.id;
      delete doc._id;
      doc._links = {
        'self': {'href': `/gists/${doc.id}/star`},
      };

      res.set('Link', `<http://api.example.com/gists/#{id}/star>;rel="self"`);
      res.status(200).send(toJSON(doc));
    } else {
      res.sendStatus(404);
    }
  });
});

app.put('/gists/:id/star', (req, res) => {
  const stars = req.db.collection('stars');
  const doc = {'gist_id': req.params.id, 'starred': true};

  stars.insert(doc, (err) => {
    if (err) {
      console.error(err);
      res.sendStatus(500);
    } else {
      res.sendStatus(204);
    }
  });
});

app.delete('/gists/:id/star', (req, res) => {
  const stars = req.db.collection('stars');

  stars.deleteOne({'_id': req.params.id}, (err, result) => {
    if (err) {
      console.error(err);
      res.sendStatus(500);
    } else {
      res.sendStatus(204);
    }
  });
});


app.listen(3000);
console.log('Listening on port 3000');
