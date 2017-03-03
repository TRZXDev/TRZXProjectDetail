//
//  TRZXProjectDetailTableViewHeaderView.m
//  TRZXProjectDetail
//
//  Created by zhangbao on 2017/3/3.
//  Copyright © 2017年 TRZX. All rights reserved.
//

#import "TRZXProjectDetailTableViewHeaderView.h"
#import "TRZXProjectDetailMacro.h"

@interface TRZXProjectDetailTableViewHeaderView()

@property (nonatomic, strong) UIImageView *backGroundImageView;

@end

@implementation TRZXProjectDetailTableViewHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
//        self.clipsToBounds = YES;
        
        [self addOwnViews];
        
        [self layoutFrameOfSubViews];
        
    }
    return self;
}

- (void)addOwnViews
{
    [self addSubview:self.backGroundImageView];
}

- (void)layoutFrameOfSubViews
{
    [_backGroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}

#pragma mark - <Public-Method>
- (void)makeBackGroundImageScaleOfScrollViewDidScroll:(CGFloat)offset
{
    CGRect rect = self.frame;
    rect.origin.y = offset;
    rect.size.height = CGRectGetHeight(rect) - offset;
    self.backGroundImageView.frame = rect;
}

#pragma mark - <Setter/Getter>
- (UIImageView *)backGroundImageView
{
    if (!_backGroundImageView) {
        _backGroundImageView = [[UIImageView alloc] init];
        _backGroundImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        _backGroundImageView.clipsToBounds = YES;
        _backGroundImageView.contentMode = UIViewContentModeScaleAspectFill;
        _backGroundImageView.image = [UIImage imageNamed:@"testIcon_backGroundImage"];
    }
    return _backGroundImageView;
}

@end
