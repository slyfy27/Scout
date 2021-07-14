//
//  LeakViewController.h
//  Scout
//
//  Created by meetyou on 2021/7/14.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LeakViewController : UIViewController

@property (nonatomic, strong) UIViewController *parentVC;

@end

NS_ASSUME_NONNULL_END
