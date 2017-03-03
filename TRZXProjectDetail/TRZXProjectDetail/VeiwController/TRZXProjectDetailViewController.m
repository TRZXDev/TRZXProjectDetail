//
//  TRZXProjectDetailViewController.m
//  TRZXProjectDetail
//
//  Created by zhangbao on 2017/3/2.
//  Copyright © 2017年 TRZX. All rights reserved.
//

#import "TRZXProjectDetailViewController.h"
#import "TRZXProjectDetailMacro.h"
#import "TRZXProjectDetailNavigationBar.h"
#import "TRZXProjectDetailTableViewHeaderView.h"
#import "TRZXProjectDetailViewModel.h"

@interface TRZXProjectDetailViewController ()
<
UITableViewDelegate,
UITableViewDataSource
>

/**
 主tableView视图
 */
@property (nonatomic, strong) UITableView *tableView;
/**
 自定义导航栏
 */
@property (nonatomic, strong) TRZXProjectDetailNavigationBar *navigationBar;
/**
 tableView 头视图
 */
@property (nonatomic, strong) TRZXProjectDetailTableViewHeaderView *tableViewHeaderView;
/**
 VM
 */
@property (nonatomic, strong) TRZXProjectDetailViewModel *projectDetailVM;


@end

@implementation TRZXProjectDetailViewController

#pragma mark - <生命周期>
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = kTRZXBGrayColor;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self addOwnViews];
    
    [self layoutFrameOfSubViews];
    
    [self receiveActions];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
//    self.navigationController.navigationBarHidden = YES;
}

- (void)addOwnViews
{
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.navigationBar];
}

- (void)layoutFrameOfSubViews
{
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    [_navigationBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(kProjectDetailNavigationViewHeight);
    }];
}

- (void)receiveActions
{
    __weak __typeof(&*self)weakSelf = self;
    [_navigationBar setOnProjectDetailActionBlock:^(ENavigationBarAction action) {
        switch (action) {
            case ENavigationBarAction_Back: {
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }
                break;
            case ENavigationBarAction_Collect: {
                NSLog(@"ENavigationBarAction_Collect!");
            }
                
                break;
            case ENavigationBarAction_Share: {
                NSLog(@"ENavigationBarAction_Share!");
            }
                
                break;
                
            default:
                break;
        }
    }];
}

#pragma mark - <UITableViewDelegate/DataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.projectDetailVM.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.projectDetailVM.dataArray[section].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.projectDetailVM cellWithTableView:tableView indexPath:indexPath];
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint contentOffset = scrollView.contentOffset;
    
    [_navigationBar makeNavigationBarIsShow:contentOffset.y > (kProjectDetailTableViewHeaderViewHeight - kProjectDetailNavigationViewHeight)];
    
    [_tableViewHeaderView makeBackGroundImageScaleOfScrollViewDidScroll:contentOffset.y];
}

#pragma mark - <Setter/Getter>
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        // 设置代理
        _tableView.delegate = self;
        _tableView.dataSource = self;
        // 设置header
        _tableView.tableHeaderView = self.tableViewHeaderView;
        // 设置背景色
        _tableView.backgroundColor = kTRZXBGrayColor;
        // 自动计算cell高度
        _tableView.estimatedRowHeight = 80.0f;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        // 注册cell
//        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        
    }
    return _tableView;
}

- (TRZXProjectDetailNavigationBar *)navigationBar
{
    if (!_navigationBar) {
        _navigationBar = [[TRZXProjectDetailNavigationBar alloc] init];
    }
    return _navigationBar;
}

- (TRZXProjectDetailTableViewHeaderView *)tableViewHeaderView
{
    if (!_tableViewHeaderView) {
        _tableViewHeaderView = [[TRZXProjectDetailTableViewHeaderView alloc] initWithFrame:CGRectMake(0, 0, 0, kProjectDetailTableViewHeaderViewHeight)];
    }
    return _tableViewHeaderView;
}

- (TRZXProjectDetailViewModel *)projectDetailVM
{
    if (!_projectDetailVM) {
        _projectDetailVM = [[TRZXProjectDetailViewModel alloc] init];
    }
    return _projectDetailVM;
}
@end
