var hooks = require('hooks');

hooks.before('Question > Questions collection > Create a new question', function (transaction) {
  transaction.request.body = transaction.request.body.replace('language?', 'language' + Math.random() + '?');
});
