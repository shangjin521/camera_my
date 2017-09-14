//
//  BaseActionSheet.m
//  Weigong
//
//  Created by dfhb@rdd on 16/1/22.
//  Copyright © 2016年 dfhb@rdd. All rights reserved.
//

#import "BaseActionSheet.h"

@interface BaseActionSheet ()<UIActionSheetDelegate>

@property (nonatomic, strong) ActionSheetBlock block;
@end

@implementation BaseActionSheet

+ (instancetype)showWithTitle:(NSString *)title completionBlock:(ActionSheetBlock)block cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles
{
    if (cancelButtonTitle == nil&&otherButtonTitles == nil) {
        return nil;
    }
    UIWindow *window = [UIApplication sharedApplication].windows.lastObject;
    if (window == nil) {
        return nil;
    }
    BaseActionSheet *action = [[BaseActionSheet alloc] initWithTitle:title completionBlock:block cancelButtonTitle:cancelButtonTitle destructiveButtonTitle:destructiveButtonTitle otherButtonTitles:otherButtonTitles];
    
    [action showInView:window];
    return action;
}
- (instancetype)initWithTitle:(NSString *)title completionBlock:(ActionSheetBlock)block cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles
{
    self = [super initWithTitle:title
                       delegate:self
              cancelButtonTitle:cancelButtonTitle
         destructiveButtonTitle:destructiveButtonTitle
              otherButtonTitles:nil, nil];
    if (self) {
        for (NSString *title in otherButtonTitles) {
            [self addButtonWithTitle:title];
        }
        //        [self addButtonWithTitle:cancelButtonTitle];
        
        self.block = block;
    }
    return self;
    
}
#pragma mark UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    __weak typeof(self) weakself = self;
    if (self.block) {
        self.block(buttonIndex, weakself);
    }
}
@end
