//
//  BViewController.m
//  test
//
//  Created by iOS on 2021/8/6.
//

#import "BViewController.h"

@interface BViewController ()

@end

@implementation BViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

// BViewController 有 test 方法时, class_addMethod 不会成功
- (void)test {
    NSLog(@"----------A");
}

@end
