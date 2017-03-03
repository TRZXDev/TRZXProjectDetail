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

@interface TRZXProjectDetailViewModel()

@property (nonatomic, strong) TRZXProjectDetailViewModel *projectDetailModel;

@end

@implementation TRZXProjectDetailViewModel


- (instancetype)init
{
    self = [super init];
    if (self) {
        
        // ETableViewSection_ProjectBaseHeader
        [self.dataArray addObject:@[[TRZXProjectDetailOnlyTextTableViewCell class]]];
        
        // ETableViewSection_ProjectBaseSubInfo
        NSMutableArray <Class> *subInfoSectionCells = [[NSMutableArray alloc] init];
        for (int i = 0; i < 5; i++) {
            [subInfoSectionCells addObject:[TRZXProjectDetailLeftTitleRightInfoTableViewCell class]];
        }
        [self.dataArray addObject:subInfoSectionCells];
        
    }
    return self;
}


- (UITableViewCell *)cellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath
{
    Class cellClass = self.dataArray[indexPath.section][indexPath.row];
    
    NSString *cellIdetifer = NSStringFromClass(cellClass);
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdetifer];
    
    if (!cell) {
        cell = [[[cellClass class] alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdetifer];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    // 设置cell 模型
    if ([cell respondsToSelector:@selector(setModel:)]) {
        
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [cell performSelector:@selector(setModel:) withObject:self.projectDetailModel];
#pragma clang diagnostic pop
    }
    
    if ([cell respondsToSelector:@selector(setModel:indexPath:)]) {
        [cell performSelector:@selector(setModel:indexPath:) withObject:self.projectDetailModel withObject:indexPath];
    }
    
    return cell;
}

#pragma mark - <Setter/Getter>
- (NSMutableArray<NSArray<Class> *> *)dataArray
{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}


@end
