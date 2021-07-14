//
//  UIViewController+ScoutingLeak.m
//  Scout
//
//  Created by slyfy27 on 2021/7/13.
//

#import "UIViewController+ScoutingLeak.h"
#import "NSObject+Scout.h"
#import "NSObject+ScoutingLeak.h"
#import <objc/runtime.h>

static const void *const scoutingVCPopedKey = &scoutingVCPopedKey;

@implementation UIViewController (ScoutingLeak)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self scout_swizzleSEL:@selector(viewDidDisappear:) withSEL:@selector(scoutingLeak_viewDidDisappear:)];
        [self scout_swizzleSEL:@selector(dismissViewControllerAnimated:completion:) withSEL:@selector(scoutingLeak_dismissControllerAnimated:completion:)];
    });
}

- (void)scoutingLeak_viewDidDisappear:(BOOL)animated {
    [self scoutingLeak_viewDidDisappear:animated];
    if ([objc_getAssociatedObject(self, scoutingVCPopedKey) boolValue]) {
        [self scoutingLeak];
    }
}

- (void)scoutingLeak_dismissControllerAnimated:(BOOL)animated completion:(void (^)(void))completion {
    [self scoutingLeak_dismissControllerAnimated:animated completion:completion];
    UIViewController *dismissedViewController = self.presentedViewController;
    if (!dismissedViewController && self.presentingViewController) {
        dismissedViewController = self;
    }
    if (dismissedViewController) {
        [dismissedViewController scoutingLeak];
    }
}

@end
