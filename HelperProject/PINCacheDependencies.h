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
// Externs
