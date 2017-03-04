//
//  TRZXProjectDetailViewModel.m
//  TRZXProjectDetail
//
//  Created by zhangbao on 2017/3/3.
//  Copyright © 2017年 TRZX. All rights reserved.
//

#import "TRZXProjectDetailViewModel.h"
#import "TRZXProjectDetailModel.h"

#import "TRZXProjectDetailOnlyTextTableViewCell.h"
#import "TRZXProjectDetailLeftTitleRightInfoTableViewCell.h"
#import "TRZXProjectDetailFinancingInfoTableViewCell.h"
#import "TRZXProjectDetailProjectHistoryTableViewCell.h"
#import "TRZXProjectDetailTeamTableViewCell.h"
#import "TRZXProjectDetailCommentTableViewCell.h"
#import "TRZXProjectDetailCommendTableViewCell.h"

@interface TRZXProjectDetailViewModel()

@property (nonatomic, strong) TRZXProjectDetailModel *projectDetailModel;

@end

@implementation TRZXProjectDetailViewModel

#pragma mark - <Public-Method>
// 获取数据
- (void)request:(void(^)())succes
{
    // 请求数据
    
    // 配置 cell
    [self configCells];
    
    // 回调
    if (succes) {
        succes();
    }
}

// 获取cell
- (UITableViewCell *)cellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath
{
    TRZXCellConfig *cellConfig = self.cellArray[indexPath.section][indexPath.row];
    
    UITableViewCell *cell = nil;
    
    cell = [cellConfig cellOfCellConfigWithTableView:tableView dataModels:@[self.projectDetailModel,indexPath]];
    
    return cell;
}

#pragma mark - <Private-Method>
- (void)configCells
{
    // ETableViewSection_ProjectBaseHeader
    TRZXCellConfig *projectBaseHeaderCellConfig = [TRZXCellConfig cellConfigWithClass:[TRZXProjectDetailOnlyTextTableViewCell class] showInfoMethod:@selector(setModel:)];
    [self.cellArray addObject:@[projectBaseHeaderCellConfig]];
    
    // ETableViewSection_ProjectBaseSubInfo
    NSMutableArray <TRZXCellConfig *> *subInfoSectionCells = [[NSMutableArray alloc] init];
    for (int i = 0; i < 5; i++) {
        TRZXCellConfig *leftTitleRightInfoCellConfig = [TRZXCellConfig cellConfigWithClass:[TRZXProjectDetailLeftTitleRightInfoTableViewCell class] showInfoMethod:@selector(setModel:indexPath:)];
        [subInfoSectionCells addObject:leftTitleRightInfoCellConfig];
    }
    [self.cellArray addObject:subInfoSectionCells];
    
    // ETableViewSection_ProjectFinancingInfo
    TRZXCellConfig *financingInfoCellConfig = [TRZXCellConfig cellConfigWithClass:[TRZXProjectDetailFinancingInfoTableViewCell class] showInfoMethod:@selector(setModel:)];
    [self.cellArray addObject:@[financingInfoCellConfig]];
    
    // ETableViewSection_ProjectDetail
    TRZXCellConfig *projectDetailCellConfig = [TRZXCellConfig cellConfigWithClass:[TRZXProjectDetailOnlyTextTableViewCell class] showInfoMethod:@selector(setModel:)];
    [self.cellArray addObject:@[projectDetailCellConfig]];
    
    // ETableViewSection_ProjectHistory
    NSMutableArray <TRZXCellConfig *> *projectHistoryCells = [[NSMutableArray alloc] init];
    for (int i = 0; i < 5; i++) {
        TRZXCellConfig *projectHistoryCellConfig = [TRZXCellConfig cellConfigWithClass:[TRZXProjectDetailProjectHistoryTableViewCell class] showInfoMethod:@selector(setModel:indexPath:)];
        [projectHistoryCells addObject:projectHistoryCellConfig];
    }
    [self.cellArray addObject:projectHistoryCells];
    
    // ETableViewSection_ProjectCreatePeople
    TRZXCellConfig *projectCreatePeopleCellConfig = [TRZXCellConfig cellConfigWithClass:[TRZXProjectDetailOnlyTextTableViewCell class] showInfoMethod:@selector(setModel:)];
    [self.cellArray addObject:@[projectCreatePeopleCellConfig]];
    
    // ETableViewSection_Team
    NSMutableArray <TRZXCellConfig *> *teamCells = [[NSMutableArray alloc] init];
    for (int i = 0; i < 3; i++) {
        TRZXCellConfig *teamPeopleCellConfig = [TRZXCellConfig cellConfigWithClass:[TRZXProjectDetailTeamTableViewCell class] showInfoMethod:@selector(setModel:indexPath:)];
        [teamCells addObject:teamPeopleCellConfig];
    }
    [self.cellArray addObject:teamCells];
    
    // ETableViewSection_TeamDescribe
    TRZXCellConfig *teamDescribeCellConfig = [TRZXCellConfig cellConfigWithClass:[TRZXProjectDetailOnlyTextTableViewCell class] showInfoMethod:@selector(setModel:)];
    [self.cellArray addObject:@[teamDescribeCellConfig]];
    
    // ETableViewSection_CompanyDescription
    TRZXCellConfig *companyDescriptionCellConfig = [TRZXCellConfig cellConfigWithClass:[TRZXProjectDetailOnlyTextTableViewCell class] showInfoMethod:@selector(setModel:)];
    [self.cellArray addObject:@[companyDescriptionCellConfig]];
    
    // ETableViewSection_Comment
    TRZXCellConfig *commentCellConfig = [TRZXCellConfig cellConfigWithClass:[TRZXProjectDetailCommentTableViewCell class] showInfoMethod:@selector(setModel:)];
    [self.cellArray addObject:@[commentCellConfig]];
    
    // ETableViewSection_Commend
    TRZXCellConfig *commedCellConfig = [TRZXCellConfig cellConfigWithClass:[TRZXProjectDetailCommendTableViewCell class] showInfoMethod:nil];
    [self.cellArray addObject:@[commedCellConfig]];
}


#pragma mark - <Setter/Getter>
- (NSMutableArray<NSArray<TRZXCellConfig *> *> *)cellArray
{
    if (!_cellArray) {
        _cellArray = [[NSMutableArray alloc] init];
    }
    return _cellArray;
}

- (NSMutableArray<NSArray<TRZXCellConfig *> *> *)sectionHeaderArray
{
    if (!_sectionHeaderArray) {
        _sectionHeaderArray = [[NSMutableArray alloc] init];
    }
    return _sectionHeaderArray;
}

- (TRZXProjectDetailModel *)projectDetailModel
{
    if (!_projectDetailModel) {
        _projectDetailModel = [[TRZXProjectDetailModel alloc] init];
    }
    return _projectDetailModel;
}

@end
