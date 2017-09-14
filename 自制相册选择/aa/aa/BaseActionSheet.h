//
//  BaseActionSheet.h
//  Weigong
//
//  Created by dfhb@rdd on 16/1/22.
//  Copyright © 2016年 dfhb@rdd. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BaseActionSheet;
typedef void (^ActionSheetBlock)(NSInteger buttonIndex, BaseActionSheet *actionSheet);

@interface BaseActionSheet : UIActionSheet
/**
 *  初始化ActionSheet
 *
 *  @param title                  标题
 *  @param block                  点击的回调函数
 *  @param cancelButtonTitle      取消按钮标题
 *  @param destructiveButtonTitle 加红按钮的标题
 *  @param otherButtonTitles      其他按钮标题
 */
+ (instancetype)showWithTitle:(NSString *)title completionBlock:(ActionSheetBlock)block cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles;
@end
