//
//  TRZXProjectDetailViewModel.h
//  TRZXProjectDetail
//
//  Created by zhangbao on 2017/3/3.
//  Copyright © 2017年 TRZX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TRZXProjectDetailMacro.h"

@interface TRZXProjectDetailViewModel : NSObject

- (UITableViewCell *)cellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;

/**
 存储 cell
 */
@property (nonatomic, strong) NSMutableArray <NSArray <Class> *> *dataArray;

@end
