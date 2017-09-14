//
//  Demo1Cell.h
//  YXCollectionView
//
//  Created by yixiang on 15/10/11.
//  Copyright © 2015年 yixiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)

@interface Demo1Cell : UICollectionViewCell

@property (nonatomic , strong) NSString *imagIndex;
@property (nonatomic , strong) UIImageView *imageShow;

- (void)setImageName : (UIImage *)imageName content : (NSString *)content;

@end
