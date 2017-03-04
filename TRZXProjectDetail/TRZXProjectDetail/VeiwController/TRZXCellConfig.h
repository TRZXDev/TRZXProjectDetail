//
//  TRZXCellConfig.h
//  TRZXProjectDetail
//
//  Created by zhangbao on 2017/3/4.
//  Copyright © 2017年 TRZX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TRZXCellConfig : NSObject

/**
 cell类
 */
@property (nonatomic, assign) Class cellClass;

/**
 标题 - 如“我的订单”，对不同种cell进行不同设置时，可以通过 其对应的 cellConfig.title 进行判断
 */
@property (nonatomic, strong) NSString *title;

/**
 cell 显示数据模型的方法
 */
@property (nonatomic, assign) SEL showInfoMethod;

/**
 指定重用ID，默认使用类名座位重用ID
 */
@property (nonatomic, strong) NSString *reuseID;


/**
 便利构造器

 @param cellClass cell类
 @param showInfoMethod 显示数据模型的方法
 @return 返回cell精灵
 */
+ (instancetype)cellConfigWithClass:(Class)cellClass
                     showInfoMethod:(SEL)showInfoMethod;

/**
 根据cellConfig生成cell

 @param tableView tableView
 @param dataModels 数据模型
 @return cell
 */
- (UITableViewCell *)cellOfCellConfigWithTableView:(UITableView *)tableView
                                        dataModels:(NSArray *)dataModels;

/**
 根据cellConfig生成cell,可使用Nib
 
 @param tableView tableView
 @param dataModels 数据模型
 @param isNib 是否为xib加载
 @return cell
 */
- (UITableViewCell *)cellOfCellConfigWithTableView:(UITableView *)tableView
                                        dataModels:(NSArray *)dataModels
                                             isNib:(BOOL)isNib;

@end
