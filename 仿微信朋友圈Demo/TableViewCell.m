//
//  TableViewCell.m
//  仿微信朋友圈Demo
//
//  Created by apple on 16/11/14.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "TableViewCell.h"
#import "LWDefine.h"
#import "LWImageStorage.h"
//#import "Menu.h"

@interface TableViewCell()<LWAsyncDisplayViewDelegate>

@property (nonatomic,strong) LWAsyncDisplayView* asyncDisplayView;

//@property (nonatomic) Menu* menu;

@end


@implementation TableViewCell


#pragma mark --初始化
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        [self.backgroundView setBackgroundColor:[UIColor whiteColor]];
        
        [self addSubview:self.asyncDisplayView];
        
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    
    return self;
}

#pragma mark - Actions 代理方法
- (void)lwAsyncDisplayView:(LWAsyncDisplayView *)asyncDisplayView
   didCilickedImageStorage:(LWImageStorage *)imageStorage
                     touch:(UITouch *)touch{
    
    CGPoint point = [touch locationInView:self];
    
    for (NSInteger i = 0; i < self.cellLayout.imagePostionArray.count; i ++) {
        
        CGRect imagePosition = CGRectFromString(self.cellLayout.imagePostionArray[i]);
        //点击查看大图
        if (CGRectContainsPoint(imagePosition, point)) {
            if ([self.delegate respondsToSelector:@selector(tableViewCell:didClickedImageWithCellLayout:atIndex:)] &&
                [self.delegate conformsToProtocol:@protocol(TableViewCellDelegate)]) {
                
                [self.delegate tableViewCell:self didClickedImageWithCellLayout:self.cellLayout atIndex:i];
            }
        }
        
    }
    //点击菜单按钮
//    if (CGRectContainsPoint(CGRectMake(self.cellLayout.menuPosition.origin.x - 10,
//                                       self.cellLayout.menuPosition.origin.y - 10,
//                                       self.cellLayout.menuPosition.size.width + 20,
//                                       self.cellLayout.menuPosition.size.height + 20), point)) {
//        [self.menu clickedMenu];
//    }
}


/**
 *  点击链接回调
 *
 */
- (void)lwAsyncDisplayView:(LWAsyncDisplayView *)asyncDisplayView didCilickedLinkWithfData:(id)data {
    if ([self.delegate respondsToSelector:@selector(tableViewCell:didClickedLinkWithData:)] &&
        [self.delegate conformsToProtocol:@protocol(TableViewCellDelegate)]) {
        [self.delegate tableViewCell:self didClickedLinkWithData:data];
    }
}


/**
 *  点击评论
 *
 */
- (void)didClickedCommentButton {
    if ([self.delegate respondsToSelector:@selector(tableViewCell:didClickedCommentWithCellLayout:atIndexPath:)]) {
        [self.delegate tableViewCell:self didClickedCommentWithCellLayout:self.cellLayout atIndexPath:self.indexPath];
        
//        [self.menu menuHide];
    }
}


#pragma mark - Draw and setup

- (void)setCellLayout:(CellLayout *)cellLayout {
    
    if (_cellLayout == cellLayout) {
        
        return;
    }
    _cellLayout = cellLayout;
    
    self.asyncDisplayView.layout = cellLayout;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.asyncDisplayView.frame = CGRectMake(0,
                                             0,
                                             SCREEN_WIDTH,
                                             self.cellLayout.cellHeight);
//    self.menu.frame = CGRectMake(self.cellLayout.menuPosition.origin.x - 5.0f,
//                                 self.cellLayout.menuPosition.origin.y - 9.0f,
//                                 0,
//                                 34);
}

- (void)extraAsyncDisplayIncontext:(CGContextRef)context size:(CGSize)size {
    //绘制分割线
    CGContextMoveToPoint(context, 0.0f, self.bounds.size.height);
    CGContextAddLineToPoint(context, self.bounds.size.width, self.bounds.size.height);
    CGContextSetLineWidth(context, 0.3f);
    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
    CGContextStrokePath(context);
}

- (void)_drawImage:(UIImage *)image rect:(CGRect)rect context:(CGContextRef)context {
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, rect.origin.x, rect.origin.y);
    CGContextTranslateCTM(context, 0, rect.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextTranslateCTM(context, -rect.origin.x, -rect.origin.y);
    CGContextDrawImage(context, rect, image.CGImage);
    CGContextRestoreGState(context);
}


#pragma mark - Getter asyncDisplayView
- (LWAsyncDisplayView *)asyncDisplayView {
    
    if (!_asyncDisplayView) {
        
        _asyncDisplayView = [[LWAsyncDisplayView alloc] initWithFrame:CGRectZero maxImageStorageCount:10];
        
        _asyncDisplayView.delegate = self;
    }
    return _asyncDisplayView;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
