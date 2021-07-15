//
//  NSObject+ScoutingLeak.m
//  Scout
//
//  Created by slyfy27 on 2021/7/13.
//

#import "NSObject+ScoutingLeak.h"
#import <objc/runtime.h>
#import <UIKit/UIKit.h>

static const void *const scoutingVStackKey = &scoutingVStackKey;
static const void *const scoutingParentPtrsKey = &scoutingParentPtrsKey;

@implementation NSObject (ScoutingLeak)

- (BOOL)scoutingLeak {
    if ([[NSObject scoutWhitelist] containsObject:NSStringFromClass([self class])]) {
        return NO;
    }
    __weak id weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        __strong id strongSelf = weakSelf;
        [strongSelf checkIsDealloc];
    });
    return YES;
}

- (void)scoutingChildren:(NSArray *)children {
    NSArray *viewStack = [self viewStack];
    NSSet *parentPtrs = [self parentPtrs];
    for (id child in children) {
        NSString *className = NSStringFromClass([child class]);
        [child setViewStack:[viewStack arrayByAddingObject:className]];
        [child setParentPtrs:[parentPtrs setByAddingObject:@((uintptr_t)child)]];
        [child scoutingLeak];
    }
}

- (void)checkIsDealloc {
    NSString *className = NSStringFromClass([self class]);
    NSLog(@"%@未释放,可能发生内存泄漏\n视图栈：\n%@",className,[self viewStack]);
}

- (void)setViewStack:(NSArray *)viewStack {
    objc_setAssociatedObject(self, scoutingVStackKey, viewStack, OBJC_ASSOCIATION_RETAIN);
}

- (void)setParentPtrs:(NSSet *)parentPtrs {
    objc_setAssociatedObject(self, scoutingParentPtrsKey, parentPtrs, OBJC_ASSOCIATION_RETAIN);
}

- (NSArray *)viewStack {
    NSArray *viewStack = objc_getAssociatedObject(self, scoutingVStackKey);
    if (viewStack) {
        return viewStack;
    }
    NSString *className = NSStringFromClass([self class]);
    return @[className];
}

- (NSSet *)parentPtrs {
    NSSet *parentPtrs = objc_getAssociatedObject(self, scoutingParentPtrsKey);
    if (!parentPtrs) {
        parentPtrs = [[NSSet alloc] initWithObjects:@((uintptr_t)self), nil];
    }
    return parentPtrs;
}

+ (NSMutableSet *)scoutWhitelist {
    static NSMutableSet *whitelist = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        whitelist = [NSMutableSet setWithObjects:
                     @"UIFieldEditor", // UIAlertControllerTextField
                     @"UINavigationBar",
                     @"_UIAlertControllerActionView",
                     @"_UIVisualEffectBackdropView",
                     nil];
        
        // System's bug since iOS 10 and not fixed yet up to this ci.
        NSString *systemVersion = [UIDevice currentDevice].systemVersion;
        if ([systemVersion compare:@"10.0" options:NSNumericSearch] != NSOrderedAscending) {
            [whitelist addObject:@"UISwitch"];
        }
    });
    return whitelist;
}

@end
