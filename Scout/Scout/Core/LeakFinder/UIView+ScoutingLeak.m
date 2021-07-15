//
//  UIView+ScoutingLeak.m
//  Scout
//
//  Created by slyfy27 on 2021/7/15.
//

#import "UIView+ScoutingLeak.h"
#import "NSObject+ScoutingLeak.h"

@implementation UIView (ScoutingLeak)

- (BOOL)scoutingLeak {
    if (![super scoutingLeak]) {
        return NO;
    }
    [self scoutingChildren:self.subviews];
    return YES;
}

@end
