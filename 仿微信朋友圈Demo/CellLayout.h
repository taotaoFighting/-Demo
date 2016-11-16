//
//  CellLayout.h
//  仿微信朋友圈Demo
//
//  Created by apple on 16/11/14.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LWLayout.h"
#import "Model.h"

@interface CellLayout : LWLayout

@property (nonatomic,assign) CGFloat cellHeight;

@property (nonatomic,assign) CGRect menuPosition;

@property (nonatomic,assign) CGRect commentBgPosition;

@property (nonatomic,copy) NSArray* imagePostionArray;

@property (nonatomic,strong) Model* Model;

- (id)initWithContainer:(LWStorageContainer *)container
            statusModel:(Model *)Model
                  index:(NSInteger)index
          dateFormatter:(NSDateFormatter *)dateFormatter;

@end
