// Namespaced Header

#ifndef __NS_SYMBOL
// We need to have multiple levels of macros here so that __NAMESPACE_PREFIX_ is
// properly replaced by the time we concatenate the namespace prefix.
#define __NS_REWRITE(ns, symbol) ns ## _ ## symbol
#define __NS_BRIDGE(ns, symbol) __NS_REWRITE(ns, symbol)
#define __NS_SYMBOL(symbol) __NS_BRIDGE(AGR, symbol)
#endif


// Classes
#ifndef AFActivityIndicatorViewNotificationObserver
#define AFActivityIndicatorViewNotificationObserver __NS_SYMBOL(AFActivityIndicatorViewNotificationObserver)
#endif

#ifndef AFAutoPurgingImageCache
#define AFAutoPurgingImageCache __NS_SYMBOL(AFAutoPurgingImageCache)
#endif

#ifndef AFCachedImage
#define AFCachedImage __NS_SYMBOL(AFCachedImage)
#endif

#ifndef AFCompoundResponseSerializer
#define AFCompoundResponseSerializer __NS_SYMBOL(AFCompoundResponseSerializer)
#endif

#ifndef AFHTTPBodyPart
#define AFHTTPBodyPart __NS_SYMBOL(AFHTTPBodyPart)
#endif

#ifndef AFHTTPRequestSerializer
#define AFHTTPRequestSerializer __NS_SYMBOL(AFHTTPRequestSerializer)
#endif

#ifndef AFHTTPResponseSerializer
#define AFHTTPResponseSerializer __NS_SYMBOL(AFHTTPResponseSerializer)
#endif

#ifndef AFHTTPSessionManager
#define AFHTTPSessionManager __NS_SYMBOL(AFHTTPSessionManager)
#endif

#ifndef AFImageDownloadReceipt
#define AFImageDownloadReceipt __NS_SYMBOL(AFImageDownloadReceipt)
#endif

#ifndef AFImageDownloader
#define AFImageDownloader __NS_SYMBOL(AFImageDownloader)
#endif

#ifndef AFImageDownloaderMergedTask
#define AFImageDownloaderMergedTask __NS_SYMBOL(AFImageDownloaderMergedTask)
#endif

#ifndef AFImageDownloaderResponseHandler
#define AFImageDownloaderResponseHandler __NS_SYMBOL(AFImageDownloaderResponseHandler)
#endif

#ifndef AFImageResponseSerializer
#define AFImageResponseSerializer __NS_SYMBOL(AFImageResponseSerializer)
#endif

#ifndef AFJSONRequestSerializer
#define AFJSONRequestSerializer __NS_SYMBOL(AFJSONRequestSerializer)
#endif

#ifndef AFJSONResponseSerializer
#define AFJSONResponseSerializer __NS_SYMBOL(AFJSONResponseSerializer)
#endif

#ifndef AFMultipartBodyStream
#define AFMultipartBodyStream __NS_SYMBOL(AFMultipartBodyStream)
#endif

#ifndef AFNetworkActivityIndicatorManager
#define AFNetworkActivityIndicatorManager __NS_SYMBOL(AFNetworkActivityIndicatorManager)
#endif

#ifndef AFNetworkReachabilityManager
#define AFNetworkReachabilityManager __NS_SYMBOL(AFNetworkReachabilityManager)
#endif

#ifndef AFPropertyListRequestSerializer
#define AFPropertyListRequestSerializer __NS_SYMBOL(AFPropertyListRequestSerializer)
#endif

#ifndef AFPropertyListResponseSerializer
#define AFPropertyListResponseSerializer __NS_SYMBOL(AFPropertyListResponseSerializer)
#endif

#ifndef AFQueryStringPair
#define AFQueryStringPair __NS_SYMBOL(AFQueryStringPair)
#endif

#ifndef AFRefreshControlNotificationObserver
#define AFRefreshControlNotificationObserver __NS_SYMBOL(AFRefreshControlNotificationObserver)
#endif

#ifndef AFSecurityPolicy
#define AFSecurityPolicy __NS_SYMBOL(AFSecurityPolicy)
#endif

#ifndef AFStreamingMultipartFormData
#define AFStreamingMultipartFormData __NS_SYMBOL(AFStreamingMultipartFormData)
#endif

#ifndef AFURLSessionManager
#define AFURLSessionManager __NS_SYMBOL(AFURLSessionManager)
#endif

#ifndef AFURLSessionManagerTaskDelegate
#define AFURLSessionManagerTaskDelegate __NS_SYMBOL(AFURLSessionManagerTaskDelegate)
#endif

#ifndef AFXMLParserResponseSerializer
#define AFXMLParserResponseSerializer __NS_SYMBOL(AFXMLParserResponseSerializer)
#endif

#ifndef PodsDummy_AFNetworking
#define PodsDummy_AFNetworking __NS_SYMBOL(PodsDummy_AFNetworking)
#endif

#ifndef WKWebView
#define WKWebView __NS_SYMBOL(WKWebView)
#endif

#ifndef _AFURLSessionTaskSwizzling
#define _AFURLSessionTaskSwizzling __NS_SYMBOL(_AFURLSessionTaskSwizzling)
#endif

// Functions
#ifndef AFJSONObjectByRemovingKeysWithNullValues
#define AFJSONObjectByRemovingKeysWithNullValues __NS_SYMBOL(AFJSONObjectByRemovingKeysWithNullValues)
#endif

#ifndef AFPercentEscapedStringFromString
#define AFPercentEscapedStringFromString __NS_SYMBOL(AFPercentEscapedStringFromString)
#endif

#ifndef AFStringFromNetworkReachabilityStatus
#define AFStringFromNetworkReachabilityStatus __NS_SYMBOL(AFStringFromNetworkReachabilityStatus)
#endif

