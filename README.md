<picture>
  <source media="(prefers-color-scheme: dark)" srcset="./Docs/logo-dark.svg">
  <img alt="Smartsupp logo." src="./Docs/logo-light.svg">
</picture>

# Add Smartsupp widget to your iOS App

Welcome to the documentation of the Smartsupp framework, your gateway to seamless live chat communication with customer support in your mobile applications. This document is designed to assist you in integrating and utilizing Smartsupp effectively within your projects.

## Features

- Full support for the powerful Smartsupp widget
- Identify visitor with name, email and phone number, add custom variables
- Get update on incoming messages, account status

## Compatibility

Smartsupp for iOS is compatible with iOS 15 and later. The sample app demonstrates how to integrate it into both SwiftUI and UIKit applications.

![SDK Preview](/Docs/readme-illustration.png)

# Installation

## Swift Package Manager

Add `https://github.com/smartsupp/smartsupp-sdk-ios` as a Swift Package Repository in Xcode and follow the instructions to add Smartsupp as a Swift Package.

If you use `Package.swift` file, just add the package like this:

```swift
dependencies: [
    .package(url: "https://github.com/smartsupp/smartsupp-sdk-ios", .upToNextMajor(from: "1.0.0"))
]
```

# Documentation

For more information on how to use this SDK, visit the official [documentation](https://docs.smartsupp.com/mobile-sdk/).