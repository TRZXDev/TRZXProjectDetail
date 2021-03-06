//
//  ViewController.m
//  TRZXProjectDetail
//
//  Created by zhangbao on 2017/3/2.
//  Copyright © 2017年 TRZX. All rights reserved.
//

#import "ViewController.h"
#import "Target_TRZXProjectDetail.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor purpleColor];
    
    UILabel *projectListLabel = [[UILabel alloc] init];
    projectListLabel.frame = self.view.bounds;
    projectListLabel.text = @"项目列表";
    projectListLabel.textAlignment = NSTextAlignmentCenter;
    projectListLabel.font = [UIFont boldSystemFontOfSize:18];
    projectListLabel.textColor = [UIColor cyanColor];
    projectListLabel.userInteractionEnabled = NO;
    
    [self.view addSubview:projectListLabel];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    Target_TRZXProjectDetail *target = [Target_TRZXProjectDetail new];
    UIViewController *projectDetail_vc = [target Action_ProjectDetailViewController:@{@"projectId":@"6b8a7de6e8984200857917237bbdfe1f"}];
    
    [self.navigationController pushViewController:projectDetail_vc animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
