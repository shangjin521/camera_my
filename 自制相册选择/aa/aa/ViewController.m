//
//  ViewController.m
//  aa
//
//  Created by bigbang进哥哥 on 2017/8/1.
//  Copyright © 2017年 bigbang进哥哥. All rights reserved.
//

#import "ViewController.h"
#import "Demo1Cell.h"
#import "BaseAlertView.h"
#import "BaseActionSheet.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <AVFoundation/AVFoundation.h>

#define  Demo1CellID @"demo1_cell_id"

@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    Demo1Cell *cell;
    // 本地图片 用来接收
    UIImage *imageURL;
}
@property (nonatomic , strong) UICollectionView *collectionView;
// 本地图片 (带0)
@property (nonatomic , strong) NSMutableArray *imageArr_0;
// 不带0
@property (nonatomic , strong) NSMutableArray *imageArr;
// 网络图片
@property (nonatomic , strong) NSMutableArray *imageUrlArr;
// 带URL 网络图片
@property (nonatomic , strong) NSString *imageStrUrl;

@end

@implementation ViewController

- (NSMutableArray *)imageArr{
    if (!_imageArr) {
        _imageArr = [NSMutableArray array];
    }
    return _imageArr;
}

- (NSMutableArray *)imageArr_0{
    if (!_imageArr_0) {
        _imageArr_0 = [NSMutableArray array];
    }
    return _imageArr_0;
}

- (NSMutableArray *)imageUrlArr {
    if (!_imageUrlArr) {
        _imageUrlArr = [NSMutableArray array];
    }
    return _imageUrlArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 初始化
    [self initView];
    // 本地图片 初始化
    [self.imageArr_0 addObject:@"0"];
}

- (void)initView{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(SCREEN_WIDTH/3, 100);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.minimumLineSpacing = 8;//设置每个item之间的最小行间距
    flowLayout.minimumInteritemSpacing = 8;//设置每个item最小的列间距
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 2, 0, 0);
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64) collectionViewLayout:flowLayout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.showsVerticalScrollIndicator = YES;
    collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:collectionView];
    _collectionView=collectionView;
    [self.collectionView registerClass:[Demo1Cell class] forCellWithReuseIdentifier:Demo1CellID];
}

#pragma mark- UICollectionViewDataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.imageArr_0.count;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    cell = [collectionView dequeueReusableCellWithReuseIdentifier:Demo1CellID forIndexPath:indexPath];
    if(!cell)
    {
        cell = [[Demo1Cell alloc] init];
    }
    //[cell setImageName:self.imageArr_0[indexPath.section] content:[NSString stringWithFormat:@"%zi",indexPath.section]];
    //[NSString stringWithFormat:@"{%zi,%zi}",indexPath.section,indexPath.row]
    if (self.imageArr_0.count == 1) {
        cell.imagIndex = @"加号";
    }
    else
    {
        if (indexPath.section == self.imageArr_0.count-1) {
            cell.imagIndex = @"加号";
            [cell setImageName:nil content:[NSString stringWithFormat:@"%zi",indexPath.section]];
        }
        else
        {
            [cell setImageName:self.imageArr[indexPath.section] content:[NSString stringWithFormat:@"%zi",indexPath.section]];
            cell.imagIndex = @"图片";
            NSLog(@"图片 %ld",(long)indexPath.section);
        }
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.imageArr_0.count == 1) {
        NSLog(@"%ld",(long)indexPath.section);
        [self showActionSheet];
        //[self.imageArr addObject:[NSString stringWithFormat:@"%ld",indexPath.section+1]];
        //[self.collectionView reloadData];
    }
    else
    {
        if (indexPath.section == self.imageArr_0.count-1) {
            NSLog(@"%ld",(long)indexPath.section);
            [self showActionSheet];
            //[self.imageArr addObject:[NSString stringWithFormat:@"%ld",indexPath.section+1]];
            //[self.collectionView reloadData];
        }
        else
        {
            NSLog(@"图片 %ld",(long)indexPath.section);
            //移除指定下标元素
            [self.imageArr_0 removeObjectAtIndex:indexPath.section+1];
            [self.imageArr removeObjectAtIndex:indexPath.section];
            [self.imageUrlArr removeObjectAtIndex:indexPath.section];
            [self.collectionView reloadData];
            NSLog(@"self.imageArr_0 ======== %@",self.imageArr_0);
            NSLog(@"self.imageArr ========= %@",self.imageArr);
            NSLog(@"self.imageUrlArr ========= %@",self.imageUrlArr);
        }
    }
    NSLog(@"%@",self.imageArr_0);
}

