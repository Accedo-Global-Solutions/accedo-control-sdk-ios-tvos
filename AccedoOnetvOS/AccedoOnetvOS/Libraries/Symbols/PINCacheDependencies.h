// Namespaced Header

#ifndef __NS_SYMBOL
// We need to have multiple levels of macros here so that __NAMESPACE_PREFIX_ is
// properly replaced by the time we concatenate the namespace prefix.
#define __NS_REWRITE(ns, symbol) ns ## _ ## symbol
#define __NS_BRIDGE(ns, symbol) __NS_REWRITE(ns, symbol)
#define __NS_SYMBOL(symbol) __NS_BRIDGE(AGR, symbol)
#endif


// Classes
#ifndef PINBackgroundTask
#define PINBackgroundTask __NS_SYMBOL(PINBackgroundTask)
#endif

#ifndef PINCache
#define PINCache __NS_SYMBOL(PINCache)
#endif

#ifndef PINDiskCache
#define PINDiskCache __NS_SYMBOL(PINDiskCache)
#endif

#ifndef PINMemoryCache
#define PINMemoryCache __NS_SYMBOL(PINMemoryCache)
#endif

#ifndef PodsDummy_PINCache
#define PodsDummy_PINCache __NS_SYMBOL(PodsDummy_PINCache)
#endif

// Functions
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

#ifndef __destroy_helper_block_e8_32s
#define __destroy_helper_block_e8_32s __NS_SYMBOL(__destroy_helper_block_e8_32s)
#endif

#ifndef __copy_helper_block_e8_32w
#define __copy_helper_block_e8_32w __NS_SYMBOL(__copy_helper_block_e8_32w)
#endif

#ifndef __destroy_helper_block_e8_32w
#define __destroy_helper_block_e8_32w __NS_SYMBOL(__destroy_helper_block_e8_32w)
#endif

#ifndef __copy_helper_block_e8_
#define __copy_helper_block_e8_ __NS_SYMBOL(__copy_helper_block_e8_)
#endif

#ifndef __destroy_helper_block_e8_
#define __destroy_helper_block_e8_ __NS_SYMBOL(__destroy_helper_block_e8_)
#endif

#ifndef __copy_helper_block_e8_32b40s48s56w
#define __copy_helper_block_e8_32b40s48s56w __NS_SYMBOL(__copy_helper_block_e8_32b40s48s56w)
#endif

#ifndef __destroy_helper_block_e8_32s40s48s56w
#define __destroy_helper_block_e8_32s40s48s56w __NS_SYMBOL(__destroy_helper_block_e8_32s40s48s56w)
#endif

#ifndef __copy_helper_block_e8_32b40w
#define __copy_helper_block_e8_32b40w __NS_SYMBOL(__copy_helper_block_e8_32b40w)
#endif

#ifndef __destroy_helper_block_e8_32s40w
#define __destroy_helper_block_e8_32s40w __NS_SYMBOL(__destroy_helper_block_e8_32s40w)
#endif

#ifndef __copy_helper_block_e8_32s40b48w
#define __copy_helper_block_e8_32s40b48w __NS_SYMBOL(__copy_helper_block_e8_32s40b48w)
#endif

#ifndef __destroy_helper_block_e8_32s40s48w
#define __destroy_helper_block_e8_32s40s48w __NS_SYMBOL(__destroy_helper_block_e8_32s40s48w)
#endif

#ifndef __copy_helper_block_e8_32s40b48w
#define __copy_helper_block_e8_32s40b48w __NS_SYMBOL(__copy_helper_block_e8_32s40b48w)
#endif

#ifndef __copy_helper_block_e8_40s
#define __copy_helper_block_e8_40s __NS_SYMBOL(__copy_helper_block_e8_40s)
#endif

#ifndef __destroy_helper_block_e8_32s40s48w
#define __destroy_helper_block_e8_32s40s48w __NS_SYMBOL(__destroy_helper_block_e8_32s40s48w)
#endif

#ifndef __destroy_helper_block_e8_40s
#define __destroy_helper_block_e8_40s __NS_SYMBOL(__destroy_helper_block_e8_40s)
#endif

#ifndef __copy_helper_block_e8_32s40s48b56w
#define __copy_helper_block_e8_32s40s48b56w __NS_SYMBOL(__copy_helper_block_e8_32s40s48b56w)
#endif

