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
#import "TRZXCellConfig.h"

/// 各种 cell
#import "TRZXProjectDetailOnlyTextTableViewCell.h"
#import "TRZXProjectDetailLeftTitleRightInfoTableViewCell.h"
#import "TRZXProjectDetailFinancingInfoTableViewCell.h"
#import "TRZXProjectDetailProjectHistoryTableViewCell.h"
#import "TRZXProjectDetailTeamTableViewCell.h"
#import "TRZXProjectDetailCommentTableViewCell.h"
#import "TRZXProjectDetailCommendTableViewCell.h"
#import "TRZXProjectDetailOnLineClassTableViewCell.h"
#import "TRZXProjectDetailnvestTableViewCell.h"

/// sectionHeader
#import "TRZXProjectDetailTitleSectionHeaderView.h"
#import "TRZXProjectDetailLeftRedTitleSectionHeaderView.h"

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

/**
 存储 cell
 */
@property (nonatomic, strong) NSMutableArray <NSArray <TRZXCellConfig *> *> *sectionArray;

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
    
    [self reloadData];
    
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

- (void)configSubViews
{
    [_tableViewHeaderView setCoverImage:@"" titile:@""];
}

- (void)reloadData
{
    [self.projectDetailVM reloadDataFromProjectDetailNetwork:self.projectId success:^(id json) {
        // 配置子视图
        [self configSubViews];
        
        // 配置 cell
        [self configSectionCells];
        
        // 刷新列表
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        
        // 配置子视图
        [self configSubViews];
        
        // 配置 cell
        [self configSectionCells];
        
        // 刷新列表
        [self.tableView reloadData];
        
    }];
}

