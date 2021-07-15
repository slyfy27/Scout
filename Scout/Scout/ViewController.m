//
//  ViewController.m
//  Scout
//
//  Created by slyfy27 on 2021/7/13.
//

#import "ViewController.h"
#import "LeakViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UIViewController *pushVC;

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


@end
