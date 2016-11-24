
const hooks = require('hooks');
const {MongoClient} = require('mongodb');


let db;


// Fixtures
const gist = {
  '_id': '42',
  'created_at': new Date().toISOString(),
  'description': 'Gist description...',
  'content': 'String content...',
}

const star = {
  'gist_id': '42',
  'starred': true,
}


// Setup database connection before Dredd starts testing
hooks.beforeAll((transactions, done) => {
  MongoClient.connect('mongodb://localhost/dredd-example', function(err, conn) {
    db = conn;
    done(err);
  });
});

// Close database connection after Dredd finishes testing
hooks.afterAll((transactions, done) => {
  db.close();
  done();
});


// Before each test let's fix the media type - unfortunately current support
// of Swagger in Dredd works only for application/json as of now
hooks.beforeEach((transaction, done) => {
  let contentType;

  if (transaction.expected.statusCode == '204') {
    transaction.request.headers['Accept'] = 'text/plain';
    delete transaction.expected.headers['Content-Type'];
  } else {
    transaction.request.headers['Accept'] = 'application/hal+json';
    transaction.expected.headers['Content-Type'] = 'application/hal+json';
  }
  done();
});

// After each test clear contents of the database (we want isolated tests)
hooks.afterEach((transaction, done) => {
  db.collection('gists').remove({}, (err) => {
    if (err) { return done(err) }

    db.collection('stars').remove({}, (err) => {
      done(err);
    });
  });
});


// To test work with Gists and Stars in isolation, we need to add some prior
// to certain HTTP transactions Dredd is about to make
hooks.before('/gists/{id} > GET > 200 > application/json', (transaction, done) => {
  db.collection('gists').insert(gist, (err) => {
    done(err);
  });
});

hooks.before('/gists/{id} > PATCH > 200 > application/json', (transaction, done) => {
  db.collection('gists').insert(gist, (err) => {
    done(err);
  });
});

hooks.before('/gists > GET > 200 > application/json', (transaction, done) => {
  db.collection('gists').insert(gist, (err) => {
    done(err);
  });
});

hooks.before('/gists/{id}/star > GET > 200 > application/json', (transaction, done) => {
  db.collection('stars').insert(star, (err) => {
    done(err);
  });
});
