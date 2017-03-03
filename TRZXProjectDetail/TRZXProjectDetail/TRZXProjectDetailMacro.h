//
//  TRZXProjectDetailMacro.h
//  TRZXProjectDetail
//
//  Created by zhangbao on 2017/3/3.
//  Copyright © 2017年 TRZX. All rights reserved.
//

#ifndef TRZXProjectDetailMacro_h
#define TRZXProjectDetailMacro_h

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>
#import <TRZXKit/TRZXKit.h>
#import <MJExtension/MJExtension.h>
#import <TRZXKit/TRZXKit.h>

#define kTRZXBGrayColor [UIColor colorWithRed:240.0/255.0 green:239.0/255.0 blue:244.0/255.0 alpha:1]

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)

#define kProjectDetailTableViewHeaderViewHeight (SCREEN_WIDTH*3)/4
#define kProjectDetailNavigationViewHeight 64

typedef enum : NSUInteger {
    ETableViewSection_ProjectBaseHeader,
    ETableViewSection_ProjectBaseSubInfo,
    ETableViewSection_ProjectFinancingInfo,
    ETableViewSection_ProjectDetail,
    
} ETableViewSection;

#endif /* TRZXProjectDetailMacro_h */