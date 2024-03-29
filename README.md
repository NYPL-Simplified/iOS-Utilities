[![Build and Unit Tests](https://github.com/NYPL-Simplified/iOS-Utilities/actions/workflows/unit-testing.yml/badge.svg)](https://github.com/NYPL-Simplified/iOS-Utilities/actions/workflows/unit-testing.yml)
 [![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

# Simplified iOS Utilities

This is a collection of utilities used at NYPL in the [Simplified](https://github.com/NYPL-Simplified) suite of products and code bases for iOS.

## Objectives

- Generality: the classes and functions should be general-purpose enough to be used independently of the product they are used in.
- Absolutely no third party dependencies: we want to be able to use this module anywhere without any additional requirements.
- Testability: every utility should be easily unit-testable.

## Requirements

- Xcode 13
- iOS 11+
- Swift 5

## Integration

The only supported way for integrating this project is by using Swift Package Manager. The Xcode project is deprecated.

## License

This code is available under the Apache License, Version 2.0. See the [LICENSE](LICENSE) file for more info.
