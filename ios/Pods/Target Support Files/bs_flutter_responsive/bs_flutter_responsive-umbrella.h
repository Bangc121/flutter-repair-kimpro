#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "BsFlutterResponsivePlugin.h"

FOUNDATION_EXPORT double bs_flutter_responsiveVersionNumber;
FOUNDATION_EXPORT const unsigned char bs_flutter_responsiveVersionString[];

