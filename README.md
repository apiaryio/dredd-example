# Dredd Example CI Setup

This is example CI setup to demostrate how easily you can validate your HTTP API implementation in [CI][] with the [Dredd][] testing framework.

## How It Works

The example CI setup tests [Apiary][]'s sample application called [Polls API][], which lives at [polls.apiblueprint.org](https://polls.apiblueprint.org/). The API is tested against both [API Blueprint][] and [Swagger][] API description formats.

## Tutorials

To learn how to use Dredd with your CI, read:

- [Continuous Integration](http://dredd.readthedocs.io/en/latest/how-to-guides/#continuous-integration) how-to guide in Dredd's documentation
- [Continuous API Testing](https://help.apiary.io/tools/automated-testing/testing-ci/) page in Apiary Help

## Status

| CI Service | Status |
| ---------- | ------ |
| Travis CI  | [![Travis CI Build Status](https://travis-ci.org/apiaryio/dredd-example.svg?branch=master)](https://travis-ci.org/apiaryio/dredd-example) |
| CircleCI   | [![CircleCI Build Status](https://circleci.com/gh/apiaryio/dredd-example.svg?style=svg)](https://circleci.com/gh/apiaryio/dredd-example) |
| Drone.io   | [![Drone.io Build Status](https://drone.io/github.com/apiaryio/dredd-example/status.png)](https://drone.io/github.com/apiaryio/dredd-example/latest) |


[CI]: https://en.wikipedia.org/wiki/Continuous_integration
[Apiary]: https://apiary.io/
[Travis-CI]: https://travis-ci.org/
[Dredd]: https://github.com/apiaryio/dredd
[API Blueprint]: http://apiblueprint.org/
[Swagger]: https://swagger.io
[Polls API]: https://github.com/apiaryio/polls-api
