# Dredd Example

This is an example application to demonstrate how easily you can employ the [Dredd](https://github.com/apiaryio/dredd) testing tool as part of your [API design life cycle](https://apiary.io/how-to-build-api).

## How It Works

There is a sample _Gist Fox API_ implementation in the `app.js` file. Every time code of the application is modified and the changes are sent to GitHub, they are tested by Dredd in [CI](https://en.wikipedia.org/wiki/Continuous_integration) against both [API Blueprint][] and [OpenAPI 2][] (fka Swagger) API description formats. If the implementation doesn't follow description of the API, the CI build fails.

## API Description Examples

### [API Blueprint][]

- Document: [apiblueprint/api.apib][]
- Dredd configuration: [apiblueprint/dredd.yml][]
- Dredd hooks: [apiblueprint/hooks.js][]

### [OpenAPI 2][] (formerly known as Swagger)

- Document: [openapi2/api.yml][]
- Dredd configuration: [openapi2/dredd.yml][]
- Dredd hooks: [openapi2/hooks.js][]

## CI Examples

| CI            | Configuration            | Status                                      |
| ------------- | ------------------------ | ------------------------------------------- |
| [Wercker][]   | [wercker.yml][]          | [![Wercker Build Status][]][wercker-link]   |
| [Travis CI][] | [.travis.yml][]          | [![Travis CI Build Status][]][travis-link]  |
| [CircleCI][]  | [.circleci/config.yml][] | [![CircleCI Build Status][]][circle-link]   |
| [AppVeyor][]  | [appveyor.yml][]         | [![AppVeyor Build Status][]][appveyor-link] |
| [Jenkins][]   | [Jenkinsfile][]          | N/A                                         |

## Tutorials

To learn more about about Dredd, read:

- [Dredd Documentation](http://dredd.readthedocs.io/)
- [Dredd's GitHub Repository](https://github.com/apiaryio/dredd)

To learn how to use Dredd with your CI, read:

- [Continuous Integration](http://dredd.readthedocs.io/en/latest/how-to-guides/#continuous-integration) how-to guide in Dredd's documentation
- [Continuous API Testing](https://help.apiary.io/tools/automated-testing/testing-ci/) page in Apiary Help


[API Blueprint]: http://apiblueprint.org/
[apiblueprint/api.apib]: apiblueprint/api.apib
[apiblueprint/dredd.yml]: apiblueprint/dredd.yml
[apiblueprint/hooks.js]: apiblueprint/hooks.js

[OpenAPI 2]: https://www.openapis.org/
[openapi2/api.yml]: openapi2/api.yml
[openapi2/dredd.yml]: openapi2/dredd.yml
[openapi2/hooks.js]: openapi2/hooks.js


[Wercker]: https://www.wercker.com/
[Wercker Build Status]: https://app.wercker.com/status/8e5dbc0f8c677262bbcdbb226b7be168/s/master
[wercker-link]: https://app.wercker.com/project/byKey/8e5dbc0f8c677262bbcdbb226b7be168
[wercker.yml]: wercker.yml

[Travis CI]: https://www.travis-ci.org/
[Travis CI Build Status]: https://travis-ci.org/apiaryio/dredd-example.svg?branch=master
[travis-link]: https://travis-ci.org/apiaryio/dredd-example
[.travis.yml]: .travis.yml

[CircleCI]: https://circleci.com/
[CircleCI Build Status]: https://circleci.com/gh/apiaryio/dredd-example.svg?style=svg
[circle-link]: https://circleci.com/gh/apiaryio/dredd-example
[.circleci/config.yml]: .circleci/config.yml

[AppVeyor]: https://www.appveyor.com/
[AppVeyor Build Status]: https://ci.appveyor.com/api/projects/status/7cqqqpnrlhd2dkg1/branch/master?svg=true
[appveyor-link]: https://ci.appveyor.com/project/Apiary/dredd-example/branch/master
[appveyor.yml]: appveyor.yml

[Jenkins]: https://jenkins.io/
[Jenkinsfile]: Jenkinsfile
