# Dredd Example

This is an example application to demonstrate how easily you can employ the [Dredd][] testing framework as part of your [API design life cycle][].

## How It Works

There is a sample Gist Fox API implementation in the `app.js` file. Every time code of the application is changed and the changes are sent to GitHub, they are tested by Dredd in [CI][] against both [API Blueprint][] and [Swagger][] API description formats. If the implementation doesn't follow description of the API, the CI build would fail.

## Tutorials

To learn more about about Dredd, read:

- [Dredd Documentation](http://dredd.readthedocs.io/)
- [Dredd's GitHub Repository](https://github.com/apiaryio/dredd)

To learn how to use Dredd with your CI, read:

- [Continuous Integration](http://dredd.readthedocs.io/en/latest/how-to-guides/#continuous-integration) how-to guide in Dredd's documentation
- [Continuous API Testing](https://help.apiary.io/tools/automated-testing/testing-ci/) page in Apiary Help

## Status

| CI Service | Status |
| ---------- | ------ |
| Travis CI  | [![Travis CI Build Status](https://travis-ci.org/apiaryio/dredd-example.svg?branch=master)](https://travis-ci.org/apiaryio/dredd-example) |
| CircleCI   | [![CircleCI Build Status](https://circleci.com/gh/apiaryio/dredd-example.svg?style=svg)](https://circleci.com/gh/apiaryio/dredd-example) |
| AppVeyor   | [![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/7cqqqpnrlhd2dkg1?svg=true)](https://ci.appveyor.com/project/Apiary/dredd-example) |


[CI]: https://en.wikipedia.org/wiki/Continuous_integration
[Apiary]: https://apiary.io/
[Travis-CI]: https://travis-ci.org/
[Dredd]: https://github.com/apiaryio/dredd
[API Blueprint]: http://apiblueprint.org/
[Swagger]: https://swagger.io
[API design life cycle]: https://apiary.io/how-to-build-api
