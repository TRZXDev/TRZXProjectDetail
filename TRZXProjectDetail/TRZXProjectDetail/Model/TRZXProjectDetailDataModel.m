//
//  TRZXProjectDetailDataModel.m
//  TRZXProjectDetail
//
//  Created by zhangbao on 2017/3/2.
//  Copyright © 2017年 TRZX. All rights reserved.
//

#import "TRZXProjectDetailDataModel.h"

@implementation TRZXProjectDetailDataModel

+(NSDictionary *)replacedKeyFromPropertyName{
    
    return@{
            @"freshCarouselImg": @"newCarouselImg"
            };
    
}

+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"teamList" : @"TRZXProjectDetailDataTeamModel",
             @"dynamicList"     : @"TRZXProjectDetailDataDynamicModel"
             };
}

@end

@implementation TRZXProjectDetailDataProjectFinancingModel

@end

@implementation TRZXProjectDetailDataTeamModel

@end

@implementation TRZXProjectDetailDataDynamicModel

@end

