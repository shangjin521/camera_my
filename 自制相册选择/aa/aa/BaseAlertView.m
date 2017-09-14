//
//  BaseAlertView.m
//  自定义UIAlertView
//
//  Created by dfhb@rdd on 15/11/12.
//  Copyright © 2015年 GW. All rights reserved.
//

#import "BaseAlertView.h"

@interface BaseAlertView ()<UIAlertViewDelegate>
@property (nonatomic, strong) ButtonBlock block;
@end
@implementation BaseAlertView
+ (instancetype)showAlertWithTitle:(NSString *)title message:(NSString *)message completionBlock:(ButtonBlock)block cancelButtonTitle:(NSString *)cancelButtonTitle sureButtonTitle:(NSString *)sureButtonTitle
{
    if (cancelButtonTitle == nil&&sureButtonTitle == nil) {
        return nil;
    }
    
    BaseAlertView *alert = [[BaseAlertView alloc] initWithTitle:title
                                                        message:message
                                                completionBlock:block
                                              cancelButtonTitle:cancelButtonTitle
                                                sureButtonTitle:sureButtonTitle];
    [alert show];
    return alert;
}
- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message completionBlock:(void (^)(NSInteger, BaseAlertView *))block cancelButtonTitle:(NSString *)cancelButtonTitle sureButtonTitle:(NSString *)sureButtonTitle
{
    self = [super initWithTitle:title
                        message:message
                       delegate:self
              cancelButtonTitle:nil
              otherButtonTitles:nil, nil];
    if (self) {
        if (cancelButtonTitle) {
            [self addButtonWithTitle:cancelButtonTitle];
        }
        if (sureButtonTitle) {
            [self addButtonWithTitle:sureButtonTitle];

        }
        
        self.block = block;
    }
    return self;
}
#pragma mark UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    __weak typeof(self) weakself = self;
    if (self.block) {
        self.block(buttonIndex, weakself);
    }
}
@end
