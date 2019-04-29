//
//  UIViewController+Hook.m
//  CHHook
//
//  Created by shenzhen-dd01 on 2019/4/28.
//  Copyright © 2019 rainbow. All rights reserved.
//

#import "UIViewController+Hook.h"
#import <objc/runtime.h>

@implementation UIViewController (Hook)

+ (void)load {
    Method originalMethod = class_getInstanceMethod(self, @selector(viewWillAppear:));
    Method swizzledMethod = class_getInstanceMethod(self, @selector(chhook_viewWillAppear:));
    method_exchangeImplementations(originalMethod, swizzledMethod);
}

- (void)chhook_viewWillAppear:(BOOL)animated {
    [self chhook_viewWillAppear:animated];
    
    NSString *class = [NSString stringWithFormat:@"%@", [self class]];
    NSLog(@"====================当前视图控制器：%@", class);
}

@end
