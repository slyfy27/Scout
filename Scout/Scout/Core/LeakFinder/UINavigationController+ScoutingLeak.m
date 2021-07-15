//
//  UINavigationController+ScoutingLeak.m
//  Scout
//
//  Created by slyfy27 on 2021/7/14.
//

#import "UINavigationController+ScoutingLeak.h"
#import "NSObject+Scout.h"
#import "NSObject+ScoutingLeak.h"
#import <objc/runtime.h>

@implementation UINavigationController (ScoutingLeak)

+ (void)load {
    [self scout_swizzleSEL:@selector(popViewControllerAnimated:) withSEL:@selector(scoutingLeak_popViewControllerAnimated:)];
    [self scout_swizzleSEL:@selector(popToViewController:animated:) withSEL:@selector(scoutingLeak_popToViewController:animated:)];
    [self scout_swizzleSEL:@selector(popToRootViewControllerAnimated:) withSEL:@selector(scoutingLeak_popToRootViewControllerAnimated:)];
}

- (UIViewController *)scoutingLeak_popViewControllerAnimated:(BOOL)animated {
    /// 还是使用了同样的pop + tag，通过dispear的方式发现tab切换无法区分，还是这边统一处理吧
    UIViewController *poppedViewController = [self scoutingLeak_popViewControllerAnimated:animated];
    if (!poppedViewController) {
        return nil;
    }
    extern const void *const scoutingVCPopedKey;
    objc_setAssociatedObject(poppedViewController, scoutingVCPopedKey, @(YES), OBJC_ASSOCIATION_RETAIN);
    return poppedViewController;
}

- (NSArray<UIViewController *> *)scoutingLeak_popToViewController:(UIViewController *)viewController animated:(BOOL)animated {
    NSArray<UIViewController *> *popedVCArray = [self scoutingLeak_popToViewController:viewController animated:animated];
    for (UIViewController *vc in popedVCArray) {
        [vc scoutingLeak];
    }
    return popedVCArray;
}

- (NSArray<UIViewController *> *)scoutingLeak_popToRootViewControllerAnimated:(BOOL)animated {
    NSArray<UIViewController *> *popedVCArray = [self scoutingLeak_popToRootViewControllerAnimated:animated];
    for (UIViewController *vc in popedVCArray) {
        [vc scoutingLeak];
    }
    return popedVCArray;
}

- (BOOL)scoutingLeak {
    if (![super scoutingLeak]) {
        return NO;
    }
    [self scoutingChildren:self.viewControllers];
    return YES;
}

@end
