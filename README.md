Dredd Example CI setup
===================

This is simple example CI setup for demostration how to validate [polls-api][] (living at [polls-api-url][]) written in both 
[API Blueprint][] and [Swagger][] format with [Dredd][] testing tool and [Gavel][] library using various Continous Integration.

| CI Service | Status |
| ---------- | ------ |
| Travis-CI | [![Travis-CI Build Status](https://travis-ci.org/apiaryio/dredd-example.png?branch=master)](https://travis-ci.org/apiaryio/dredd-example) |
| Circle-CI | [![Circle-CI Build Status](https://circleci.com/gh/apiaryio/dredd-example.png?circle-token=29f2fab741d29cf6e66ceb55a99c38e8295ed9bf)](https://circleci.com/gh/apiaryio/dredd-example)
| Drone.io | [![Drone.io Build Status](https://drone.io/github.com/apiaryio/dredd-example/status.png)](https://drone.io/github.com/apiaryio/dredd-example/latest) |

Have a look at our [blogpost how to test RESTful APIs][blogpost] with [Dredd][], [Gavel][] and [API Blueprint][]

[Travis-CI]: https://travis-ci.org/
[Dredd]: https://github.com/apiaryio/dredd
[Gavel]: https://www.relishapp.com/apiary/gavel/docs
[API Blueprint]: http://apiblueprint.org/
[Swagger]: https://swagger.io
[blogpost]: http://blog.apiary.io/2013/10/17/How-to-test-api-with-api-blueprint-and-dredd/
[polls-api]: https://github.com/apiaryio/polls-api
[polls-api-url]: https://polls.apiblueprint.org/
