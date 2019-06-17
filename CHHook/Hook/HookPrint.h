//
//  HookPrint.h
//  CHHook
//
//  Created by shenzhen-dd01 on 2019/6/17.
//  Copyright © 2019 rainbow. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HookPrint : NSObject
+ (instancetype)shared;
- (void)noticePrint:(NSString *)message;
@end

NS_ASSUME_NONNULL_END
