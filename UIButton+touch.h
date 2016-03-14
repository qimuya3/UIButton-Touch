//
//  UIButton+touch.h
//  LiqForDoctors
//
//  Created by StriEver on 16/3/10.
//  modified by qmy3 on 16/3/14.
//  Copyright © 2016年 iMac. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark - 默认点击时间间隔
#define defaultInterval 0.5f  //默认时间间隔

/**
 *  防止UIButton连续点击
 */
#pragma mark - 防止UIButton连续点击
@interface UIButton (touch)


#pragma mark - 非常重要 Very Important
/**
 *  手动初始化 UIButton (touch)
 *  注意：在app启动时，必须手动调用该方法，进行方法替换，
         才能正常使用 UIButton防止连续点击
 */
+ (void)UIButtonTouch_load;

/**设置点击时间间隔*/
@property (nonatomic, assign) NSTimeInterval timeInterval;

// 是否开启防止连续点击，默认不开启
@property (nonatomic, assign) BOOL isOpenTT;

@end
