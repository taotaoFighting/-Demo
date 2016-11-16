//
//  Model.h
//  仿微信朋友圈Demo
//
//  Created by apple on 16/11/10.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LWAlchemy.h"


@interface Model : NSObject

/**      姓名      **/
@property (nonatomic , strong) NSString *name;

/**      头像url      **/
@property (nonatomic , strong) NSString *avatar;

/**      内容      **/
@property (nonatomic , strong) NSString *content;

/**      时间      **/
@property (nonatomic , strong) NSString *date;

/**      图片      **/
@property (nonatomic , strong) NSArray *imgs;

/**      statusID      **/
@property (nonatomic , strong) NSString *statusID;

/**      commentList      **/
@property (nonatomic ,strong) NSArray *commentList;



@end