#ifndef __destroy_helper_block_e8_32s40s48s56w
#define __destroy_helper_block_e8_32s40s48s56w __NS_SYMBOL(__destroy_helper_block_e8_32s40s48s56w)
#endif

#ifndef __copy_helper_block_e8_32b40s48w
#define __copy_helper_block_e8_32b40s48w __NS_SYMBOL(__copy_helper_block_e8_32b40s48w)
#endif

#ifndef __copy_helper_block_e8_32b40w
#define __copy_helper_block_e8_32b40w __NS_SYMBOL(__copy_helper_block_e8_32b40w)
#endif

#ifndef __destroy_helper_block_e8_32s40w
#define __destroy_helper_block_e8_32s40w __NS_SYMBOL(__destroy_helper_block_e8_32s40w)
#endif

#ifndef __copy_helper_block_e8_32r
#define __copy_helper_block_e8_32r __NS_SYMBOL(__copy_helper_block_e8_32r)
#endif

#ifndef __destroy_helper_block_e8_32r
#define __destroy_helper_block_e8_32r __NS_SYMBOL(__destroy_helper_block_e8_32r)
#endif

#ifndef __copy_helper_block_e8_32b40b48w
#define __copy_helper_block_e8_32b40b48w __NS_SYMBOL(__copy_helper_block_e8_32b40b48w)
#endif

#ifndef __copy_helper_block_e8_32w
#define __copy_helper_block_e8_32w __NS_SYMBOL(__copy_helper_block_e8_32w)
#endif

#ifndef __destroy_helper_block_e8_32w
#define __destroy_helper_block_e8_32w __NS_SYMBOL(__destroy_helper_block_e8_32w)
#endif

#ifndef __copy_helper_block_e8_32b40w
#define __copy_helper_block_e8_32b40w __NS_SYMBOL(__copy_helper_block_e8_32b40w)
#endif

#ifndef __destroy_helper_block_e8_32s40w
#define __destroy_helper_block_e8_32s40w __NS_SYMBOL(__destroy_helper_block_e8_32s40w)
#endif

#ifndef __copy_helper_block_e8_32s40b48w
#define __copy_helper_block_e8_32s40b48w __NS_SYMBOL(__copy_helper_block_e8_32s40b48w)
#endif

#ifndef __destroy_helper_block_e8_32s40s48w
#define __destroy_helper_block_e8_32s40s48w __NS_SYMBOL(__destroy_helper_block_e8_32s40s48w)
#endif

#ifndef __copy_helper_block_e8_32s40s48b56w
#define __copy_helper_block_e8_32s40s48b56w __NS_SYMBOL(__copy_helper_block_e8_32s40s48b56w)
#endif

#ifndef __destroy_helper_block_e8_32s40s48s56w
#define __destroy_helper_block_e8_32s40s48s56w __NS_SYMBOL(__destroy_helper_block_e8_32s40s48s56w)
#endif

#ifndef __copy_helper_block_e8_32b40b48s56w
#define __copy_helper_block_e8_32b40b48s56w __NS_SYMBOL(__copy_helper_block_e8_32b40b48s56w)
#endif

#ifndef __copy_helper_block_e8_32s40s
#define __copy_helper_block_e8_32s40s __NS_SYMBOL(__copy_helper_block_e8_32s40s)
#endif

#ifndef __destroy_helper_block_e8_32s40s
#define __destroy_helper_block_e8_32s40s __NS_SYMBOL(__destroy_helper_block_e8_32s40s)
#endif

// Externs
#ifndef __block_descriptor_40_e8__e5_v8?0l
#define __block_descriptor_40_e8__e5_v8?0l __NS_SYMBOL(__block_descriptor_40_e8__e5_v8?0l)
#endif

#ifndef __block_descriptor_32_e60_v40?0"PINDiskCache"8"NSString"16"<NSCoding>"24"NSURL"32l
#define __block_descriptor_32_e60_v40?0"PINDiskCache"8"NSString"16"<NSCoding>"24"NSURL"32l __NS_SYMBOL(__block_descriptor_32_e60_v40?0"PINDiskCache"8"NSString"16"<NSCoding>"24"NSURL"32l)
#endif

#ifndef __block_descriptor_64_e8_32bs40s48s56w_e5_v8?0l
#define __block_descriptor_64_e8_32bs40s48s56w_e5_v8?0l __NS_SYMBOL(__block_descriptor_64_e8_32bs40s48s56w_e5_v8?0l)
#endif

