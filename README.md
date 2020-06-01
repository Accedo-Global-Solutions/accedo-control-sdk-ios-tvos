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

## Usage

For cocoapods based projects:

platform :ios, "9.0"
use_frameworks!
target "YourAccedoOneApp" do
	pod "AccedoOneiOS"
end

platform :tvos, "9.0"
use_frameworks!
target "YourAccedoOneApp" do
	pod "AccedoOnetvOS"
end

or you can drop the AccedoOne SDK in your project as a .framework

## Documentation

# Session Management

## Session Creation

To create a session a service instance object needs to be created. This is the starting point for any communication with Accedo One APIs. You need the following parameters to succesfully create a session with the Accedo One APIs.

| Parameter       | Explanation                              |
| --------------- | ---------------------------------------- |
| API Access URL  | Endpoint used for all communication with Accedo One API:  https://api.one.accedo.tv/ |
| Application Key | Every application has a unique identifier called Application Key or AppKey. This key is mainly used as an authentication parameter during session creation to uniquely identify the application the session is to be bound to. |
| UUID            | (Universally Unique Identifier) - An application/service specific ID that is used to identify a unique device. Any given device should use one and only one UUID for all the requests it sends to Accedo One, no matter which application key it is using. Two different devices must have two different UUIDs (meaning UUIDs should not be shared between devices). |

## Session Expiration

The API keeps track of the session expiration time and re-creates the session automatically if needed. 

## Caching

The API also takes care of the necessary **If-Modified-Since** header fields to allow reduction of traffic and processing power required to parse new values, which will lead to a better end-user experience.

The API supports offline caching, if the Accedo One API is offline it returns the last available response data from an offline cache.

### Example

```objective-c
	NSString * apparidURL = @"https://appgrid-api.cloud.accedo.tv/";
    NSString * apparidKey = @"";
    NSBundle * bundleId = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleIdentifier"];
    NSString * uuid       = [NSString stringWithFormat:@"%@.UUID", bundleId ? bundleId : @"tv.accedo.AppgridSDK" ];
    AccedoOne * accedoOne = [[AccedoOne alloc] initWithURL:apparidURL appKey:apparidKey userID:uuid];
```

```swift
	let apparidURL:String = "https://appgrid-api.cloud.accedo.tv/";
	let apparidKey:String = "";
	let uuid: String = String(format: "%@.UUID", Bundle.main.infoDictionary?["CFBundleIdentifier"] as! CVarArg)
	let accedoOne:AccedoOne = AccedoOne(url: apparidURL, appKey: apparidKey, userID: uuid);
```



# Accedo Control

## Application Status 

Applications can query for their status, which is defined within the Admin UI. Applications can be in either "Active" or "Maintenance" states. When the application is in a maintenance state, a message (editorial) is returned by this endpoint, which could be used to notify end-users about temporary disturbances in the service.

### Example

```objective-c
[accedoOne applicationStatus:^(NSString * _Nullable status, NSString * _Nullable message, AOError * _Nullable err) {
	NSLog(@"STATUS: %@ MESSAGE: %@ ERR: %@", status, message,err);
}];
```

```swift
accedoOne .applicationStatus { (status, message, err) in
	print("Status: \(String(describing: status)) Message: \(String(describing: message)) Error:\(String(describing: err))\n");
}
```



## Get Profile Information

This method can be used to query for information about which profile your device and application is matching right now.

### Example

```objective-c
[accedoOne profileInfo:^(NSDictionary * _Nullable profileInfo, AOError * _Nullable err) {
	NSLog(@"%@, err: %@", profileInfo, err);
}];
```

```swift
accedoOne.profileInfo { (info, err) in
	print("Info:\(String(describing: info))\n")
}
```



## Get All Metadata

Get all available metadata entries based on active profile or whitelist override. Metadata response structure depends on the value type configured in Admin UI. Repeatable entries are wrapped in the JSON Array.

### Example

```objective-c
[accedoOne allMetadata:^(NSDictionary * _Nullable allMetadata, AOError * _Nullable err) {
	NSLog(@"%@, err: %@", allMetadata, err);
}];
```

```swift
accedoOne.allMetadata { (metadata, err) in
	print("Metadata:\(String(describing: metadata)) Err: \(String(describing: err))")
}
```

