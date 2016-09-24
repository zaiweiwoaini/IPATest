//
//  ViewController.m
//  IPATest
//
//  Created by zaiwei on 16/9/24.
//  Copyright © 2016年 zaiwei. All rights reserved.
//

#import "ViewController.h"
#import "MBProgressHUD.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
button.frame=CGRectMake(100, 100, 100, 100);
button.backgroundColor=[UIColor redColor];
[self.view addSubview:button];
[button addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
}
-(void)click{
    __weak typeof(self) weakSelf = self;
    [MBProgressHUD showHUDAddedTo:weakSelf.view animated:YES];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
    });
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