#pragma mark - <Private-Method>
- (void)configSectionCells
{
    // ETableViewSection_ProjectBaseHeader
    TRZXCellConfig *projectBaseHeaderCellConfig = [TRZXCellConfig cellConfigWithClass:[TRZXProjectDetailOnlyTextTableViewCell class] showCellInfoMethod:@selector(setModel:)];
    projectBaseHeaderCellConfig.cellClass = [TRZXProjectDetailOnlyTextTableViewCell class];
    projectBaseHeaderCellConfig.showCellInfoMethod = @selector(setModel:);
    [self.sectionArray addObject:@[projectBaseHeaderCellConfig]];
    
    // ETableViewSection_ProjectBaseSubInfo
    NSMutableArray <TRZXCellConfig *> *subInfoSectionCells = [[NSMutableArray alloc] init];
    for (int i = 0; i < 5; i++) {
        TRZXCellConfig *leftTitleRightInfoCellConfig = [[TRZXCellConfig alloc] init];
        leftTitleRightInfoCellConfig.cellClass = [TRZXProjectDetailLeftTitleRightInfoTableViewCell class];
        leftTitleRightInfoCellConfig.showCellInfoMethod = @selector(setModel:indexPath:);
        [subInfoSectionCells addObject:leftTitleRightInfoCellConfig];
    }
    [self.sectionArray addObject:subInfoSectionCells];
    
    // ETableViewSection_ProjectFinancingInfo
    TRZXCellConfig *financingInfoCellConfig = [[TRZXCellConfig alloc] init];
    financingInfoCellConfig.title = @"融资信息";
    financingInfoCellConfig.cellClass = [TRZXProjectDetailFinancingInfoTableViewCell class];
    financingInfoCellConfig.sectionHeaderClass = [TRZXProjectDetailTitleSectionHeaderView class];
    financingInfoCellConfig.showCellInfoMethod = @selector(setModel:);
    financingInfoCellConfig.showSectionHeaderInfoMethod = @selector(setTitle:);
    financingInfoCellConfig.sectionHeaderHeight = 40;
    [self.sectionArray addObject:@[financingInfoCellConfig]];
    
    // ETableViewSection_ProjectDetail
    TRZXCellConfig *projectDetailCellConfig = [[TRZXCellConfig alloc] init];
    projectDetailCellConfig.title = @"项目详情";
    projectDetailCellConfig.cellClass = [TRZXProjectDetailOnlyTextTableViewCell class];
    projectDetailCellConfig.sectionHeaderClass = [TRZXProjectDetailTitleSectionHeaderView class];
    projectDetailCellConfig.showCellInfoMethod = @selector(setModel:);
    projectDetailCellConfig.showSectionHeaderInfoMethod = @selector(setTitle:);
    projectDetailCellConfig.sectionHeaderHeight = 40;
    [self.sectionArray addObject:@[projectDetailCellConfig]];
    
    // ETableViewSection_ProjectHistory
    NSMutableArray <TRZXCellConfig *> *projectHistoryCells = [[NSMutableArray alloc] init];
    for (int i = 0; i < 5; i++) {
        TRZXCellConfig *projectHistoryCellConfig = [[TRZXCellConfig alloc] init];
        projectHistoryCellConfig.title = @"项目大事记";
        projectHistoryCellConfig.cellClass = [TRZXProjectDetailProjectHistoryTableViewCell class];
        projectHistoryCellConfig.sectionHeaderClass = [TRZXProjectDetailTitleSectionHeaderView class];
        projectHistoryCellConfig.showCellInfoMethod = @selector(setModel:indexPath:);
        projectHistoryCellConfig.showSectionHeaderInfoMethod = @selector(setTitle:);
        projectHistoryCellConfig.sectionHeaderHeight = 40;
        [projectHistoryCells addObject:projectHistoryCellConfig];
    }
    [self.sectionArray addObject:projectHistoryCells];
    
    // ETableViewSection_ProjectCreatePeople
    TRZXCellConfig *projectCreatePeopleCellConfig = [TRZXCellConfig new];
    projectCreatePeopleCellConfig.title = @"创始人";
    projectCreatePeopleCellConfig.cellClass = [TRZXProjectDetailOnlyTextTableViewCell class];
    projectCreatePeopleCellConfig.sectionHeaderClass = [TRZXProjectDetailTitleSectionHeaderView class];
    projectCreatePeopleCellConfig.showCellInfoMethod = @selector(setModel:);
    projectCreatePeopleCellConfig.showSectionHeaderInfoMethod = @selector(setTitle:);
    projectCreatePeopleCellConfig.sectionHeaderHeight = 40;
    [self.sectionArray addObject:@[projectCreatePeopleCellConfig]];
    
    // ETableViewSection_Team
    NSMutableArray <TRZXCellConfig *> *teamCells = [[NSMutableArray alloc] init];
    for (int i = 0; i < 3; i++) {
        TRZXCellConfig *teamPeopleCellConfig = [TRZXCellConfig new];
        teamPeopleCellConfig.title = @"核心团队";
        teamPeopleCellConfig.cellClass = [TRZXProjectDetailTeamTableViewCell class];
        teamPeopleCellConfig.sectionHeaderClass = [TRZXProjectDetailTitleSectionHeaderView class];
        teamPeopleCellConfig.showCellInfoMethod = @selector(setModel:indexPath:);
        teamPeopleCellConfig.showSectionHeaderInfoMethod = @selector(setTitle:);
        teamPeopleCellConfig.sectionHeaderHeight = 40;
        [teamCells addObject:teamPeopleCellConfig];
    }
    [self.sectionArray addObject:teamCells];
    
    // ETableViewSection_TeamDescribe
    TRZXCellConfig *teamDescribeCellConfig = [TRZXCellConfig new];
    teamDescribeCellConfig.title = @"团队概述";
    teamDescribeCellConfig.cellClass = [TRZXProjectDetailOnlyTextTableViewCell class];
    teamDescribeCellConfig.sectionHeaderClass = [TRZXProjectDetailTitleSectionHeaderView class];
    teamDescribeCellConfig.showCellInfoMethod = @selector(setModel:);
    teamDescribeCellConfig.showSectionHeaderInfoMethod = @selector(setTitle:);
    teamDescribeCellConfig.sectionHeaderHeight = 40;
    [self.sectionArray addObject:@[teamDescribeCellConfig]];
    
    // ETableViewSection_CompanyDescription
    TRZXCellConfig *companyDescriptionCellConfig = [TRZXCellConfig new];
    companyDescriptionCellConfig.title = @"公司简介";
    companyDescriptionCellConfig.cellClass = [TRZXProjectDetailOnlyTextTableViewCell class];
    companyDescriptionCellConfig.sectionHeaderClass = [TRZXProjectDetailTitleSectionHeaderView class];
    companyDescriptionCellConfig.showCellInfoMethod = @selector(setModel:);
    companyDescriptionCellConfig.showSectionHeaderInfoMethod = @selector(setTitle:);
    companyDescriptionCellConfig.sectionHeaderHeight = 40;
    [self.sectionArray addObject:@[companyDescriptionCellConfig]];
    
    // ETableViewSection_Comment
    TRZXCellConfig *commentCellConfig = [TRZXCellConfig new];
    commentCellConfig.cellClass = [TRZXProjectDetailCommentTableViewCell class];
    commentCellConfig.showCellInfoMethod = @selector(setModel:);
    commentCellConfig.sectionHeaderHeight = 10;
    [self.sectionArray addObject:@[commentCellConfig]];
    
    // ETableViewSection_Commend
    TRZXCellConfig *commedCellConfig = [TRZXCellConfig new];
    commedCellConfig.cellClass = [TRZXProjectDetailCommendTableViewCell class];
    commedCellConfig.sectionHeaderHeight = 10;
    [self.sectionArray addObject:@[commedCellConfig]];
    
    // ETableViewSection_OnLineClass
    NSMutableArray <TRZXCellConfig *> *onlineClassCellConfigs = [[NSMutableArray alloc] init];
    for (int i = 0; i < 3; i++) {
        TRZXCellConfig *onlineClassCellConfig = [TRZXCellConfig new];
        onlineClassCellConfig.title = @"在线课程";
        onlineClassCellConfig.cellClass = [TRZXProjectDetailOnLineClassTableViewCell class];
        onlineClassCellConfig.sectionHeaderClass = [TRZXProjectDetailLeftRedTitleSectionHeaderView class];
        onlineClassCellConfig.showCellInfoMethod = @selector(setModel:indexPath:);
        onlineClassCellConfig.showSectionHeaderInfoMethod = @selector(setTitle:);
        onlineClassCellConfig.sectionHeaderHeight = 35;
        [onlineClassCellConfigs addObject:onlineClassCellConfig];
    }
    [self.sectionArray addObject:onlineClassCellConfigs];
    
    // ETableViewSection_OneToOne
    NSMutableArray <TRZXCellConfig *> *oneToOneCellConfigs = [[NSMutableArray alloc] init];
    for (int i = 0; i < 3; i++) {
        TRZXCellConfig *oneToOneCellConfig = [TRZXCellConfig new];
        oneToOneCellConfig.title = @"一对一咨询";
        oneToOneCellConfig.cellClass = [TRZXProjectDetailOnLineClassTableViewCell class];
        oneToOneCellConfig.sectionHeaderClass = [TRZXProjectDetailLeftRedTitleSectionHeaderView class];
        oneToOneCellConfig.showCellInfoMethod = @selector(setModel:indexPath:);
        oneToOneCellConfig.showSectionHeaderInfoMethod = @selector(setTitle:);
        oneToOneCellConfig.sectionHeaderHeight = 35;
        [oneToOneCellConfigs addObject:oneToOneCellConfig];
    }
    [self.sectionArray addObject:oneToOneCellConfigs];
    
    
    // ETableViewSection_InvestPeople
    NSMutableArray <TRZXCellConfig *> *investPeopleCellConfigs = [[NSMutableArray alloc] init];
    for (int i = 0; i < 3; i++) {
        TRZXCellConfig *investPeopleCellConfig = [TRZXCellConfig new];
        investPeopleCellConfig.title = @"投资人";
        investPeopleCellConfig.cellClass = [TRZXProjectDetailnvestTableViewCell class];
        investPeopleCellConfig.sectionHeaderClass = [TRZXProjectDetailLeftRedTitleSectionHeaderView class];
        investPeopleCellConfig.showCellInfoMethod = @selector(setModel:indexPath:);
        investPeopleCellConfig.showSectionHeaderInfoMethod = @selector(setTitle:);
        investPeopleCellConfig.sectionHeaderHeight = 35;
        [investPeopleCellConfigs addObject:investPeopleCellConfig];
    }
    [self.sectionArray addObject:investPeopleCellConfigs];
}

