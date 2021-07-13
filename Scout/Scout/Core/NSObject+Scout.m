//
//  NSObject+Scout.m
//  Scout
//
//  Created by slyfy27 on 2021/7/13.
//

#import "NSObject+Scout.h"
#import <objc/runtime.h>

@implementation NSObject (Scout)

+ (void)scout_swizzleSEL:(SEL)originalSEL withSEL:(SEL)swizzleSEL {
    Class cls = [self class];
    Method originalMethod = class_getInstanceMethod(cls, originalSEL);
    Method swizzleMethod = class_getInstanceMethod(cls, swizzleSEL);
    
    BOOL didAddMethod = class_addMethod(cls, originalSEL, method_getImplementation(swizzleMethod), method_getTypeEncoding(swizzleMethod));
    
    if (didAddMethod) {
        class_replaceMethod(cls, swizzleSEL, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzleMethod);
    }
}

@end