## Get Metadata By Single Key

Applications with complex metadata structure often need only one key for a specific action. 

### Example

```objective-c
[accedoOne metadataForKey:@"key" onComplete:^(id  _Nullable metadata, AOError * _Nullable err) {
	NSLog(@"%@, err: %@", metadata, err);
}];
```

```swift
accedoOne.metadata(forKey: "key") { (metadata, err) in
	print("Metadata:\(String(describing: metadata)) Err: \(String(describing: err))")
}
```

## Get Metadata By Multiple Keys

### Example

```objective-c
[accedoOne metadataForKeys:@[@"key1", @"key2"] gid:nil onComplete:^(id  _Nullable metadata, AOError * _Nullable err) {
	NSLog(@"%@, err: %@", metadata, err);
}];
```

```swift
accedoOne.metadata(forKeys: ["key1", "key2"], gid: nil) { (metadata, err) in
	print("Metadata:\(String(describing: metadata)) Err: \(String(describing: err))")
}
```

## List All Assets

This method is used for listing assets available to the application. It returns a list of assets available in the format of key-url values. 

### Example

```objective-c
[accedoOne allAssets:^(NSDictionary * _Nullable assetsMetadata, AOError * _Nullable err) {
	NSLog(@"Assets: %@, err: %@", assetsMetadata, err);
}];
```

```swift
accedoOne.allAssets { (assets, err) in
	print("Assets:\(String(describing: assets)) Err: \(String(describing: err))")
}
```



# Accedo Publish

A Content Entry is based on an Entry Type (defined in the Admin interface). Entries contain a number of fields, which have generic or platform-specific values.

## Get All Entries

Get all Entries that are published on the Platform your Application is on, in a paginated list. The Entries in the list are ordered by most recently published first by default. The response is paginated with size and offset.

### Example
```objective-c
[accedoOne allEntries:^(AOPageResult * _Nullable result, AOError * _Nullable err) {
	NSLog(@"%@ Error: %@", result.content, err);    
}];
/* or */
AOCMSOptionalParams * params = [[AOCMSOptionalParams params] paramWithPageSize:@(30)];
[accedoOne allEntriesForParams:params onComplete:^(AOPageResult * _Nullable result, AOError * _Nullable err) {
	NSLog(@"%d", result.content.count);
}];
```
```swift
accedoOne.allEntries { (result, err) in
	print("Entries:\(String(describing: result?.content)) Err: \(String(describing: err))")
}
/* or */
let params = AOCMSOptionalParams().param(withPageSize: 30);
accedoOne.allEntries(for: params) { (result, err) in
	print("Entries:\(String(describing: result?.content)) Err: \(String(describing: err))")
}
```



## Get Entry by Entry ID

Get a single Entry by requesting a single Entry ID
### Example
```objective-c
[accedoOne entryForId:@"entryid" onComplete:^(NSDictionary * _Nullable entry, AOError * _Nullable err) {
	NSLog(@"%@ Error: %@", err);
}];
```

```swift
accedoOne.entry(forId: "entryid") { (entry, err) in
            
}
```



## Get Entries by Multiple Entry IDs

Get several Entries by passing in a comma-separated list of Entry IDs as a request parameter. The entries in the response will be in the same order as the IDs sent in. The response is paginated with size and offset.
### Example
```objective-c
[accedoOne entriesForIds:@[@"id1", @"id2"] onComplete:^(NSArray * _Nullable entries, AOError * _Nullable err) {
       
}];
/* or */
AOCMSOptionalParams * params = [[[AOCMSOptionalParams params] paramWithPageSize:@(30)] paramWithOffset:10];
[accedoOne entriesForIds:@[@"id1", @"id2"] optionalParams:params onComplete:^(NSArray * _Nullable entries, AOError * _Nullable err) {
        
}];
```

```swift
accedoOne.entries(forIds: ["id1", "id2"]) { (entries, err) in
            
}
/* or */
let params = AOCMSOptionalParams().param(withPageSize: 30);accedoOne.entries(forIds: ["id1", "id2"], optionalParams: params) { (entries, err) in
            
}
```
## Get Entries by Multiple Entry Aliases

