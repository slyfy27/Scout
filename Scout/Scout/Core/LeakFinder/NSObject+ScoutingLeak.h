//
//  NSObject+ScoutingLeak.h
//  Scout
//
//  Created by slyfy27 on 2021/7/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (ScoutingLeak)

/// 开始检测泄漏
- (void)scoutingLeak;

@end

NS_ASSUME_NONNULL_END
