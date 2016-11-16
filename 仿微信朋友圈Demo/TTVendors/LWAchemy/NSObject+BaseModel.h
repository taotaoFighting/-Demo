//
//  NSObject+BaseModel.h
//  仿微信朋友圈Demo
//
//  Created by apple on 16/11/10.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NSManagedObject;
@class NSManagedObjectContext;


@interface NSObject (BaseModel)


/**
*  由JSON生成model
*
*/
+ (id)modelWithJSON:(id)json;


/**
 *  由JSON生成entity（CoreData）
 *
 */
+ (id)entityWithJSON:(id)json context:(NSManagedObjectContext *)context;

/**
 *  由NSDictionary生成Model
 *
 */
- (instancetype)modelWithDictionary:(NSDictionary *)dictionary;

/**
 *  由NSDictionary生成Entity（CoreData）
 *
 */
- (instancetype)entity:(NSManagedObject *)object
   modelWithDictionary:(NSDictionary *)dictionary
               context:(NSManagedObjectContext *)contxt;

/**
 *  由JSON生成NSDictionary
 *
 */
- (NSDictionary *)dictionaryWithJSON:(id)json;


/**
 *  自定义的映射
 *
 */
+ (NSDictionary *)mapper;


/**
 *  获取对象的描述
 *
 */
- (NSString *)lwDescription;

@end
