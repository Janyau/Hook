//
//  BViewController+hook.m
//  test
//
//  Created by iOS on 2021/8/6.
//

#import "BViewController+hook.h"
#import <objc/runtime.h>

@implementation BViewController (hook)
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL sourceSelector = @selector(test);
        SEL targetSelector = @selector(hook_test);
        [self hookClass:self sourceSelector:sourceSelector targetSelector:targetSelector];
    });
}

+ (void)hookClass:(Class)classObject sourceSelector:(SEL)sourceSelector targetSelector:(SEL)targetSelector {
    Method sourceMethod  = class_getInstanceMethod(classObject, sourceSelector);
    Method targetMethod = class_getInstanceMethod(classObject, targetSelector);

    BOOL isAdd = class_addMethod(classObject, sourceSelector, method_getImplementation(targetMethod), method_getTypeEncoding(targetMethod));
    if (isAdd) {
        NSLog(@"----------isAdd----------");
        class_replaceMethod(classObject, targetSelector, method_getImplementation(sourceMethod), method_getTypeEncoding(sourceMethod));
    } else {
        method_exchangeImplementations(sourceMethod, targetMethod);
    }
}

- (void)hook_test {
    NSLog(@"----------hook_test----------");
    [self hook_test];
}

@end
