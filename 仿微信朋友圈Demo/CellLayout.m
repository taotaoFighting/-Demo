//
//  CellLayout.m
//  仿微信朋友圈Demo
//
//  Created by apple on 16/11/14.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CellLayout.h"
#import "LWConstraintManager.h"
#import "LWStorage+Constraint.h"

@implementation CellLayout

-(id)initWithContainer:(LWStorageContainer *)container statusModel:(Model *)model index:(NSInteger)index dateFormatter:(NSDateFormatter *)dateFormatter{
    
    self = [super initWithContainer:container];
    
    if(self){
        
       /********生成Storage 相当于模型************/
        
        /*********LWAsyncDisplayView用将所有文本跟图片的模型都抽象成LWStorage，方便你能预先将所有的需要计算的布局内容直接缓存起来***/
        
        /*******而不是在渲染的时候才进行计算***************/
        
        /**** 头像模型  ******/
        LWImageStorage *headerImageView = [[LWImageStorage alloc]init];
        
        headerImageView.type = LWImageStorageWebImage;
        
        headerImageView.URL = [NSURL URLWithString:model.avatar];
        
        headerImageView.cornerRadius = 20.0f;
        
        headerImageView.cornerBackgroundColor = [UIColor whiteColor];
        
        headerImageView.fadeShow = YES;
        
        headerImageView.masksToBounds = NO;
        
        /**** 名字模型  ******/
        LWTextStorage *nameStore = [[LWTextStorage alloc]init];
        
        nameStore.text = model.name;
        
        nameStore.font = [UIFont systemFontOfSize:14.0f];
        
        nameStore.textAlignment = NSTextAlignmentLeft;
        
        nameStore.textColor = [UIColor redColor];
        
        nameStore.linespace = 2.0;
        
        /**** 正文模型  ******/
        LWTextStorage *contentStore = [[LWTextStorage alloc]init];
        
        contentStore.text = model.content;
        
        contentStore.font = [UIFont systemFontOfSize:15.0f];
        
        contentStore.textColor = [UIColor grayColor];
        
        contentStore.linespace = 2.0f;
        
        /**** 设置约束 自动布局  ******/
        
        [LWConstraintManager lw_makeConstraint:headerImageView.constraint.leftMargin(10).topMargin(10).widthLength(40).heightLength(40)];
        
        [LWConstraintManager lw_makeConstraint:nameStore.constraint.leftMarginToStorage(headerImageView,10).topMargin(10).widthLength(320)];
        
        [LWConstraintManager lw_makeConstraint:contentStore.constraint.leftMarginToStorage(headerImageView,10).topMarginToStorage(nameStore,10).rightMargin(10)];
        
        /**** 图片布局  ******/
        NSInteger imageCount = model.imgs.count;
        
        NSMutableArray *imageStoreArr = [NSMutableArray arrayWithCapacity:imageCount];
        
        NSMutableArray *imagePositionArr = [NSMutableArray arrayWithCapacity:imageCount];
        
        NSInteger row = 0;
        
        NSInteger column = 0;
        
        for (NSInteger i = 0; i < model.imgs.count; i++) {
            
            CGRect imageRect = CGRectMake(60.0f + column * 85.0f, 60.0f + contentStore.height + row * 85.0f, 80.0f, 80.0f);
            
            NSString *imagePositionString = NSStringFromCGRect(imageRect);
            
            [imagePositionArr addObject:imagePositionString];
            
            LWImageStorage *imageStore = [[LWImageStorage alloc]init];
            
            imageStore.frame = imageRect;
            
            NSString *urlString = model.imgs[i];
            
            imageStore.URL = [NSURL URLWithString:urlString];
            
            imageStore.type = LWImageStorageWebImage;
            
            imageStore.fadeShow = YES;
            
            imageStore.masksToBounds = YES;
            
            imageStore.contentMode = kCAGravityResizeAspectFill;
            
            [imageStoreArr addObject:imageStore];
            
            column++;
            
            if (column > 2) {
                
                column = 0 ;
                
                row++;
            }
            
            
        }
        
        CGFloat imageHeight = 0.0f;
        
        row < 3 ? (imageHeight = (row + 1) * 85.0f):(imageHeight = row * 85.0f);
        
        
        
        
        
        [container addStorage:headerImageView];//头像
        
        [container addStorage:nameStore];//昵称 姓名
        
        [container addStorage:contentStore];//内容
        
        [container addStorages:imageStoreArr];//图片集合
        
        self.imagePostionArray = imagePositionArr;
        
        self.Model = model;
        
        //如果是使用在UITableViewCell上面，可以通过以下方法快速的得到Cell的高度
        /**** 重要  ******/
        self.cellHeight = [self suggestHeightWithBottomMargin:15.0f];
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
    }
    
    return self;
}

@end