#ifndef __copy_helper_block_e8_
#define __copy_helper_block_e8_ __NS_SYMBOL(__copy_helper_block_e8_)
#endif

#ifndef __destroy_helper_block_e8_
#define __destroy_helper_block_e8_ __NS_SYMBOL(__destroy_helper_block_e8_)
#endif

#ifndef __copy_helper_block_e8_
#define __copy_helper_block_e8_ __NS_SYMBOL(__copy_helper_block_e8_)
#endif

#ifndef __destroy_helper_block_e8_
#define __destroy_helper_block_e8_ __NS_SYMBOL(__destroy_helper_block_e8_)
#endif

#ifndef __copy_helper_block_e8_32s
#define __copy_helper_block_e8_32s __NS_SYMBOL(__copy_helper_block_e8_32s)
#endif

#ifndef __copy_helper_block_e8_32s
#define __copy_helper_block_e8_32s __NS_SYMBOL(__copy_helper_block_e8_32s)
#endif

#ifndef __destroy_helper_block_e8_32s
#define __destroy_helper_block_e8_32s __NS_SYMBOL(__destroy_helper_block_e8_32s)
#endif

#ifndef __destroy_helper_block_e8_32s
#define __destroy_helper_block_e8_32s __NS_SYMBOL(__destroy_helper_block_e8_32s)
#endif

#ifndef AFQueryStringFromParameters
#define AFQueryStringFromParameters __NS_SYMBOL(AFQueryStringFromParameters)
#endif

#ifndef __copy_helper_block_e8_32w
#define __copy_helper_block_e8_32w __NS_SYMBOL(__copy_helper_block_e8_32w)
#endif

#ifndef __copy_helper_block_e8_32b
#define __copy_helper_block_e8_32b __NS_SYMBOL(__copy_helper_block_e8_32b)
#endif

#ifndef __destroy_helper_block_e8_32w
#define __destroy_helper_block_e8_32w __NS_SYMBOL(__destroy_helper_block_e8_32w)
#endif

#ifndef __copy_helper_block_e8_32s
#define __copy_helper_block_e8_32s __NS_SYMBOL(__copy_helper_block_e8_32s)
#endif

#ifndef __destroy_helper_block_e8_32s
#define __destroy_helper_block_e8_32s __NS_SYMBOL(__destroy_helper_block_e8_32s)
#endif

#ifndef __destroy_helper_block_e8_32s
#define __destroy_helper_block_e8_32s __NS_SYMBOL(__destroy_helper_block_e8_32s)
#endif

#ifndef AFQueryStringPairsFromDictionary
#define AFQueryStringPairsFromDictionary __NS_SYMBOL(AFQueryStringPairsFromDictionary)
#endif

#ifndef __copy_helper_block_e8_32s40s
#define __copy_helper_block_e8_32s40s __NS_SYMBOL(__copy_helper_block_e8_32s40s)
#endif

#ifndef AFQueryStringPairsFromKeyAndValue
#define AFQueryStringPairsFromKeyAndValue __NS_SYMBOL(AFQueryStringPairsFromKeyAndValue)
#endif

#ifndef __copy_helper_block_e8_32s40r
#define __copy_helper_block_e8_32s40r __NS_SYMBOL(__copy_helper_block_e8_32s40r)
#endif

#ifndef __destroy_helper_block_e8_32s40s
#define __destroy_helper_block_e8_32s40s __NS_SYMBOL(__destroy_helper_block_e8_32s40s)
#endif

#ifndef __copy_helper_block_e8_32w
#define __copy_helper_block_e8_32w __NS_SYMBOL(__copy_helper_block_e8_32w)
#endif

#ifndef __copy_helper_block_e8_32s40b48w
#define __copy_helper_block_e8_32s40b48w __NS_SYMBOL(__copy_helper_block_e8_32s40b48w)
#endif

#ifndef __destroy_helper_block_e8_32s40r
#define __destroy_helper_block_e8_32s40r __NS_SYMBOL(__destroy_helper_block_e8_32s40r)
#endif

#ifndef __destroy_helper_block_e8_32w
#define __destroy_helper_block_e8_32w __NS_SYMBOL(__destroy_helper_block_e8_32w)
#endif

#ifndef __destroy_helper_block_e8_32s40s48w
#define __destroy_helper_block_e8_32s40s48w __NS_SYMBOL(__destroy_helper_block_e8_32s40s48w)
#endif

#ifndef __copy_helper_block_e8_32s40b48w
#define __copy_helper_block_e8_32s40b48w __NS_SYMBOL(__copy_helper_block_e8_32s40b48w)
#endif

#ifndef __copy_helper_block_e8_32s40b
#define __copy_helper_block_e8_32s40b __NS_SYMBOL(__copy_helper_block_e8_32s40b)
#endif

#ifndef __destroy_helper_block_e8_32s40s48w
#define __destroy_helper_block_e8_32s40s48w __NS_SYMBOL(__destroy_helper_block_e8_32s40s48w)
#endif

#ifndef __destroy_helper_block_e8_32s40s
#define __destroy_helper_block_e8_32s40s __NS_SYMBOL(__destroy_helper_block_e8_32s40s)
#endif

#ifndef __copy_helper_block_e8_32b
#define __copy_helper_block_e8_32b __NS_SYMBOL(__copy_helper_block_e8_32b)
#endif

#ifndef __destroy_helper_block_e8_32s
#define __destroy_helper_block_e8_32s __NS_SYMBOL(__destroy_helper_block_e8_32s)
#endif

#ifndef __copy_helper_block_e8_32s40s48s
#define __copy_helper_block_e8_32s40s48s __NS_SYMBOL(__copy_helper_block_e8_32s40s48s)
#endif