#ifndef __block_descriptor_48_e8_32bs40w_e60_v40?0"PINDiskCache"8"NSString"16"<NSCoding>"24"NSURL"32l
#define __block_descriptor_48_e8_32bs40w_e60_v40?0"PINDiskCache"8"NSString"16"<NSCoding>"24"NSURL"32l __NS_SYMBOL(__block_descriptor_48_e8_32bs40w_e60_v40?0"PINDiskCache"8"NSString"16"<NSCoding>"24"NSURL"32l)
#endif

#ifndef __block_descriptor_48_e8_32bs40w_e40_v32?0"PINMemoryCache"8"NSString"1624l
#define __block_descriptor_48_e8_32bs40w_e40_v32?0"PINMemoryCache"8"NSString"1624l __NS_SYMBOL(__block_descriptor_48_e8_32bs40w_e40_v32?0"PINMemoryCache"8"NSString"1624l)
#endif

#ifndef __block_descriptor_56_e8_32s40bs48w_e5_v8?0l
#define __block_descriptor_56_e8_32s40bs48w_e5_v8?0l __NS_SYMBOL(__block_descriptor_56_e8_32s40bs48w_e5_v8?0l)
#endif

#ifndef __block_descriptor_40_e40_v32?0"PINMemoryCache"8"NSString"1624l
#define __block_descriptor_40_e40_v32?0"PINMemoryCache"8"NSString"1624l __NS_SYMBOL(__block_descriptor_40_e40_v32?0"PINMemoryCache"8"NSString"1624l)
#endif

#ifndef __block_descriptor_40_e60_v40?0"PINDiskCache"8"NSString"16"<NSCoding>"24"NSURL"32l
#define __block_descriptor_40_e60_v40?0"PINDiskCache"8"NSString"16"<NSCoding>"24"NSURL"32l __NS_SYMBOL(__block_descriptor_40_e60_v40?0"PINDiskCache"8"NSString"16"<NSCoding>"24"NSURL"32l)
#endif

#ifndef __block_descriptor_56_e8_32bs40s48w_e5_v8?0l
#define __block_descriptor_56_e8_32bs40s48w_e5_v8?0l __NS_SYMBOL(__block_descriptor_56_e8_32bs40s48w_e5_v8?0l)
#endif

#ifndef __block_descriptor_40_e24_v16?0"PINMemoryCache"8l
#define __block_descriptor_40_e24_v16?0"PINMemoryCache"8l __NS_SYMBOL(__block_descriptor_40_e24_v16?0"PINMemoryCache"8l)
#endif

#ifndef __block_descriptor_40_e22_v16?0"PINDiskCache"8l
#define __block_descriptor_40_e22_v16?0"PINDiskCache"8l __NS_SYMBOL(__block_descriptor_40_e22_v16?0"PINDiskCache"8l)
#endif

#ifndef __block_descriptor_48_e8_32bs40w_e5_v8?0l
#define __block_descriptor_48_e8_32bs40w_e5_v8?0l __NS_SYMBOL(__block_descriptor_48_e8_32bs40w_e5_v8?0l)
#endif

#ifndef __block_descriptor_40_e8_32r_e22_v16?0"PINDiskCache"8l
#define __block_descriptor_40_e8_32r_e22_v16?0"PINDiskCache"8l __NS_SYMBOL(__block_descriptor_40_e8_32r_e22_v16?0"PINDiskCache"8l)
#endif

#ifndef __block_descriptor_40_e8__e5_v8?0l
#define __block_descriptor_40_e8__e5_v8?0l __NS_SYMBOL(__block_descriptor_40_e8__e5_v8?0l)
#endif

#ifndef __block_descriptor_40_e8_32w_e5_v8?0l
#define __block_descriptor_40_e8_32w_e5_v8?0l __NS_SYMBOL(__block_descriptor_40_e8_32w_e5_v8?0l)
#endif

#ifndef __block_descriptor_56_e8_32s40bs48w_e5_v8?0l
#define __block_descriptor_56_e8_32s40bs48w_e5_v8?0l __NS_SYMBOL(__block_descriptor_56_e8_32s40bs48w_e5_v8?0l)
#endif

