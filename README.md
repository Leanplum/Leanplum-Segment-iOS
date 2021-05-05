![Leanplum - ](Leanplum.svg)

<p align="center">
<img src="https://img.shields.io/badge/platform-iOS-blue.svg?style=flat" alt="Platform iOS" />
<a href="https://cocoapods.org/pods/LeanplumSegment"><img src="https://img.shields.io/cocoapods/v/LeanplumSegment.svg?style=flat" alt="CocoaPods compatible" /></a>
</p>

# Leanplum Segment Integration for iOS
Leanplum SDK integration for the Segment iOS SDK.

## Installation
To install the Leanplum Segment integration, simply add this line to your
[CocoaPods](https://cocoapods.org) Podfile:
```ruby
pod 'LeanplumSegment', '~> 1.1.3'
```
or add this line to your Cartfile if you are using [Carthage](https://github.com/Carthage):
```ruby
github "Leanplum/LeanplumSegment"
```
That's it! Now you can use the Segment SDK and also the [advanced features](https://www.leanplum.com/docs#/docs) of the Leanplum SDK.

## Usage
Import the LeanplumSegment integration:
```objc
#import <LeanplumSegment/SEGLeanplumIntegrationFactory.h>
```
Add the following lines to your AppDelegate:
```objc
NSString *const SEGMENT_WRITE_KEY = @" ... ";
SEGAnalyticsConfiguration *config =
    [SEGAnalyticsConfiguration configurationWithWriteKey:SEGMENT_WRITE_KEY];
[config use:[SEGLeanplumIntegrationFactory instance]];
[SEGAnalytics setupWithConfiguration:config];
```
Now you can use Segment as you are used to, e.g.:
```objc
[[SEGAnalytics sharedAnalytics] track:@" ... "];
```

Note: There is no need to explicitly call Leanplum.start, as it is called within the LeanplumIntegration.

In addition to that you can also use the advanced features of Leanplum. Once the 
Leanplum SDK is successfully registered, Segement posts a NSNotification, hence register to it:
```objc
- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
[...]
  [[NSNotificationCenter defaultCenter]
      addObserver:self
         selector:@selector(segmentIntegrationDidStart)
             name:SEGAnalyticsIntegrationDidStart
           object:LPLeanplumSegmentKey];
}

- (void)segmentIntegrationDidStart {
  [Leanplum onVariablesChanged:^{
      [...]
  }];
}
```

## Example
We have included a sample application.

1. Install CocoaPods in Example Project: `cd Example && pod install`
2. To run the sample app `open LeanplumSegment.xcworkspace`
3. Choose & run target `LeanplumSegment_Example`

## Tests
We have included unit tests for the integration.

1. To run the unit tests `open LeanplumSegment.xcworkspace`
2. Choose & test target `LeanplumSegment_Tests`

## Install Specific Version of SDK's
By default this integration pulls in the latest versions of the Leanplum SDK and the Segment SDK. If you rather want to use a specific version, simply specify the required versions in your podfile directly.
```ruby
pod 'Analytics', '3.0.1'
pod 'Leanplum-iOS-SDK', '1.2.23'
```
## Deploy to CocoaPods
1. Update the version in the sdk-version.txt file
2. Run `make deploy`. 

It will *update the version* in the header files, *commit*, *tag* and try to *publish* to CocoaPods.

*Publish to CocoaPods (Caution, once published cannot be undone!)*

The publishing is done automatically when `make deploy` is run, using `pod trunk push LeanplumSegment.podspec --allow-warnings` called in `push.sh`.
You need admin trunk session in order to publish. New session is started using `$ pod trunk register`.

## License
See LICENSE file.
