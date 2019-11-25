//
//  NSDictionary+Hook.h
//  CHHook
//
//  Created by dd01 on 2019/11/25.
//  Copyright © 2019 rainbow. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/*
 解决方案参考：[【iOS】让NSLog打印字典显示得更好看(解决中文乱码并显示成JSON格式)](https://www.jianshu.com/p/79cd2476287d)
 */
@interface NSDictionary (Hook)

- (NSString *)descriptionWithLocale:(id)locale;
- (NSString *)descriptionWithLocale:(id)locale indent:(NSUInteger)level;
- (NSString *)debugDescription;

@end

NS_ASSUME_NONNULL_END