#ifndef __destroy_helper_block_e8_32s40s48s
#define __destroy_helper_block_e8_32s40s48s __NS_SYMBOL(__destroy_helper_block_e8_32s40s48s)
#endif

#ifndef __copy_helper_block_e8_
#define __copy_helper_block_e8_ __NS_SYMBOL(__copy_helper_block_e8_)
#endif

#ifndef __destroy_helper_block_e8_
#define __destroy_helper_block_e8_ __NS_SYMBOL(__destroy_helper_block_e8_)
#endif

#ifndef __copy_helper_block_e8_32b
#define __copy_helper_block_e8_32b __NS_SYMBOL(__copy_helper_block_e8_32b)
#endif

#ifndef __copy_helper_block_e8_32b40b48s56s64s72s80s88r
#define __copy_helper_block_e8_32b40b48s56s64s72s80s88r __NS_SYMBOL(__copy_helper_block_e8_32b40b48s56s64s72s80s88r)
#endif

#ifndef __destroy_helper_block_e8_32s
#define __destroy_helper_block_e8_32s __NS_SYMBOL(__destroy_helper_block_e8_32s)
#endif

#ifndef __destroy_helper_block_e8_32s40s48s56s64s72s80s88r
#define __destroy_helper_block_e8_32s40s48s56s64s72s80s88r __NS_SYMBOL(__destroy_helper_block_e8_32s40s48s56s64s72s80s88r)
#endif

#ifndef __copy_helper_block_e8_32s
#define __copy_helper_block_e8_32s __NS_SYMBOL(__copy_helper_block_e8_32s)
#endif

#ifndef __destroy_helper_block_e8_32s
#define __destroy_helper_block_e8_32s __NS_SYMBOL(__destroy_helper_block_e8_32s)
#endif

#ifndef __copy_helper_block_e8_32s40s
#define __copy_helper_block_e8_32s40s __NS_SYMBOL(__copy_helper_block_e8_32s40s)
#endif

#ifndef __copy_helper_block_e8_32s40s48r
#define __copy_helper_block_e8_32s40s48r __NS_SYMBOL(__copy_helper_block_e8_32s40s48r)
#endif

#ifndef __destroy_helper_block_e8_32s40s
#define __destroy_helper_block_e8_32s40s __NS_SYMBOL(__destroy_helper_block_e8_32s40s)
#endif

#ifndef __destroy_helper_block_e8_32s40s48r
#define __destroy_helper_block_e8_32s40s48r __NS_SYMBOL(__destroy_helper_block_e8_32s40s48r)
#endif

#ifndef __copy_helper_block_e8_32s40s48s56s64r
#define __copy_helper_block_e8_32s40s48s56s64r __NS_SYMBOL(__copy_helper_block_e8_32s40s48s56s64r)
#endif

#ifndef __destroy_helper_block_e8_32s40s48s56s64r
#define __destroy_helper_block_e8_32s40s48s56s64r __NS_SYMBOL(__destroy_helper_block_e8_32s40s48s56s64r)
#endif

#ifndef __copy_helper_block_e8_32b40s
#define __copy_helper_block_e8_32b40s __NS_SYMBOL(__copy_helper_block_e8_32b40s)
#endif

#ifndef __destroy_helper_block_e8_32s40s
#define __destroy_helper_block_e8_32s40s __NS_SYMBOL(__destroy_helper_block_e8_32s40s)
#endif

#ifndef __copy_helper_block_e8_32b40b48r
#define __copy_helper_block_e8_32b40b48r __NS_SYMBOL(__copy_helper_block_e8_32b40b48r)
#endif

#ifndef __destroy_helper_block_e8_32s40s48r
#define __destroy_helper_block_e8_32s40s48r __NS_SYMBOL(__destroy_helper_block_e8_32s40s48r)
#endif

#ifndef __copy_helper_block_e8_32s40s48s56s64s72r
#define __copy_helper_block_e8_32s40s48s56s64s72r __NS_SYMBOL(__copy_helper_block_e8_32s40s48s56s64s72r)
#endif

#ifndef __copy_helper_block_e8_32s
#define __copy_helper_block_e8_32s __NS_SYMBOL(__copy_helper_block_e8_32s)
#endif

#ifndef __destroy_helper_block_e8_32s
#define __destroy_helper_block_e8_32s __NS_SYMBOL(__destroy_helper_block_e8_32s)
#endif

#ifndef __destroy_helper_block_e8_32s40s48s56s64s72r
#define __destroy_helper_block_e8_32s40s48s56s64s72r __NS_SYMBOL(__destroy_helper_block_e8_32s40s48s56s64s72r)
#endif

#ifndef __copy_helper_block_e8_32b40s48s
#define __copy_helper_block_e8_32b40s48s __NS_SYMBOL(__copy_helper_block_e8_32b40s48s)
#endif

#ifndef __destroy_helper_block_e8_32s40s48s
#define __destroy_helper_block_e8_32s40s48s __NS_SYMBOL(__destroy_helper_block_e8_32s40s48s)
#endif

#ifndef __copy_helper_block_e8_32s40r
#define __copy_helper_block_e8_32s40r __NS_SYMBOL(__copy_helper_block_e8_32s40r)
#endif

#ifndef __destroy_helper_block_e8_32s40r
#define __destroy_helper_block_e8_32s40r __NS_SYMBOL(__destroy_helper_block_e8_32s40r)
#endif

#ifndef __copy_helper_block_e8_32s40s48s
#define __copy_helper_block_e8_32s40s48s __NS_SYMBOL(__copy_helper_block_e8_32s40s48s)
#endif

#ifndef __destroy_helper_block_e8_32s40s48s
#define __destroy_helper_block_e8_32s40s48s __NS_SYMBOL(__destroy_helper_block_e8_32s40s48s)
#endif

