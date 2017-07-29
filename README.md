# builderscon tokyo 2017 official iOS app

[builderscon tokyo 2017](https://builderscon.io/tokyo/2017) Aug 3, 4, 5 2017.

## Features
- View timetable and details of each session
- View a foloor map
- Use QR code reader

## Requirements
- Swift 3.0 or later
- iOS 9.0 or later

## Installation
gem

```shell
$ bundle install --path vendor/bundle
```

Carthage

```shell
$ carthage bootstrap --platform iOS
```

SwiftLint(option)

```shell
$ brew install swiftlint
```

## Development Environment

### Storage
- DebugBuild: load from local JSON file
- ReleaseBuild: load from DiskCache([Cache](https://github.com/hyperoslo/Cache) adapter)

## License
[conference-app-2017-ios](https://github.com/to4iki/conference-app-2017-ios) is released under the [MIT License][license-url]

[license-url]: https://github.com/to4iki/conference-app-2017-ios/blob/master/LICENSE
