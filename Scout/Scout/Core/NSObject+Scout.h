//
//  NSObject+Scout.h
//  Scout
//
//  Created by slyfy27 on 2021/7/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Scout)

/// 交换方法
+ (void)scout_swizzleSEL:(SEL)originalSEL withSEL:(SEL)swizzleSEL;

@end

NS_ASSUME_NONNULL_END
