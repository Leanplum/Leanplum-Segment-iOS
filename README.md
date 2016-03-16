# Leanplum Segment Integration for iOS

A Segment integration for the Leanplum iOS SDK.

## Installation
To install the Leanplum Segment integration, simply add this line to your
[CocoaPods](https://cocoapods.org) Podfile:

`pod install LeanplumSegment`

## Usage

Add the following lines to your AppDelegate or Controller:

```objc
#import <LeanplumSegment/SEGLeanplumIntegrationFactory.h>

[...]

@implementation AppDelegate

NSString *const SEGMENT_WRITE_KEY = @" ... ";

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

  SEGAnalyticsConfiguration *config =
      [SEGAnalyticsConfiguration configurationWithWriteKey:SEGMENT_WRITE_KEY];
  [config use:[SEGLeanplumIntegrationFactory instance]];
  [SEGAnalytics setupWithConfiguration:config];

  return YES;
}
```

Now you can use Segment as you are used to, e.g.:

```objc
[[SEGAnalytics sharedAnalytics] track:@" ... "];
```

In addition to that you can also use the advanced features of Leanplum, e.g.:

```objc
[Leanplum onVariablesChanged:^{
    ...
}];
```

## Example
We have included a sample application.

1. To run the sample app `open LeanplumSegment.xcworkspace`
2. Choose & run target `LeanplumSegment_Example`

## Tests
We have included unit tests for the integration.

1. To run the unit tests `open LeanplumSegment.xcworkspace`
2. Choose & test target `LeanplumSegment_Tests`

## License

See LICENSE file.
