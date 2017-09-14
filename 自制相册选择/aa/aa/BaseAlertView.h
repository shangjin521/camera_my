//
//  BaseAlertView.h
//  自定义UIAlertView
//
//  Created by dfhb@rdd on 15/11/12.
//  Copyright © 2015年 GW. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BaseAlertView;

typedef void (^ButtonBlock)(NSInteger buttonIndex, BaseAlertView *alertView);
@interface BaseAlertView : UIAlertView
/**
 *  初始化AlertView
 *
 *  @param title             标题
 *  @param message           内容
 *  @param block             点击按钮的Block
 *  @param cancelButtonTitle 取消按钮的标题
 *  @param sureButtonTitle   确定按钮的标题
 */
+ (instancetype)showAlertWithTitle:(NSString *)title message:(NSString *)message completionBlock:(ButtonBlock)block cancelButtonTitle:(NSString *)cancelButtonTitle sureButtonTitle:(NSString *)sureButtonTitle;
@end