#pragma mark - 调用相册 拍照 提示框
- (void)showActionSheet {
    
    NSString *title = NSLocalizedString(@"Avatar from_00", nil);
    NSString *cancelButtonTitle = NSLocalizedString(@"Cancel_00", nil);
    NSString *destructiveButtonTitle = nil;
    NSArray *otherTitles = @[NSLocalizedString(@"Album_00", nil)];
    // 支持拍照
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        otherTitles = @[NSLocalizedString(@"Camera_00", nil), NSLocalizedString(@"Album_00", nil)];
    }
    //
    [BaseActionSheet showWithTitle:title completionBlock:^(NSInteger buttonIndex, BaseActionSheet *actionSheet) {
        NSLog(@"点击了%d", (int)buttonIndex);
        // 相册
        if (buttonIndex == otherTitles.count) {
            [self showPickViewWithSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        }
        // 相机
        else if (buttonIndex == 1&&otherTitles.count == 2) {
            [self showPickViewWithSourceType:UIImagePickerControllerSourceTypeCamera];
        }
    } cancelButtonTitle:cancelButtonTitle destructiveButtonTitle:destructiveButtonTitle otherButtonTitles:otherTitles];
}

#pragma mark 调用 拍照 相册 权限
- (void)showPickViewWithSourceType:(NSInteger)sourceType {
    // 相机
    if (sourceType == UIImagePickerControllerSourceTypeCamera) {
        // 判断是否取得相机授权
        AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        // 拒绝授权
        if (status == ALAuthorizationStatusRestricted || status == ALAuthorizationStatusDenied) {
            NSLog(@"没获取相机授权");
            NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
            NSString *name = infoDict[@"CFBundleDisplayName"];
            NSString *title = @"温馨提示";
            NSString *message = [NSString stringWithFormat:@"请在设备的\"设置-隐私-相机\"选项中，允许%@访问你的相机",name];
            [BaseAlertView showAlertWithTitle:title message:message completionBlock:^(NSInteger buttonIndex, BaseAlertView *alertView) {
                if (buttonIndex) {
                    NSString *boundleId = infoDict[@"CFBundleIdentifier"];
                    NSString *url = [NSString stringWithFormat:@"prefs:root=%@", boundleId];
                    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:url]]) {
                        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
                    }
                }
            } cancelButtonTitle:NSLocalizedString(@"Cancel_000", nil) sureButtonTitle:@"设置"];
        }
        else
        {
            [self presentPickerViewControllerWithType:sourceType];
        }
    }
    // 相册
    else if (sourceType == UIImagePickerControllerSourceTypePhotoLibrary)
    {
        ALAuthorizationStatus status = [ALAssetsLibrary authorizationStatus];
        if (status == AVAuthorizationStatusRestricted || status == AVAuthorizationStatusDenied)
        {
            NSLog(@"没获取相册授权");
            NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
            NSString *name = infoDict[@"CFBundleDisplayName"];
            NSString *title = @"温馨提示";
            NSString *message = [NSString stringWithFormat:@"请在设备的\"设置-隐私-照片\"选项中，允许%@访问你的手机相册",name];
            [BaseAlertView showAlertWithTitle:title message:message completionBlock:^(NSInteger buttonIndex, BaseAlertView *alertView) {
                if (buttonIndex) {
                    NSString *boundleId = infoDict[@"CFBundleIdentifier"];
                    NSString *url = [NSString stringWithFormat:@"prefs:root=%@", boundleId];
                    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:url]]) {
                        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
                    }
                }
            } cancelButtonTitle:NSLocalizedString(@"Cancel_000", nil) sureButtonTitle:@"设置"];
        }
        else
        {
            [self presentPickerViewControllerWithType:sourceType];
        }
    }
}