#ifndef __copy_helper_block_e8_32s40s48s56s
#define __copy_helper_block_e8_32s40s48s56s __NS_SYMBOL(__copy_helper_block_e8_32s40s48s56s)
#endif

#ifndef __destroy_helper_block_e8_32s40s48s56s
#define __destroy_helper_block_e8_32s40s48s56s __NS_SYMBOL(__destroy_helper_block_e8_32s40s48s56s)
#endif

#ifndef __copy_helper_block_e8_32s40s48r
#define __copy_helper_block_e8_32s40s48r __NS_SYMBOL(__copy_helper_block_e8_32s40s48r)
#endif

#ifndef __destroy_helper_block_e8_32s40s48r
#define __destroy_helper_block_e8_32s40s48r __NS_SYMBOL(__destroy_helper_block_e8_32s40s48r)
#endif

#ifndef __copy_helper_block_e8_32s40s48s56s64s72s80w
#define __copy_helper_block_e8_32s40s48s56s64s72s80w __NS_SYMBOL(__copy_helper_block_e8_32s40s48s56s64s72s80w)
#endif

#ifndef __destroy_helper_block_e8_32s40s48s56s64s72s80w
#define __destroy_helper_block_e8_32s40s48s56s64s72s80w __NS_SYMBOL(__destroy_helper_block_e8_32s40s48s56s64s72s80w)
#endif

#ifndef __copy_helper_block_e8_32s40s48s56s64w
#define __copy_helper_block_e8_32s40s48s56s64w __NS_SYMBOL(__copy_helper_block_e8_32s40s48s56s64w)
#endif

#ifndef __destroy_helper_block_e8_32s40s48s56s64w
#define __destroy_helper_block_e8_32s40s48s56s64w __NS_SYMBOL(__destroy_helper_block_e8_32s40s48s56s64w)
#endif

#ifndef __copy_helper_block_e8_32s40b48s56s64b72r
#define __copy_helper_block_e8_32s40b48s56s64b72r __NS_SYMBOL(__copy_helper_block_e8_32s40b48s56s64b72r)
#endif

#ifndef __destroy_helper_block_e8_32s40s48s56s64s72r
#define __destroy_helper_block_e8_32s40s48s56s64s72r __NS_SYMBOL(__destroy_helper_block_e8_32s40s48s56s64s72r)
#endif

#ifndef __copy_helper_block_e8_32s
#define __copy_helper_block_e8_32s __NS_SYMBOL(__copy_helper_block_e8_32s)
#endif

#ifndef __destroy_helper_block_e8_32s
#define __destroy_helper_block_e8_32s __NS_SYMBOL(__destroy_helper_block_e8_32s)
#endif

#ifndef __copy_helper_block_e8_32s40s48s
#define __copy_helper_block_e8_32s40s48s __NS_SYMBOL(__copy_helper_block_e8_32s40s48s)
#endif

#ifndef __copy_helper_block_e8_32s40s
#define __copy_helper_block_e8_32s40s __NS_SYMBOL(__copy_helper_block_e8_32s40s)
#endif

#ifndef __destroy_helper_block_e8_32s40s
#define __destroy_helper_block_e8_32s40s __NS_SYMBOL(__destroy_helper_block_e8_32s40s)
#endif

#ifndef __copy_helper_block_e8_32s
#define __copy_helper_block_e8_32s __NS_SYMBOL(__copy_helper_block_e8_32s)
#endif

#ifndef __destroy_helper_block_e8_32s
#define __destroy_helper_block_e8_32s __NS_SYMBOL(__destroy_helper_block_e8_32s)
#endif

#ifndef __copy_helper_block_e8_32s40s48r
#define __copy_helper_block_e8_32s40s48r __NS_SYMBOL(__copy_helper_block_e8_32s40s48r)
#endif

#ifndef __destroy_helper_block_e8_32s40s48r
#define __destroy_helper_block_e8_32s40s48r __NS_SYMBOL(__destroy_helper_block_e8_32s40s48r)
#endif

#ifndef __copy_helper_block_e8_32b40r
#define __copy_helper_block_e8_32b40r __NS_SYMBOL(__copy_helper_block_e8_32b40r)
#endif

#ifndef __copy_helper_block_e8_32s40s48b56r
#define __copy_helper_block_e8_32s40s48b56r __NS_SYMBOL(__copy_helper_block_e8_32s40s48b56r)
#endif

#ifndef __destroy_helper_block_e8_32s40s48s56r
#define __destroy_helper_block_e8_32s40s48s56r __NS_SYMBOL(__destroy_helper_block_e8_32s40s48s56r)
#endif

#ifndef __copy_helper_block_e8_32b
#define __copy_helper_block_e8_32b __NS_SYMBOL(__copy_helper_block_e8_32b)
#endif

#ifndef __copy_helper_block_e8_32s40s
#define __copy_helper_block_e8_32s40s __NS_SYMBOL(__copy_helper_block_e8_32s40s)
#endif

#ifndef __destroy_helper_block_e8_32s40s
#define __destroy_helper_block_e8_32s40s __NS_SYMBOL(__destroy_helper_block_e8_32s40s)
#endif

#ifndef __copy_helper_block_e8_32s40s48r
#define __copy_helper_block_e8_32s40s48r __NS_SYMBOL(__copy_helper_block_e8_32s40s48r)
#endif

#ifndef __destroy_helper_block_e8_32s40s48r
#define __destroy_helper_block_e8_32s40s48r __NS_SYMBOL(__destroy_helper_block_e8_32s40s48r)
#endif

#ifndef __clang_at_available_requires_core_foundation_framework
#define __clang_at_available_requires_core_foundation_framework __NS_SYMBOL(__clang_at_available_requires_core_foundation_framework)
#endif