#pragma mark - <UITableViewDelegate/DataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.sectionArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.sectionArray[section].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    TRZXCellConfig *cellConfig = _sectionArray[indexPath.section][indexPath.row];
    
    UITableViewCell *cell = nil;
    
    TRZXProjectDetailModel *model = self.projectDetailVM.projectDetailModel;
    
    cell = [cellConfig cellOfCellConfigWithTableView:tableView dataModels:@[model,indexPath]];
    
    if ([cellConfig.cellIdentifier isEqualToString:NSStringFromClass([TRZXProjectDetailnvestTableViewCell class])]) {
        cell = [cellConfig cellOfCellConfigWithTableView:tableView dataModels:nil isNib:YES];
    }
    
    if ([cellConfig isTitle:@"融资信息"]) {
        
        
    }else if ([cellConfig isTitle:@"项目详情"]) {
        
        
        
    }else if ([cellConfig isTitle:@"项目大事记"]) {
        
        
    }else if ([cellConfig isTitle:@"创始人"]) {
        
        
        
    }else if ([cellConfig isTitle:@"核心团队"]) {
        
        
    }else if ([cellConfig isTitle:@"团队概述"]) {
        
        
    }else if ([cellConfig isTitle:@"公司简介"]) {
        
        
    }else if ([cellConfig isTitle:@"在线课程"]) {
        
        
    }else if ([cellConfig isTitle:@"一对一咨询"]) {
        
        
    }else if ([cellConfig isTitle:@"投资人"]) {
        
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    TRZXCellConfig *cellConfig = _sectionArray[section].firstObject;
    
    return [cellConfig sectionHederOfCellConfigWithTableView:tableView dataModels:@[cellConfig.title?cellConfig.title:@""] isNib:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return _sectionArray[section].firstObject.sectionHeaderHeight;
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
        // iOS8 系统中 rowHeight 的默认值已经设置成了 UITableViewAutomaticDimension
        _tableView.rowHeight = UITableViewAutomaticDimension;
//        _tableView.estimatedSectionHeaderHeight = 10;
//        _tableView.sectionHeaderHeight = UITableViewAutomaticDimension;
         // 去除cell分割线
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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

- (NSMutableArray<NSArray<TRZXCellConfig *> *> *)sectionArray
{
    if (!_sectionArray) {
        _sectionArray = [[NSMutableArray alloc] init];
    }
    return _sectionArray;
}
@end
