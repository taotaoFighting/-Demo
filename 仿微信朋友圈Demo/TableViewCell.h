//
//  TableViewCell.h
//  仿微信朋友圈Demo
//
//  Created by apple on 16/11/14.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellLayout.h"
#import "LWAsyncDisplayView.h"

@class TableViewCell;

@protocol TableViewCellDelegate <NSObject>

- (void)tableViewCell:(TableViewCell *)cell didClickedImageWithCellLayout:(CellLayout *)layout
              atIndex:(NSInteger)index;

- (void)tableViewCell:(TableViewCell *)cell didClickedLinkWithData:(id)data;

- (void)tableViewCell:(TableViewCell *)cell didClickedCommentWithCellLayout:(CellLayout *)layout
          atIndexPath:(NSIndexPath *)indexPath;


@end

@interface TableViewCell : UITableViewCell

@property (nonatomic,weak) id <TableViewCellDelegate> delegate;

/**      cellLayout      **/
@property (nonatomic , strong) CellLayout *cellLayout;

@property (nonatomic , strong) NSIndexPath *indexPath;


@end