// Externs
#ifndef _OBJC_PROTOCOL_$_AFImageCache
#define _OBJC_PROTOCOL_$_AFImageCache __NS_SYMBOL(_OBJC_PROTOCOL_$_AFImageCache)
#endif

#ifndef _OBJC_PROTOCOL_$_AFImageRequestCache
#define _OBJC_PROTOCOL_$_AFImageRequestCache __NS_SYMBOL(_OBJC_PROTOCOL_$_AFImageRequestCache)
#endif

#ifndef _OBJC_PROTOCOL_$_AFURLResponseSerialization
#define _OBJC_PROTOCOL_$_AFURLResponseSerialization __NS_SYMBOL(_OBJC_PROTOCOL_$_AFURLResponseSerialization)
#endif

#ifndef _OBJC_PROTOCOL_$_AFURLRequestSerialization
#define _OBJC_PROTOCOL_$_AFURLRequestSerialization __NS_SYMBOL(_OBJC_PROTOCOL_$_AFURLRequestSerialization)
#endif

#ifndef _OBJC_PROTOCOL_$_AFMultipartFormData
#define _OBJC_PROTOCOL_$_AFMultipartFormData __NS_SYMBOL(_OBJC_PROTOCOL_$_AFMultipartFormData)
#endif

#ifndef __block_descriptor_40_e8_32s_e5_v8?0l
#define __block_descriptor_40_e8_32s_e5_v8?0l __NS_SYMBOL(__block_descriptor_40_e8_32s_e5_v8?0l)
#endif

#ifndef __block_descriptor_40_e8_32s_e5_v8?0l
#define __block_descriptor_40_e8_32s_e5_v8?0l __NS_SYMBOL(__block_descriptor_40_e8_32s_e5_v8?0l)
#endif

#ifndef __block_descriptor_48_e8_32s40s_e5_v8?0l
#define __block_descriptor_48_e8_32s40s_e5_v8?0l __NS_SYMBOL(__block_descriptor_48_e8_32s40s_e5_v8?0l)
#endif

#ifndef __block_descriptor_56_e8_32s40bs48w_e56_v32?0"NSURLRequest"8"NSHTTPURLResponse"16"UIImage"24l
#define __block_descriptor_56_e8_32s40bs48w_e56_v32?0"NSURLRequest"8"NSHTTPURLResponse"16"UIImage"24l __NS_SYMBOL(__block_descriptor_56_e8_32s40bs48w_e56_v32?0"NSURLRequest"8"NSHTTPURLResponse"16"UIImage"24l)
#endif

#ifndef __block_descriptor_56_e8_32s40bs48w_e56_v32?0"NSURLRequest"8"NSHTTPURLResponse"16"NSError"24l
#define __block_descriptor_56_e8_32s40bs48w_e56_v32?0"NSURLRequest"8"NSHTTPURLResponse"16"NSError"24l __NS_SYMBOL(__block_descriptor_56_e8_32s40bs48w_e56_v32?0"NSURLRequest"8"NSHTTPURLResponse"16"NSError"24l)
#endif

#ifndef AFNetworkingReachabilityDidChangeNotification
#define AFNetworkingReachabilityDidChangeNotification __NS_SYMBOL(AFNetworkingReachabilityDidChangeNotification)
#endif

#ifndef AFNetworkingReachabilityNotificationStatusItem
#define AFNetworkingReachabilityNotificationStatusItem __NS_SYMBOL(AFNetworkingReachabilityNotificationStatusItem)
#endif

#ifndef __block_descriptor_40_e8__e5_v8?0l
#define __block_descriptor_40_e8__e5_v8?0l __NS_SYMBOL(__block_descriptor_40_e8__e5_v8?0l)
#endif

#ifndef __block_descriptor_40_e8_32w_e38_"AFNetworkReachabilityManager"16?0q8l
#define __block_descriptor_40_e8_32w_e38_"AFNetworkReachabilityManager"16?0q8l __NS_SYMBOL(__block_descriptor_40_e8_32w_e38_"AFNetworkReachabilityManager"16?0q8l)
#endif

#ifndef __block_descriptor_48_e8_32s40bs_e5_v8?0l
#define __block_descriptor_48_e8_32s40bs_e5_v8?0l __NS_SYMBOL(__block_descriptor_48_e8_32s40bs_e5_v8?0l)
#endif

#ifndef __block_descriptor_48_e8_32bs_e5_v8?0l
#define __block_descriptor_48_e8_32bs_e5_v8?0l __NS_SYMBOL(__block_descriptor_48_e8_32bs_e5_v8?0l)
#endif

#ifndef __block_descriptor_32_e5_v8?0l
#define __block_descriptor_32_e5_v8?0l __NS_SYMBOL(__block_descriptor_32_e5_v8?0l)
#endif

#ifndef __block_descriptor_40_e8__e5_v8?0l
#define __block_descriptor_40_e8__e5_v8?0l __NS_SYMBOL(__block_descriptor_40_e8__e5_v8?0l)
#endif

#ifndef __block_descriptor_40_e8_32s_e5_v8?0l
#define __block_descriptor_40_e8_32s_e5_v8?0l __NS_SYMBOL(__block_descriptor_40_e8_32s_e5_v8?0l)
#endif

#ifndef __block_descriptor_40_e8_32bs_e46_"NSData"24?0"NSHTTPURLResponse"8"NSData"16l
#define __block_descriptor_40_e8_32bs_e46_"NSData"24?0"NSHTTPURLResponse"8"NSData"16l __NS_SYMBOL(__block_descriptor_40_e8_32bs_e46_"NSData"24?0"NSHTTPURLResponse"8"NSData"16l)
#endif

