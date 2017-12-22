// Namespaced Header

#ifndef __NS_SYMBOL
// We need to have multiple levels of macros here so that __NAMESPACE_PREFIX_ is
// properly replaced by the time we concatenate the namespace prefix.
#define __NS_REWRITE(ns, symbol) ns ## _ ## symbol
#define __NS_BRIDGE(ns, symbol) __NS_REWRITE(ns, symbol)
#define __NS_SYMBOL(symbol) __NS_BRIDGE(AGR, symbol)
#endif


// Classes
#ifndef PodsDummy_SOCKit
#define PodsDummy_SOCKit __NS_SYMBOL(PodsDummy_SOCKit)
#endif

#ifndef SOCParameter
#define SOCParameter __NS_SYMBOL(SOCParameter)
#endif

#ifndef SOCPattern
#define SOCPattern __NS_SYMBOL(SOCPattern)
#endif

// Functions
#ifndef SOCArgumentTypeForTypeAsChar
#define SOCArgumentTypeForTypeAsChar __NS_SYMBOL(SOCArgumentTypeForTypeAsChar)
#endif

#ifndef SOCStringFromStringWithObject
#define SOCStringFromStringWithObject __NS_SYMBOL(SOCStringFromStringWithObject)
#endif

// Externs
#ifndef kTemporaryBackslashToken
#define kTemporaryBackslashToken __NS_SYMBOL(kTemporaryBackslashToken)
#endif

