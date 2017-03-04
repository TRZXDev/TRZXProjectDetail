//
//  TRZXProjectDetailViewModel.h
//  TRZXProjectDetail
//
//  Created by zhangbao on 2017/3/3.
//  Copyright © 2017年 TRZX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TRZXProjectDetailMacro.h"
#import "TRZXCellConfig.h"

@interface TRZXProjectDetailViewModel : NSObject

- (void)request:(void(^)())succes;


/**
 根据cellArray获取当前cell

 @param tableView tableView
 @param indexPath indexPath
 @return cell
 */
- (UITableViewCell *)cellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;

/**
 存储 cell
 */
@property (nonatomic, strong) NSMutableArray <NSArray <TRZXCellConfig *> *> *cellArray;

/**
 存储 sectionHeader
 */
@property (nonatomic, strong) NSMutableArray <NSArray <TRZXCellConfig *> *> *sectionHeaderArray;

@end