#ifndef __block_descriptor_96_e8_32bs40bs48s56s64s72s80s88r_e38_v32?0"NSURLResponse"816"NSError"24l
#define __block_descriptor_96_e8_32bs40bs48s56s64s72s80s88r_e38_v32?0"NSURLResponse"816"NSError"24l __NS_SYMBOL(__block_descriptor_96_e8_32bs40bs48s56s64s72s80s88r_e38_v32?0"NSURLResponse"816"NSError"24l)
#endif

#ifndef __block_descriptor_64_e8_32s40bs48w_e56_v32?0"NSURLRequest"8"NSHTTPURLResponse"16"UIImage"24l
#define __block_descriptor_64_e8_32s40bs48w_e56_v32?0"NSURLRequest"8"NSHTTPURLResponse"16"UIImage"24l __NS_SYMBOL(__block_descriptor_64_e8_32s40bs48w_e56_v32?0"NSURLRequest"8"NSHTTPURLResponse"16"UIImage"24l)
#endif

#ifndef __block_descriptor_64_e8_32s40bs48w_e56_v32?0"NSURLRequest"8"NSHTTPURLResponse"16"NSError"24l
#define __block_descriptor_64_e8_32s40bs48w_e56_v32?0"NSURLRequest"8"NSHTTPURLResponse"16"NSError"24l __NS_SYMBOL(__block_descriptor_64_e8_32s40bs48w_e56_v32?0"NSURLRequest"8"NSHTTPURLResponse"16"NSError"24l)
#endif

#ifndef __block_descriptor_48_e8_32s40r_e5_v8?0l
#define __block_descriptor_48_e8_32s40r_e5_v8?0l __NS_SYMBOL(__block_descriptor_48_e8_32s40r_e5_v8?0l)
#endif

#ifndef __block_descriptor_56_e8_32s40s48s_e5_v8?0l
#define __block_descriptor_56_e8_32s40s48s_e5_v8?0l __NS_SYMBOL(__block_descriptor_56_e8_32s40s48s_e5_v8?0l)
#endif

#ifndef __block_descriptor_40_e8_32s_e5_v8?0l
#define __block_descriptor_40_e8_32s_e5_v8?0l __NS_SYMBOL(__block_descriptor_40_e8_32s_e5_v8?0l)
#endif

#ifndef __block_descriptor_56_e8_32s40s48r_e5_v8?0l
#define __block_descriptor_56_e8_32s40s48r_e5_v8?0l __NS_SYMBOL(__block_descriptor_56_e8_32s40s48r_e5_v8?0l)
#endif

#ifndef __block_descriptor_40_e8_32bs_e33_v24?0"NSURLSessionDataTask"816l
#define __block_descriptor_40_e8_32bs_e33_v24?0"NSURLSessionDataTask"816l __NS_SYMBOL(__block_descriptor_40_e8_32bs_e33_v24?0"NSURLSessionDataTask"816l)
#endif

#ifndef __block_descriptor_48_e8_32bs40s_e5_v8?0l
#define __block_descriptor_48_e8_32bs40s_e5_v8?0l __NS_SYMBOL(__block_descriptor_48_e8_32bs40s_e5_v8?0l)
#endif

#ifndef __block_descriptor_56_e8_32bs40bs48r_e38_v32?0"NSURLResponse"816"NSError"24l
#define __block_descriptor_56_e8_32bs40bs48r_e38_v32?0"NSURLResponse"816"NSError"24l __NS_SYMBOL(__block_descriptor_56_e8_32bs40bs48r_e38_v32?0"NSURLResponse"816"NSError"24l)
#endif

#ifndef AFURLResponseSerializationErrorDomain
#define AFURLResponseSerializationErrorDomain __NS_SYMBOL(AFURLResponseSerializationErrorDomain)
#endif

#ifndef AFNetworkingOperationFailingURLResponseErrorKey
#define AFNetworkingOperationFailingURLResponseErrorKey __NS_SYMBOL(AFNetworkingOperationFailingURLResponseErrorKey)
#endif

#ifndef AFNetworkingOperationFailingURLResponseDataErrorKey
#define AFNetworkingOperationFailingURLResponseDataErrorKey __NS_SYMBOL(AFNetworkingOperationFailingURLResponseDataErrorKey)
#endif

#ifndef __block_descriptor_32_e5_v8?0l
#define __block_descriptor_32_e5_v8?0l __NS_SYMBOL(__block_descriptor_32_e5_v8?0l)
#endif

#ifndef __block_descriptor_40_e8__e5_v8?0l
#define __block_descriptor_40_e8__e5_v8?0l __NS_SYMBOL(__block_descriptor_40_e8__e5_v8?0l)
#endif

#ifndef __block_descriptor_56_e8_32bs40s48s_e5_v8?0l
#define __block_descriptor_56_e8_32bs40s48s_e5_v8?0l __NS_SYMBOL(__block_descriptor_56_e8_32bs40s48s_e5_v8?0l)
#endif

#ifndef __block_descriptor_64_e8_32s40s48s56s_e5_v8?0l
#define __block_descriptor_64_e8_32s40s48s56s_e5_v8?0l __NS_SYMBOL(__block_descriptor_64_e8_32s40s48s56s_e5_v8?0l)
#endif

#ifndef __block_descriptor_88_e8_32s40s48s56s64s72s80w_e5_v8?0l
#define __block_descriptor_88_e8_32s40s48s56s64s72s80w_e5_v8?0l __NS_SYMBOL(__block_descriptor_88_e8_32s40s48s56s64s72s80w_e5_v8?0l)
#endif

