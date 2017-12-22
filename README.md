# Accedo One SDK for iOS and tvOS

```
   _                    _           ___
  /_\   ___ ___ ___  __| | ___     /___\_ __   ___
 //_\\ / __/ __/ _ \/ _` |/ _ \   //  // '_ \ / _ \
/  _  \ (_| (_|  __/ (_| | (_) | / \_//| | | |  __/
\_/ \_/\___\___\___|\__,_|\___/  \___/ |_| |_|\___|

```

## Summary

This is the official [Accedo One](https://www.accedo.tv/one) SDK for iOS 9.0 and tvOS 9.0 and up, previously known as the VDK AppGridService component.
While Accedo One exposes a set of friendly REST APIs, this SDK is intended to provide a smoother experience when coding on Apple platforms, providing seamless async services, with automatic caching.


Check the [change log](./CHANGELOG.md) for a listing of changes and new features per version.

## Features

The SDK allows creating a client instance tied to a guid (device id) and an application key. It provides the following features :
 - Easy access to Accedo One APIs.
 - Automatic session creation and re-creation.
 - Automatic disk-caching for Control related data.
 - Disk-cache auto-verified with if-modified-since calls whenever needed.
 - Automatic and seamless fallback to cache versions of Control calls, whenever there's a service outage. 
 - Automatic pagination support for Publish calls.

## Documentation

Coming soon!

You may also want to refer to the [Accedo One Rest API documentation](https://developer.one.accedo.tv/) that this SDK uses behind the scenes.

## Usage

For cocoapods based projects:

platform :ios, "9.0"
use_frameworks!
target "YourAccedoOneApp" do
	pod "AccedoOne/iOS"
end

platform :tvos, "9.0"
use_frameworks!
target "YourAccedoOneApp" do
	pod "AccedoOne/tvOS"
end

or you can drop the AccedoOne SDK in your project as a .framework

## Examples
Below are a few examples on how to access certain parts of Accedo One via this SDK.


The SDK provides you with async calls for almost every API it exposes. 


Example:

@import AccedoOneiOS;

```
	//Initialization
	NSString * apparidURL = @"https://appgrid-api.cloud.accedo.tv/";
    NSString * apparidKey = @"APP_KEY";
	NSString * uuid = @"UUID";
    AccedoOne * accedoOneService = [[AccedoOne alloc] initWithURL:apparidURL appKey:apparidKey userID:uuid];
    
    [accedoOneService allMetadata:^(NSDictionary * _Nonnull allMetadata, AOError * _Nonnull err) {
        NSLog(@"allMetadata: %@", allMetadata);
    }];
    
    
```

### Publish example

```
    [accedoOneService allEntries:^(AOPageResult * _Nonnull result, AOError * _Nonnull err) {
        NSLog(@"allEntries: %@",result.content); 
    }];
	
```

## More information & Links

* [Accedo One homepage](https://www.accedo.tv/one)
* [Accedo One help center](https://support.one.accedo.tv)
* [Accedo One API documentation](https://developer.one.accedo.tv)

## Unit Tests

UnitTests have been written to cover most of the exported APIs from this module.

## License

See the [LICENSE file](./LICENSE.md) for license rights and limitations (Apache 2.0)
