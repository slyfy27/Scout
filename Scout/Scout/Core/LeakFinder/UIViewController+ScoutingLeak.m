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

const void *const scoutingVCPopedKey = &scoutingVCPopedKey;

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

- (void)scoutingLead_viewWillAppear:(BOOL)animated {
    [self scoutingLead_viewWillAppear:animated];
    objc_setAssociatedObject(self, scoutingVCPopedKey, @(NO), OBJC_ASSOCIATION_RETAIN);
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

- (BOOL)scoutingLeak {
    if (![super scoutingLeak]) {
        return NO;
    }
    [self scoutingChildren:self.childViewControllers];
    if (self.presentedViewController) {
        [self scoutingChildren:@[self.presentedViewController]];
    }
    if (self.isViewLoaded) {
        [self scoutingChildren:@[self.view]];
    }
    return YES;
}

@end