#ifndef __block_descriptor_72_e8_32s40s48s56s64w_e38_v32?0"NSURLResponse"816"NSError"24l
#define __block_descriptor_72_e8_32s40s48s56s64w_e38_v32?0"NSURLResponse"816"NSError"24l __NS_SYMBOL(__block_descriptor_72_e8_32s40s48s56s64w_e38_v32?0"NSURLResponse"816"NSError"24l)
#endif

#ifndef __block_descriptor_80_e8_32s40bs48s56s64bs72r_e5_v8?0l
#define __block_descriptor_80_e8_32s40bs48s56s64bs72r_e5_v8?0l __NS_SYMBOL(__block_descriptor_80_e8_32s40bs48s56s64bs72r_e5_v8?0l)
#endif

#ifndef __block_descriptor_40_e8_32s_e49_B32?0"AFImageDownloaderResponseHandler"8Q16^B24l
#define __block_descriptor_40_e8_32s_e49_B32?0"AFImageDownloaderResponseHandler"8Q16^B24l __NS_SYMBOL(__block_descriptor_40_e8_32s_e49_B32?0"AFImageDownloaderResponseHandler"8Q16^B24l)
#endif

#ifndef __block_descriptor_56_e8_32s40s48s_e5_v8?0l
#define __block_descriptor_56_e8_32s40s48s_e5_v8?0l __NS_SYMBOL(__block_descriptor_56_e8_32s40s48s_e5_v8?0l)
#endif

#ifndef __block_descriptor_48_e8_32s40s_e5_v8?0l
#define __block_descriptor_48_e8_32s40s_e5_v8?0l __NS_SYMBOL(__block_descriptor_48_e8_32s40s_e5_v8?0l)
#endif

#ifndef __block_descriptor_56_e8_32s40s48r_e5_v8?0l
#define __block_descriptor_56_e8_32s40s48r_e5_v8?0l __NS_SYMBOL(__block_descriptor_56_e8_32s40s48r_e5_v8?0l)
#endif

#ifndef __block_descriptor_40_e8_32s_e5_v8?0l
#define __block_descriptor_40_e8_32s_e5_v8?0l __NS_SYMBOL(__block_descriptor_40_e8_32s_e5_v8?0l)
#endif

#ifndef AFNetworkingTaskDidResumeNotification
#define AFNetworkingTaskDidResumeNotification __NS_SYMBOL(AFNetworkingTaskDidResumeNotification)
#endif

#ifndef AFNetworkingTaskDidCompleteNotification
#define AFNetworkingTaskDidCompleteNotification __NS_SYMBOL(AFNetworkingTaskDidCompleteNotification)
#endif

#ifndef AFNetworkingTaskDidSuspendNotification
#define AFNetworkingTaskDidSuspendNotification __NS_SYMBOL(AFNetworkingTaskDidSuspendNotification)
#endif

#ifndef AFURLSessionDidInvalidateNotification
#define AFURLSessionDidInvalidateNotification __NS_SYMBOL(AFURLSessionDidInvalidateNotification)
#endif

#ifndef AFURLSessionDownloadTaskDidMoveFileSuccessfullyNotification
#define AFURLSessionDownloadTaskDidMoveFileSuccessfullyNotification __NS_SYMBOL(AFURLSessionDownloadTaskDidMoveFileSuccessfullyNotification)
#endif

#ifndef AFURLSessionDownloadTaskDidFailToMoveFileNotification
#define AFURLSessionDownloadTaskDidFailToMoveFileNotification __NS_SYMBOL(AFURLSessionDownloadTaskDidFailToMoveFileNotification)
#endif

#ifndef AFNetworkingTaskDidCompleteSerializedResponseKey
#define AFNetworkingTaskDidCompleteSerializedResponseKey __NS_SYMBOL(AFNetworkingTaskDidCompleteSerializedResponseKey)
#endif

#ifndef AFNetworkingTaskDidCompleteResponseSerializerKey
#define AFNetworkingTaskDidCompleteResponseSerializerKey __NS_SYMBOL(AFNetworkingTaskDidCompleteResponseSerializerKey)
#endif

#ifndef AFNetworkingTaskDidCompleteResponseDataKey
#define AFNetworkingTaskDidCompleteResponseDataKey __NS_SYMBOL(AFNetworkingTaskDidCompleteResponseDataKey)
#endif

#ifndef AFNetworkingTaskDidCompleteErrorKey
#define AFNetworkingTaskDidCompleteErrorKey __NS_SYMBOL(AFNetworkingTaskDidCompleteErrorKey)
#endif

#ifndef AFNetworkingTaskDidCompleteAssetPathKey
#define AFNetworkingTaskDidCompleteAssetPathKey __NS_SYMBOL(AFNetworkingTaskDidCompleteAssetPathKey)
#endif

#ifndef AFNetworkingTaskDidCompleteSessionTaskMetrics
#define AFNetworkingTaskDidCompleteSessionTaskMetrics __NS_SYMBOL(AFNetworkingTaskDidCompleteSessionTaskMetrics)
#endif

#ifndef __block_descriptor_40_e8_32w_e5_v8?0l
#define __block_descriptor_40_e8_32w_e5_v8?0l __NS_SYMBOL(__block_descriptor_40_e8_32w_e5_v8?0l)
#endif

#ifndef __block_descriptor_48_e8_32s40s_e5_v8?0l
#define __block_descriptor_48_e8_32s40s_e5_v8?0l __NS_SYMBOL(__block_descriptor_48_e8_32s40s_e5_v8?0l)
#endif

#ifndef __block_descriptor_72_e8_32s40s48s56s64r_e5_v8?0l
#define __block_descriptor_72_e8_32s40s48s56s64r_e5_v8?0l __NS_SYMBOL(__block_descriptor_72_e8_32s40s48s56s64r_e5_v8?0l)
#endif

