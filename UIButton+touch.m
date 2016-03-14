//
//  UIButton+touch.m
//  LiqForDoctors
//
//  Created by StriEver on 16/3/10.
//  Copyright © 2016年 iMac. All rights reserved.
//

#import "UIButton+touch.h"
#import "objc/runtime.h"

@interface UIButton()
/**bool 类型   设置是否执行点UI方法*/
@property (nonatomic, assign) BOOL isIgnoreEvent;
@end
@implementation UIButton (touch)

/**
 *  change by qmy3 avoid interrupt with other +load
 */
+ (void)UIButtonTouch_load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // change by qmy3
        SEL selA = @selector(sendAction:to:forEvent:);
        SEL selB = @selector(mySendAction:to:forEvent:);
        
        Method originalMethod = class_getInstanceMethod(self, selA);
        Method extendedMethod = class_getInstanceMethod(self, selB);
        
        if (class_addMethod(self, selA,
                            method_getImplementation(extendedMethod),
                            method_getTypeEncoding(extendedMethod))) {
            class_replaceMethod(self, selB,
                                method_getImplementation(originalMethod),
                                method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, extendedMethod);
        }
    });
}

- (NSTimeInterval)timeInterval
{
    return [objc_getAssociatedObject(self, _cmd) doubleValue];
}
- (void)setTimeInterval:(NSTimeInterval)timeInterval
{
    objc_setAssociatedObject(self, @selector(timeInterval), @(timeInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}

#pragma  mark - 是否开启防止连续点击
- (BOOL)isOpenTT
{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}
- (void)setIsOpenTT:(BOOL)isOpen
{
    objc_setAssociatedObject(self, @selector(isOpenTT), @(isOpen), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}

- (void)mySendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event
{
    if ([NSStringFromClass(self.class) isEqualToString:@"UIButton"]) {
        if ( YES == self.isOpenTT ) {
            if (self.isIgnoreEvent == 0) {
                self.timeInterval = defaultInterval;
            };
            if (self.isIgnoreEvent) return;
            if (self.timeInterval > 0)
            {
                self.isIgnoreEvent = YES;
                [self performSelector:@selector(setIgnoreEvent:) withObject:@(NO) afterDelay:self.timeInterval];
            }
        }
    }
    
    [self mySendAction:action to:target forEvent:event];
    
}

- (void)setIgnoreEvent:(id)isIgnoreEv{
    self.isIgnoreEvent = [isIgnoreEv boolValue];
}

- (void)setIsIgnoreEvent:(BOOL)isIgnoreEv{
    objc_setAssociatedObject(self, @selector(isIgnoreEvent), @(isIgnoreEv), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (BOOL)isIgnoreEvent{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}
@end
