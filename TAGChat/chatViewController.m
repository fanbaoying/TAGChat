//
//  chatViewController.m
//  TAGChat
//
//  Created by 范保莹 on 2017/3/7.
//  Copyright © 2017年 TAG. All rights reserved.
//

#import "chatViewController.h"

#import "Nav.h"

@interface chatViewController ()

@property(strong,nonatomic)Nav *nav;

@end

@implementation chatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
   
//    self.nav = [[Nav alloc]initWithTitle:self.title bgImg:nil leftBtn:@"backfinal" rightBtn:nil];
    self.nav = [[Nav alloc]initWithLeftBtn:@"backfinal" andWithTitleLab:self.title andWithRightBtn:nil andWithBgImg:nil andWithLab1Btn:nil andWithLab2Btn:nil];
    [self.nav.leftBtn  addTarget:self action:@selector(leftaction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_nav];
}

-(void)leftaction:(UIButton * )sender{
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
    
}

//点击头像事件
- (void)didTapCellPortrait:(NSString *)userId{
//    NSUserDefaults *SQUserid = [NSUserDefaults standardUserDefaults];
//    NSString *squserid = [SQUserid objectForKey:@"userid"];
//    if ([userId isEqualToString:squserid]) {
//        SelfDetailViewController *vc=[[SelfDetailViewController alloc]init];
//        
//        [self presentViewController:vc animated:YES completion:nil];
//    }else{
//        OtherDetailViewController *vc=[[OtherDetailViewController alloc]init];
//        vc.otherUserid =userId;
//        [self presentViewController:vc animated:YES completion:nil];
//    }
    
}

@end