Get several Entries by passing in a list of Entry Aliases as a request parameter. The entries in the response will be in the same order as the IDs sent in. The query is paginated with offset and size.
### Example
```objective-c
[accedoOne entriesForAliases:@[@"alias1", @"alias2"] onComplete:^(NSArray * _Nullable entries, AOError * _Nullable err) {
        
}];
/* or */   
AOCMSOptionalParams * params = [[AOCMSOptionalParams params] paramWithPageSize:@(30)];
[accedoOne entriesForAliases:@[@"alias1", @"alias2"] optionalParams:params onComplete:^(NSArray * _Nullable entries, AOError * _Nullable err) {
        
}];
```

```swift
accedoOne.entries(forAliases: ["alias1", "alias2"]) { (entries, err) in
}

/* or */

let params = AOCMSOptionalParams().param(withPageSize: 30);
accedoOne.entries(forAliases: ["alias1", "alias2"], optionalParams: params) { (entries, err) in
            
}
```
## Get Entries by Type ID

Get a list of Entries by passing in one or several (comma-separated) Entry Type ID(s) as a request parameter. The entries in the list are ordered by most recently published first. If preview is set to true the entries will be ordered by last modified first. The query is paginated with offset and size.
### Example
```objective-c
[accedoOne entriesForType:@"type" onComplete:^(AOPageResult * _Nullable result, AOError * _Nullable err) {
        
}];
```

```swift
accedoOne.entries(forType: "type") { (entries, err) in
            
}
```
## Get Entries by Type Alias

Get a list of Entries by passing in an Entry Type Alias as a request parameter. The entries in the list are ordered by most recently published first. If preview is set to true the entries will be ordered by last modified first. The query is paginated with offset and size.
### Example
```objective-c
[accedoOne entriesForTypeAlias:@"the" onComplete:^(NSArray * _Nullable entries, AOError * _Nullable err) {
        
}];
/* or */    
AOCMSOptionalParams * params = [[AOCMSOptionalParams params] paramWithPageSize:@(30)];
[accedoOne entriesForTypeAlias:@"the" optionalParams:params onComplete:^(NSArray * _Nullable entries, AOError * _Nullable err) {
        
}];
```

```swift
accedoOne.entries(forAliases: ["alias1", "alias2"]) { (entries, err) in
         
}
/* or */
let params = AOCMSOptionalParams().param(withPageSize: 30);
accedoOne.entries(forAliases: ["alias1", "alias2"], optionalParams: params) { (entries, err) in
            
}
```
## Get Available Locales

This endpoint is used to get all available locales for the Organization.
### Example
```objective-c
[accedoOne localesOnComplete:^(NSArray * _Nullable locales, AOError * _Nullable err) {
	NSLog(@"%@ Error: %@", err);
}];
```

```swift
accedoOne.locales { (result, err) in
    print("Locales:\(String(describing: result)) Err: \(String(describing: err))")
}
```
# Accedo Detect

Applications can send so called application logs to the Accedo One API in order to capture any kind of error happening within the application during runtime.

The following log levels are supported: *error*, *warn*, *info* and *debug*.
## Send single Application Log

This method provides the ability to post a log message to Accedo One which could be used for error reporting and troubleshooting.
### Example
```objective-c
[accedoOne logWithLevel:AOServiceLogLevelWarn code:1000 message:@"test" dimensions:Nil];
```

```swift
accedoOne.log(with: AOServiceLogLevel.debug, code: 1000, message: "this is a log message", dimensions: nil);
```
# Accedo Insight

Applications can send information to the Accedo One API about when they are started and when they are exited by the end user. This functionality is exposed in Accedo One from the event logging endpoint described below and the metrics are available through the Analytics reports in the Admin UI.

## Send an Application Start event

A `START` event should be fired as soon as the application either starts or resumes (from having been in the background).
### Example
```objective-c
[accedoOne applicationStart];
```

```swift
accedoOne.applicationStart();
```
## Send and Application Quit event

A `QUIT` event should be fired as soon as the application is killed or when it is put into the background.
### Example
```objective-c
[accedoOne applicationStop];
```

```swift
accedoOne.applicationStop();
```


# User Data Management

Applications may want to manage user-specific information through the API. There are many use-cases for this functionality, ranging from application preferences to playlists, favorites, etc.