#ifndef __block_descriptor_80_e8_32s40s48s56s64s72r_e5_v8?0l
#define __block_descriptor_80_e8_32s40s48s56s64s72r_e5_v8?0l __NS_SYMBOL(__block_descriptor_80_e8_32s40s48s56s64s72r_e5_v8?0l)
#endif

#ifndef __block_descriptor_40_e8_32s_e41_v32?0"NSArray"8"NSArray"16"NSArray"24l
#define __block_descriptor_40_e8_32s_e41_v32?0"NSArray"8"NSArray"16"NSArray"24l __NS_SYMBOL(__block_descriptor_40_e8_32s_e41_v32?0"NSArray"8"NSArray"16"NSArray"24l)
#endif

#ifndef __block_descriptor_40_e8_32s_e5_v8?0l
#define __block_descriptor_40_e8_32s_e5_v8?0l __NS_SYMBOL(__block_descriptor_40_e8_32s_e5_v8?0l)
#endif

#ifndef __block_descriptor_40_e8_32bs_e68_"NSURL"32?0"NSURLSession"8"NSURLSessionDownloadTask"16"NSURL"24l
#define __block_descriptor_40_e8_32bs_e68_"NSURL"32?0"NSURLSession"8"NSURLSessionDownloadTask"16"NSURL"24l __NS_SYMBOL(__block_descriptor_40_e8_32bs_e68_"NSURL"32?0"NSURLSession"8"NSURLSessionDownloadTask"16"NSURL"24l)
#endif

#ifndef __block_descriptor_56_e8_32s40s48r_e41_v32?0"NSArray"8"NSArray"16"NSArray"24l
#define __block_descriptor_56_e8_32s40s48r_e41_v32?0"NSArray"8"NSArray"16"NSArray"24l __NS_SYMBOL(__block_descriptor_56_e8_32s40s48r_e41_v32?0"NSArray"8"NSArray"16"NSArray"24l)
#endif

#ifndef __block_descriptor_32_e5_v8?0l
#define __block_descriptor_32_e5_v8?0l __NS_SYMBOL(__block_descriptor_32_e5_v8?0l)
#endif

#ifndef AFURLRequestSerializationErrorDomain
#define AFURLRequestSerializationErrorDomain __NS_SYMBOL(AFURLRequestSerializationErrorDomain)
#endif

#ifndef AFNetworkingOperationFailingURLRequestErrorKey
#define AFNetworkingOperationFailingURLRequestErrorKey __NS_SYMBOL(AFNetworkingOperationFailingURLRequestErrorKey)
#endif

#ifndef __block_descriptor_40_e8_32s_e15_v32?08Q16^B24l
#define __block_descriptor_40_e8_32s_e15_v32?08Q16^B24l __NS_SYMBOL(__block_descriptor_40_e8_32s_e15_v32?08Q16^B24l)
#endif

#ifndef __block_descriptor_48_e8_32s40r_e5_v8?0l
#define __block_descriptor_48_e8_32s40r_e5_v8?0l __NS_SYMBOL(__block_descriptor_48_e8_32s40r_e5_v8?0l)
#endif

#ifndef __block_descriptor_56_e8_32s40s48s_e5_v8?0l
#define __block_descriptor_56_e8_32s40s48s_e5_v8?0l __NS_SYMBOL(__block_descriptor_56_e8_32s40s48s_e5_v8?0l)
#endif

#ifndef __block_descriptor_56_e8_32s40s48r_e5_v8?0l
#define __block_descriptor_56_e8_32s40s48r_e5_v8?0l __NS_SYMBOL(__block_descriptor_56_e8_32s40s48r_e5_v8?0l)
#endif

#ifndef __block_descriptor_40_e8_32s_e5_v8?0l
#define __block_descriptor_40_e8_32s_e5_v8?0l __NS_SYMBOL(__block_descriptor_40_e8_32s_e5_v8?0l)
#endif

#ifndef __block_descriptor_48_e8_32bs40r_e5_v8?0l
#define __block_descriptor_48_e8_32bs40r_e5_v8?0l __NS_SYMBOL(__block_descriptor_48_e8_32bs40r_e5_v8?0l)
#endif

#ifndef __block_descriptor_64_e8_32s40s48bs56r_e5_v8?0l
#define __block_descriptor_64_e8_32s40s48bs56r_e5_v8?0l __NS_SYMBOL(__block_descriptor_64_e8_32s40s48bs56r_e5_v8?0l)
#endif

#ifndef __block_descriptor_48_e8_32s40s_e15_v32?0816^B24l
#define __block_descriptor_48_e8_32s40s_e15_v32?0816^B24l __NS_SYMBOL(__block_descriptor_48_e8_32s40s_e15_v32?0816^B24l)
#endif

#ifndef __block_descriptor_48_e8_32s40s_e5_v8?0l
#define __block_descriptor_48_e8_32s40s_e5_v8?0l __NS_SYMBOL(__block_descriptor_48_e8_32s40s_e5_v8?0l)
#endif

#ifndef __block_descriptor_56_e8_32s40s_e5_v8?0l
#define __block_descriptor_56_e8_32s40s_e5_v8?0l __NS_SYMBOL(__block_descriptor_56_e8_32s40s_e5_v8?0l)
#endif

#ifndef __block_descriptor_32_e5_v8?0l
#define __block_descriptor_32_e5_v8?0l __NS_SYMBOL(__block_descriptor_32_e5_v8?0l)
#endif

#ifndef kAFUploadStream3GSuggestedPacketSize
#define kAFUploadStream3GSuggestedPacketSize __NS_SYMBOL(kAFUploadStream3GSuggestedPacketSize)
#endif

#ifndef kAFUploadStream3GSuggestedDelay
#define kAFUploadStream3GSuggestedDelay __NS_SYMBOL(kAFUploadStream3GSuggestedDelay)
#endif

