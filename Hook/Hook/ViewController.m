//
//  ViewController.m
//  Hook
//
//  Created by yaojian on 2022/10/2.
//

#import "ViewController.h"
#import "BViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    BViewController *vc = [BViewController new];
    [vc performSelector:@selector(test)];
}

@end
