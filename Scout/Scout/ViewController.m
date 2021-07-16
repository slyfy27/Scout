//
//  ViewController.m
//  Scout
//
//  Created by slyfy27 on 2021/7/13.
//

#import "ViewController.h"
#import "LeakViewController.h"
#import "FPSViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UIViewController *pushVC;
@property (nonatomic, strong) UIViewController *vvvv;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)push:(id)sender {
    LeakViewController *vc = [[LeakViewController alloc] init];
    self.pushVC = vc;
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)present:(id)sender {
    LeakViewController *vc = [[LeakViewController alloc] init];
    self.pushVC = vc;
    [self presentViewController:vc animated:YES completion:NULL];
}

#pragma mark - Performance

- (IBAction)fps:(id)sender {
    FPSViewController *vc = [[FPSViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
