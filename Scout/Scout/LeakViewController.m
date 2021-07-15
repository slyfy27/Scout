//
//  LeakViewController.m
//  Scout
//
//  Created by slyfy27 on 2021/7/14.
//

#import "LeakViewController.h"

@interface LeakViewController ()

@property (nonatomic, strong) UIView *colorView;

@end

@implementation LeakViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.colorView = [[UIView alloc] init];
    [self.view addSubview:self.colorView];
}

@end
