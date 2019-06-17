//
//  HookPrint.m
//  CHHook
//
//  Created by shenzhen-dd01 on 2019/6/17.
//  Copyright © 2019 rainbow. All rights reserved.
//

#import "HookPrint.h"
#import <sys/uio.h>
#import <stdio.h>
#import "fishhook.h"

// 这两个方法是 swift 的print调用的
static char *__chineseChar = {0};
static int __buffIdx = 0;
static NSString *__syncToken = @"token";
static size_t (*orig_fwrite)(const void * __restrict __ptr, size_t __size, size_t __nitems, FILE * __restrict __stream);
size_t new_fwrite(const void * __restrict __ptr, size_t __size, size_t __nitems, FILE * __restrict __stream) {
    char *str = (char *)__ptr;
    __block NSString *s = [NSString stringWithCString:str encoding:NSUTF8StringEncoding];
    dispatch_async(dispatch_get_main_queue(), ^{
        @synchronized (__syncToken) {
            if (str[0] == '\n' && __chineseChar[0] != '\0') {
                s = [[NSString stringWithCString:__chineseChar encoding:NSUTF8StringEncoding] stringByAppendingString:s];
                __buffIdx = 0;
                __chineseChar = calloc(1, sizeof(char));
            }
        }
        [[HookPrint shared] noticePrint:s];
        //[[logInWindowManager share] addPrintWithMessage:s needReturn:false];
    });
    return orig_fwrite(__ptr, __size, __nitems, __stream);
}

static int    (*orin___swbuf)(int, FILE *);
int    new___swbuf(int c, FILE *p) {
    @synchronized (__syncToken) {
        __chineseChar = realloc(__chineseChar, sizeof(char) * (__buffIdx + 2));
        __chineseChar[__buffIdx] = (char)c;
        __chineseChar[__buffIdx + 1] = '\0';
        __buffIdx++;
    }
    return orin___swbuf(c, p);
}

// 发现新问题, 这个方法和NSLog重复了.. 所以把不hook NSLog了
static ssize_t (*orig_writev)(int a, const struct iovec * v, int v_len);
ssize_t new_writev(int a, const struct iovec *v, int v_len) {
    if (v_len == 3) {
        NSMutableString *string = [NSMutableString string];
        char *c = (char *)v[1].iov_base;
        [string appendString:[NSString stringWithCString:c encoding:NSUTF8StringEncoding]];
        dispatch_async(dispatch_get_main_queue(), ^{
            [[HookPrint shared] noticePrint:string];
            //[[logInWindowManager share] addPrintWithMessage:string needReturn:false];
        });
    }
    ssize_t result = orig_writev(a, v, v_len);
    return result;
}

static void (*orig_NSLog)(NSString *format, ...);
void(new_NSLog)(NSString *format, ...) {
    va_list args;
    if(format) {
        va_start(args, format);
        NSString *message = [[NSString alloc] initWithFormat:format arguments:args];
        [[HookPrint shared] noticePrint:message];
        //[[logInWindowManager share] addPrintWithMessage:message needReturn:true];
        orig_NSLog(@"%@", message);
        va_end(args);
    }
}

void println(NSString *format, ...) {
    va_list args;
    if(format) {
        va_start(args, format);
        NSString *message = [[NSString alloc] initWithFormat:format arguments:args];
        NSLog(@"%@", message);
        va_end(args);
    }
}

void rebindFunction() {
    //rebind_symbols((struct rebinding[1]){{"NSLog", new_NSLog, (void *)&orig_NSLog}}, 1);
    rebind_symbols((struct rebinding[1]){{"writev", new_writev, (void *)&orig_writev}}, 1);
    rebind_symbols((struct rebinding[1]){{"fwrite", new_fwrite, (void *)&orig_fwrite}}, 1);
    rebind_symbols((struct rebinding[1]){{"__swbuf", new___swbuf, (void *)&orin___swbuf}}, 1);
}

@implementation HookPrint

+ (void)load {
    rebindFunction();
}

+ (instancetype)shared {
    static HookPrint *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[HookPrint alloc] init];
    });
    return instance;
}

- (void)noticePrint:(NSString *)message {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"HookPrint_Hook_Print" object:nil userInfo:@{@"print": message}];
}

@end
