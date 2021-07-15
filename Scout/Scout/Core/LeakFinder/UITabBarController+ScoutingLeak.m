//
//  UITabBarController+ScoutingLeak.m
//  Scout
//
//  Created by slyfy27 on 2021/7/15.
//

#import "UITabBarController+ScoutingLeak.h"
#import "NSObject+ScoutingLeak.h"

@implementation UITabBarController (ScoutingLeak)

- (BOOL)scoutingLeak {
    if (![super scoutingLeak]) {
        return NO;
    }
    [self scoutingChildren:self.viewControllers];
    return YES;
}

@end
