//
//  Demo1Cell.m
//  YXCollectionView
//
//  Created by yixiang on 15/10/11.
//  Copyright © 2015年 yixiang. All rights reserved.
//

#import "Demo1Cell.h"

@interface Demo1Cell ()

@end

@implementation Demo1Cell

-(instancetype) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageShow = [[UIImageView alloc] initWithFrame:CGRectZero];
        self.imageShow.backgroundColor = [UIColor blueColor];
        [self.contentView addSubview:self.imageShow];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.imageShow.frame = CGRectMake(0, 0, SCREEN_WIDTH/3-8, 100);
}

- (void)setImageName : (UIImage *)imageName content : (NSString *)content{
    self.imageShow.image = imageName;
}

- (void)setImagIndex:(NSString *)imagIndex
{
    _imagIndex = imagIndex;
    NSLog(@"图 %@",imagIndex);
    if ([_imagIndex isEqualToString:@"加号"]) {
        self.imageShow.backgroundColor = [UIColor yellowColor];
    }
    else
    {
        self.imageShow.backgroundColor = [UIColor blueColor];
    }
}

@end
