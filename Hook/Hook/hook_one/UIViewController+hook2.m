//
//  UIViewController+hook2.m
//  test
//
//  Created by iOS on 2021/8/3.
//

#import "UIViewController+hook2.h"
#import <objc/runtime.h>

@implementation UIViewController (hook2)
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL sourceSelector = @selector(viewDidAppear:);
        SEL targetSelector = @selector(hook2_viewDidAppear:);
        [self hookClass:self sourceSelector:sourceSelector targetSelector:targetSelector];
    });
}

+ (void)hookClass:(Class)classObject sourceSelector:(SEL)sourceSelector targetSelector:(SEL)targetSelector {
    Method sourceMethod  = class_getInstanceMethod(classObject, sourceSelector);
    Method targetMethod = class_getInstanceMethod(classObject, targetSelector);
    BOOL isAdd = class_addMethod(classObject, sourceSelector, method_getImplementation(targetMethod), method_getTypeEncoding(targetMethod));
    if (isAdd) {
        class_replaceMethod(classObject, targetSelector, method_getImplementation(sourceMethod), method_getTypeEncoding(sourceMethod));
    } else {
        method_exchangeImplementations(sourceMethod, targetMethod);
    }
}

- (void)hook2_viewDidAppear:(BOOL)animated {
    NSLog(@"----------hook2----------");
    [self hook2_viewDidAppear:animated];
}

@end
