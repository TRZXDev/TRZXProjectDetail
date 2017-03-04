//
//  TRZXCellConfig.m
//  TRZXProjectDetail
//
//  Created by zhangbao on 2017/3/4.
//  Copyright © 2017年 TRZX. All rights reserved.
//

#import "TRZXCellConfig.h"

//判断selector有几个参数
static NSUInteger SelectorArgumentCount(SEL selector)
{
    NSUInteger argumentCount = 0;
    //sel_getName获取selector名的C字符串
    const char *selectorStringCursor = sel_getName(selector);
    char ch;
    //    遍历字符串有几个:来确定有几个参数
    while((ch = *selectorStringCursor)) {
        if(ch == ':') {
            ++argumentCount;
        }
        ++selectorStringCursor;
    }
    
    return argumentCount;
}

@interface  NSObject(ZBPerformingObjects)
- (void)zb_performSelector:(SEL)aSelector withObjects:(NSArray *)objects;
@end

@implementation NSObject(ZBPerformingObjects)

- (void)zb_performSelector:(SEL)aSelector withObjects:(NSArray *)objects
{
    // 签名
    NSMethodSignature *signature = [[self class] instanceMethodSignatureForSelector:aSelector];
    if (signature == nil) {
        NSAssert(false, @"LINE=%d ERROR - 找不到 %@ 方法", __LINE__ ,NSStringFromSelector(aSelector));
    }
    // 包装
    NSInvocation *invocation  = [NSInvocation invocationWithMethodSignature:signature];
    // 设置调用者
    [invocation setTarget:self];
    // 设置调用的方法 与 NSMethodSignature 签名的方法一致
    [invocation setSelector:aSelector];
    // 0为target 1为_cmd 所以从2索引
    for (int i = 0; i < (signature.numberOfArguments - 2); i++) {
        id dataModel = i < objects.count ? objects[i] : nil;
        [invocation setArgument:&dataModel atIndex:i+2];
    }
    // retain 所有参数，防止释放
    [invocation retainArguments];
    [invocation invoke];
}

@end

@implementation TRZXCellConfig

// 便利构造器
+ (instancetype)cellConfigWithClass:(Class)cellClass
                     showInfoMethod:(SEL)showInfoMethod
{
    TRZXCellConfig *cellConfig = [[TRZXCellConfig alloc] init];
    
    cellConfig.cellClass = cellClass;

    cellConfig.showInfoMethod = showInfoMethod;
    
    return cellConfig;
}

// 根据cellConfig生成cell
- (UITableViewCell *)cellOfCellConfigWithTableView:(UITableView *)tableView
                                        dataModels:(NSArray *)dataModels
{
    return [self cellOfCellConfigWithTableView:tableView dataModels:dataModels isNib:NO];
}

// 根据cellConfig生成cell,可使用Nib
- (UITableViewCell *)cellOfCellConfigWithTableView:(UITableView *)tableView
                                        dataModels:(NSArray *)dataModels
                                             isNib:(BOOL)isNib
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[self cellID]];
    
    if (!cell) {
        
        // 加载nib的方法
        if (isNib && ![self.cellClass isSubclassOfClass:[UITableViewCell class]]) {
            NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self.cellClass) owner:nil options:nil];
            
            for (id obj in nibs) {
                if ([obj isKindOfClass: self.cellClass]) {
                    cell = obj;
                }
            }
            
            if (!cell) {
                NSLog(@"Please Check Nib File About %@", NSStringFromClass(self.cellClass));
            }
            
        } else {
            
            cell = [[self.cellClass?:[UITableViewCell class] alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:[self cellID]];
            
        }
    }
    
    // 设置cell
    if (self.showInfoMethod && [cell respondsToSelector:self.showInfoMethod]) {
        
        [cell zb_performSelector:self.showInfoMethod withObjects:dataModels];
    }
    
    return cell;
}

// 获取当前cell ID
- (NSString *)cellID
{
    if (self.reuseID.length) {
        return self.reuseID;
    }
    return NSStringFromClass(self.cellClass);
}


@end