#ifndef __block_descriptor_72_e8_32s40s48bs56w_e5_v8?0l
#define __block_descriptor_72_e8_32s40s48bs56w_e5_v8?0l __NS_SYMBOL(__block_descriptor_72_e8_32s40s48bs56w_e5_v8?0l)
#endif

#ifndef __block_descriptor_56_e8_32bs40w_e5_v8?0l
#define __block_descriptor_56_e8_32bs40w_e5_v8?0l __NS_SYMBOL(__block_descriptor_56_e8_32bs40w_e5_v8?0l)
#endif

#ifndef __block_descriptor_48_e8_32bs40w_e5_v8?0l
#define __block_descriptor_48_e8_32bs40w_e5_v8?0l __NS_SYMBOL(__block_descriptor_48_e8_32bs40w_e5_v8?0l)
#endif

#ifndef __block_descriptor_56_e8_32bs40bs48w_e5_v8?0l
#define __block_descriptor_56_e8_32bs40bs48w_e5_v8?0l __NS_SYMBOL(__block_descriptor_56_e8_32bs40bs48w_e5_v8?0l)
#endif

#ifndef __block_descriptor_40_e8_32s_e5_v8?0l
#define __block_descriptor_40_e8_32s_e5_v8?0l __NS_SYMBOL(__block_descriptor_40_e8_32s_e5_v8?0l)
#endif

#ifndef __block_descriptor_40_e8__e5_v8?0l
#define __block_descriptor_40_e8__e5_v8?0l __NS_SYMBOL(__block_descriptor_40_e8__e5_v8?0l)
#endif

#ifndef __block_descriptor_32_e5_v8?0l
#define __block_descriptor_32_e5_v8?0l __NS_SYMBOL(__block_descriptor_32_e5_v8?0l)
#endif

#ifndef __block_descriptor_48_e8_40s_e5_v8?0l
#define __block_descriptor_48_e8_40s_e5_v8?0l __NS_SYMBOL(__block_descriptor_48_e8_40s_e5_v8?0l)
#endif

#ifndef __block_descriptor_40_e8_32w_e5_v8?0l
#define __block_descriptor_40_e8_32w_e5_v8?0l __NS_SYMBOL(__block_descriptor_40_e8_32w_e5_v8?0l)
#endif

#ifndef __block_descriptor_48_e8_32bs40w_e5_v8?0l
#define __block_descriptor_48_e8_32bs40w_e5_v8?0l __NS_SYMBOL(__block_descriptor_48_e8_32bs40w_e5_v8?0l)
#endif

#ifndef __block_descriptor_56_e8_32s40bs48w_e5_v8?0l
#define __block_descriptor_56_e8_32s40bs48w_e5_v8?0l __NS_SYMBOL(__block_descriptor_56_e8_32s40bs48w_e5_v8?0l)
#endif

#ifndef __block_descriptor_64_e8_32s40s48bs56w_e5_v8?0l
#define __block_descriptor_64_e8_32s40s48bs56w_e5_v8?0l __NS_SYMBOL(__block_descriptor_64_e8_32s40s48bs56w_e5_v8?0l)
#endif

#ifndef __block_descriptor_56_e8_32bs40w_e5_v8?0l
#define __block_descriptor_56_e8_32bs40w_e5_v8?0l __NS_SYMBOL(__block_descriptor_56_e8_32bs40w_e5_v8?0l)
#endif

#ifndef __block_descriptor_64_e8_32bs40bs48s56w_e5_v8?0l
#define __block_descriptor_64_e8_32bs40bs48s56w_e5_v8?0l __NS_SYMBOL(__block_descriptor_64_e8_32bs40bs48s56w_e5_v8?0l)
#endif

#ifndef __block_descriptor_48_e8_32w_e5_v8?0l
#define __block_descriptor_48_e8_32w_e5_v8?0l __NS_SYMBOL(__block_descriptor_48_e8_32w_e5_v8?0l)
#endif

#ifndef __block_descriptor_41_e8_32w_e5_v8?0l
#define __block_descriptor_41_e8_32w_e5_v8?0l __NS_SYMBOL(__block_descriptor_41_e8_32w_e5_v8?0l)
#endif

#ifndef __block_descriptor_48_e8_32s40s_e5_v8?0l
#define __block_descriptor_48_e8_32s40s_e5_v8?0l __NS_SYMBOL(__block_descriptor_48_e8_32s40s_e5_v8?0l)
#endif