#pragma mark - 进入相册 拍照
- (void)presentPickerViewControllerWithType:(NSInteger)sourceType {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.sourceType = sourceType;
    picker.allowsEditing = YES;
    // 拍照
    if (sourceType == UIImagePickerControllerSourceTypeCamera) {
        picker.allowsEditing = YES;
    }
    [self presentViewController:picker animated:YES completion:nil];
}

#pragma mark - 代理 获取图片
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    //获取正在编辑的图片
    UIImage *image;
    if (picker.allowsEditing == YES) {
        image = [info valueForKey:UIImagePickerControllerEditedImage];
        if (picker.sourceType == UIImagePickerControllerSourceTypeCamera)
        {
            UIImageWriteToSavedPhotosAlbum(image,self,@selector(image:didFinishSavingWithError:contextInfo:),NULL);
        }
    }
    else
    {
        image = [info valueForKey:UIImagePickerControllerOriginalImage];
    }
    // 图片所在相册路径
    NSURL *imageUrl = [info valueForKey:UIImagePickerControllerReferenceURL];
    // 压缩图片
    imageURL = [self newimage:image size:CGSizeMake(500, 500)];
    NSLog(@" my image %@", imageURL);
    // 获取图片的名字信息
    ALAssetsLibraryAssetForURLResultBlock resultblock = ^(ALAsset *myasset)
    {
        ALAssetRepresentation *representation = [myasset defaultRepresentation];
        NSLog(@"本地 %@",[representation filename]);
        NSString *type = [[representation filename] substringWithRange:NSMakeRange([representation filename].length - 3, 3)];
        NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
        NSTimeInterval a = [dat timeIntervalSince1970]*1000;
        if (type == nil) {
            type = @"png";
        }
        NSString *timeString = [NSString stringWithFormat:@"logo/%0.f.%@", a, type];
        self.imageStrUrl = timeString;
        NSLog(@"本地拼接 %@",self.imageStrUrl);
    };
    //
    ALAssetsLibrary* assetslibrary = [[ALAssetsLibrary alloc] init];
    [assetslibrary assetForURL:imageUrl resultBlock:resultblock failureBlock:nil];
    //
    [picker dismissViewControllerAnimated:YES completion:^{
        [self.imageArr addObject:imageURL];
        [self.imageArr_0 addObject:imageURL];
        [self.imageUrlArr addObject:self.imageStrUrl];
        [self.collectionView reloadData];
        NSLog(@"imageArr_0 数组 %@",self.imageArr_0);
        NSLog(@"imageArr 数组 %@",self.imageArr);
        NSLog(@"imageUrlArr 数组 %@",self.imageUrlArr);
    }];
}

#pragma mark - 拍照保存本地
- (void)image:(UIImage*)image didFinishSavingWithError:(NSError*)error contextInfo:(void *)contextInfo
{
    if (error) {
        NSLog(@"保存失败");
    }else{
        NSLog(@"保存成功");
    }
}

#pragma mark 设置 image的size 压缩
- (UIImage *)newimage:(UIImage *)image size:(CGSize)size
{
    UIImage *newImage = nil;
    UIGraphicsBeginImageContext(size);
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = CGPointZero;
    thumbnailRect.size.width  = size.width;
    thumbnailRect.size.height = size.height;
    [image drawInRect:thumbnailRect];
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage ;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
