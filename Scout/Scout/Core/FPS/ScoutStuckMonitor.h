//
//  ScoutStuckMonitor.h
//  Scout
//
//  Created by slyfy27 on 2021/7/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ScoutStuckMonitor : NSObject

+ (instancetype)shareInstance;

- (void)start;
- (void)stop;

@end

NS_ASSUME_NONNULL_END