User Data can be stored on either the *Application Scope* or the *Application Group scope*, which means that User Data can be stored either for a single Application (such as the iOS Application) or be shared across all Applications in the Application Group (across Platforms and Applications).

User data is stored as a set of key-value pairs, very much like Application Metadata but is not constrained by the configuration specified through Admin UI. This means that it is not possible to specify which keys must be set nor constrain the type of data (Booleans, Strings, Numbers, Objects) for each value.

## Get User Data

Get all of the user’s data stored uniquely for this application or application group. Data is returned in the form of a JSON object with Key-Value pairs.

| Parameters |                                          |
| ---------- | ---------------------------------------- |
| user id    | Specifies the user id the data is belonging to. |
| scope      | Specifies the scope of the user data (Application or Application Group) |

### Example

```objective-c
/* For Application Group scope please use AOUserDataScopeApplicationGroup */
[accedoOne allDataForUser:@"uid" scope:AOUserDataScopeApplication onComplete:^(NSDictionary * _Nullable userData, AOError * _Nullable err) {
        
}];
```

```swift
/* For Application Group scope please use AOUserDataScope.applicationGroup */
accedoOne.allData(forUser: "userid", scope: AOUserDataScope.application) { (data, err) in
}
```
## Get User Data by Key

Get a user’s data for a single key stored on the application or application group level.



| Parameters |                                                              |
| ---------- | ------------------------------------------------------------ |
| user id    | Specifies the user id the data is belonging to.              |
| scope      | Specifies the scope of the user data (Application or Application Group) |
| key        | the key the data will be read from                           |

### Example
```objective-c
/* For Application Group scope please use AOUserDataScopeApplicationGroup */
[accedoOne dataForUser:@"userid" key:@"key" scope:AOUserDataScopeApplication onComplete:^(NSString * _Nullable value, AOError * _Nullable err) {
        
}];
```

```swift
/* For Application Group scope please use AOUserDataScope.applicationGroup */
accedoOne.data(forUser: "userid", key: "key", scope: AOUserDataScope.application) { (data, err) in
            
}
```

## Store User Data
Set and overwrite any existing data for the user. This data is stored in application or application group scope.Caution: This method does not simply replace conflicting keys. All user data will be replaced by the information provided in the request - if the request does not contain a key - data saved for that key will be lost.

| Parameters |                                          |
| ---------- | ---------------------------------------- |
| user id    | Specifies the user id the data is belonging to. |
| scope      | Specifies the scope of the user data (Application or Application Group) |

### Example

```objective-c
/* For Application Group scope please use AOUserDataScopeApplicationGroup */
[accedoOne storeData:@{} forUser:@"userid" scope:AOUserDataScopeApplication onComplete:^(AOError * _Nullable err) {
}];
```

```swift
/* For Application Group scope please use AOUserDataScope.applicationGroup */
accedoOne.storeData([:], forUser: "userid", scope: AOUserDataScope.application) { (err) in
}
```


## Store User Data by Key

Set data for the user for a specified key on the application or application group level.

| Parameters |                                                              |
| ---------- | ------------------------------------------------------------ |
| user id    | Specifies the user id the data is belonging to.              |
| scope      | Specifies the scope of the user data (Application or Application Group) |
| key        | the key the data will be stored to                           |

### Example
```objective-c
/* For Application Group scope please use AOUserDataScopeApplicationGroup */
[accedoOne storeValue:@"value" key:@"key" forUser:@"userid" scope:AOUserDataScopeApplication onComplete:^(AOError * _Nullable err) {
        
}];
```

```swift
/* For Application Group scope please use AOUserDataScope.applicationGroup */
accedoOne.storeValue("value", key: "key", forUser: "userid", scope: AOUserDataScope.application) { (err) in
            
}
```

You may also want to refer to the [Accedo One Rest API documentation](https://developer.one.accedo.tv/) that this SDK uses behind the scenes.

## More information & Links

* [Accedo One homepage](https://www.accedo.tv/one)
* [Accedo One help center](https://support.one.accedo.tv)
* [Accedo One API documentation](https://developer.one.accedo.tv)

## Unit Tests

UnitTests have been written to cover most of the exported APIs from this module.

## License

See the [LICENSE file](./LICENSE.md) for license rights and limitations (Apache 2.0)vx`
