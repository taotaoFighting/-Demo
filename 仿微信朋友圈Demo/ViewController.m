//
//  ViewController.m
//  仿微信朋友圈Demo
//
//  Created by apple on 16/11/10.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ViewController.h"
#import "Model.h"
#import "CellLayout.h"
#import "TableViewCell.h"
#import "LWImageBrowser.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,TableViewCellDelegate>

@property(nonatomic , strong) NSArray *jsonArrData;

@property (nonatomic , strong) NSMutableArray *dataArr;

@property (nonatomic , strong) NSDateFormatter *dateFormatter;

@property (nonatomic , strong) UITableView *mainTableView;

@property (nonatomic , strong) UIView *footerView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"高仿朋友圈";
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [self.view addSubview:self.mainTableView];
    
    NSLog(@"%f",_mainTableView.bounds.size.height);
    
    [self dealData];
}

/**
 *标题  查看图片的带来方法
 */

-(void)tableViewCell:(TableViewCell *)cell didClickedImageWithCellLayout:(CellLayout *)layout atIndex:(NSInteger)index{
    
    NSMutableArray *tmpImagesArr = [NSMutableArray arrayWithCapacity:layout.imagePostionArray.count];
    
    for (NSInteger i = 0; i < layout.imagePostionArray.count; i++) {
        
        LWImageBrowserModel *model = [[LWImageBrowserModel alloc]initWithplaceholder:nil thumbnailURL:[NSURL URLWithString:layout.Model.imgs[i]] HDURL:[NSURL URLWithString:layout.Model.imgs[i]] imageViewSuperView:cell.contentView positionAtSuperView:CGRectFromString(layout.imagePostionArray[i]) index:index];
        
        [tmpImagesArr addObject:model];
    }
    
    
    
    LWImageBrowser *imageBrowser = [[LWImageBrowser alloc]initWithParentViewController:self style:LWImageBrowserAnimationStyleScale imageModels:tmpImagesArr currentIndex:index];
    
    [imageBrowser.view setBackgroundColor:[UIColor blackColor]];
    
    [imageBrowser show];
}

/**
 *标题  创建tableView
 */
-(UITableView *)mainTableView{
    
    if (_mainTableView) {
        
        return _mainTableView;
    }
    
    _mainTableView = [[UITableView alloc]init];
    
    [_mainTableView setFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64)];

    [_mainTableView setDelegate:self];
    
    [_mainTableView setDataSource:self];
    
    [_mainTableView setTableFooterView:self.footerView];
    
    return _mainTableView;
}

#pragma mark -- tableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSLog(@"self.dataArr.count = %lu",self.dataArr.count);
    
    return self.dataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIndentifier = @"TableViewCell";
    
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    
    if (!cell) {
        
        cell = [[TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    
    cell.delegate  = self;
    
    cell.indexPath = indexPath;
    
    if (self.dataArr.count > indexPath.row) {
        
        CellLayout *cellLayout = self.dataArr[indexPath.row];
        
        cell.cellLayout = cellLayout;
    }
    
    return cell;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.dataArr.count > indexPath.row) {
        
        CellLayout* layout = self.dataArr[indexPath.row];
        
        return layout.cellHeight;
    }
    
    return 0;
}


/**
 *标题  生成cell的模型
 */

- (CellLayout *)layoutWithStatusModel:(Model *)model index:(NSInteger)index{
    
    LWStorageContainer *storeContsiner = [[LWStorageContainer alloc]init];
    
    CellLayout *cellLayout = [[CellLayout alloc]initWithContainer:storeContsiner statusModel:model index:index dateFormatter:self.dateFormatter];
    
    return cellLayout;
}

#pragma mark -- 异步处理数据
-(void) dealData{
    
   dispatch_async(dispatch_get_global_queue(0, 0), ^{
       //处理耗时任务
       
       [self.jsonArrData enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
          
           Model *model = [Model modelWithJSON:obj];
           
           LWLayout *layout = [self layoutWithStatusModel:model index:idx];
           
           [self.dataArr addObject:layout];
           
       }];
       
       dispatch_async(dispatch_get_main_queue(), ^{
           //回到主线程 刷新数据
           
           [self.mainTableView reloadData];
       });
       
   });
    
}

#pragma mark -- 加载到TableView的数据源
-(NSMutableArray *)dataArr{
    
    if (_dataArr) {
        
        return _dataArr;
    }
    
    _dataArr = [NSMutableArray array];
    
    return _dataArr;
}


#pragma mark -- json数据
-(NSArray *)jsonArrData{
    
    if (_jsonArrData) {
        
        return _jsonArrData;
        
    }
    
    _jsonArrData = @[@{@"name":@"已发表的小说",
                           @"avatar":@"http://tp4.sinaimg.cn/1708004923/50/1283204657/0",
                       @"content":@"虽然春分已过，但北方的天气依然寒冷，呼啸的寒风却是未半点影响到长安街上的热闹盛况，晚间的长安城，花灯锦簇，灯火通明 ；大街上卖糖样的吆喝声，看杂技的喝彩声，还有闹元宵中最受欢迎的猜字谜的叫好声络绎不绝。",
                           @"date":@"1459668442",
                           @"imgs":@[@"http://ww2.sinaimg.cn/mw690/65ce163bjw1f2jdkd2hgjj20cj0gota8.jpg",
                                     @"http://ww1.sinaimg.cn/mw690/65ce163bjw1f2jdkjdm96j20bt0gota9.jpg",
                                     @"http://ww2.sinaimg.cn/mw690/65ce163bjw1f2jdkvwepij20go0clgnd.jpg",
                                     @"http://ww4.sinaimg.cn/mw690/65ce163bjw1f2jdl2ao77j20ci0gojsw.jpg",],
                           @"statusID":@"10"},@{@"name":@"小说",
                                                @"avatar":@"http://tp4.sinaimg.cn/1708004923/50/1283204657/0",
                                                @"content":@"仿佛是听到了姐姐呼唤，怀中小歌突然慢慢转醒了过来，醒来的小歌看到熟悉的姐姐，眼泪禁不住的往下流，她想反手抱着姐姐，但已经没有了一丝的力气。",
                                                @"date":@"1459668442",
                                                @"imgs":@[@"http://ww2.sinaimg.cn/mw690/65ce163bjw1f2jdkd2hgjj20cj0gota8.jpg",
                                                          @"http://ww1.sinaimg.cn/mw690/65ce163bjw1f2jdkjdm96j20bt0gota9.jpg",
                                                          @"http://ww2.sinaimg.cn/mw690/65ce163bjw1f2jdkvwepij20go0clgnd.jpg",
                                                          @"http://ww4.sinaimg.cn/mw690/65ce163bjw1f2jdl2ao77j20ci0gojsw.jpg",],
                                                @"statusID":@"10"}];
    
    return self.jsonArrData;
}

- (NSDateFormatter *)dateFormatter {
    
    static NSDateFormatter* dateFormatter;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        dateFormatter = [[NSDateFormatter alloc] init];
        
        [dateFormatter setDateFormat:@"MM月dd日 hh:mm"];
        
    });
    
    return dateFormatter;
}


-(UIView *)footerView{
    
    if (_footerView) {
        
        return _footerView;
        
    }
    
    _footerView = [[UIView alloc]init];
    
    return _footerView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
