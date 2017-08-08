//
//  ViewController.m
//  TAGChat
//
//  Created by 范保莹 on 2017/3/7.
//  Copyright © 2017年 TAG. All rights reserved.
//

#import "ViewController.h"
#import <RongIMKit/RongIMKit.h>

#import "YourTestChatViewController.h"

//网络请求
#import "AFNetworking.h"

#import "Nav.h"


#define SCREEN_WIDHN [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
@interface ViewController ()

@property(strong,nonatomic)Nav *nav;

@property(strong,nonatomic)UIButton *myBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    self.nav = [[Nav alloc]initWithLeftBtn:nil andWithTitleLab:@"消息" andWithRightBtn:nil andWithBgImg:nil andWithLab1Btn:nil andWithLab2Btn:nil];
    [self.view addSubview:_nav];
    
    self.myBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, 200, SCREEN_WIDHN-40, 35)];
    self.myBtn.backgroundColor = [UIColor purpleColor];
    [self.myBtn addTarget:self action:@selector(myBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_myBtn];
    
    
}

- (void)myBtn:(UIButton *)sender{

    YourTestChatViewController *ytcvc = [[YourTestChatViewController alloc]init];
    
    [self.navigationController pushViewController:ytcvc animated:YES];
    
}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *urlstr =@"https://api.cn.rong.io/user/getToken.json";
    NSDictionary *dic =@{@"userId":@"123456",
                         @"name":@"123456",
                         @"portraitUri":@"head"
                         };
    
    NSString * timestamp = [[NSString alloc] initWithFormat:@"%ld",(NSInteger)[NSDate timeIntervalSinceReferenceDate]];
    NSString * nonce = [NSString stringWithFormat:@"%d",arc4random()];
    NSString * appkey = @"tdrvipkstfg75";
//    NSString * Signature = [[NSString stringWithFormat:@"%@%@%@",appkey,nonce,timestamp] sha1String];//用sha1对签名进行加密,随你用什么方法,MD5...
    NSString * Signature = [NSString stringWithFormat:@"%@%@%@",appkey,nonce,timestamp];
    //以下拼接请求内容
    [manager.requestSerializer setValue:appkey forHTTPHeaderField:@"App-Key"];
    [manager.requestSerializer setValue:nonce forHTTPHeaderField:@"Nonce"];
    [manager.requestSerializer setValue:timestamp forHTTPHeaderField:@"Timestamp"];
    [manager.requestSerializer setValue:Signature forHTTPHeaderField:@"Signature"];
    [manager.requestSerializer setValue:@"ukp8a1lTog" forHTTPHeaderField:@"appSecret"];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    //开始请求
    [manager POST:urlstr parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //这里你就能得到token啦~
        NSLog(@"%@", responseObject);
        
        [[RCIM sharedRCIM] initWithAppKey:@"tdrvipkstfg75"];
        
        [[RCIM sharedRCIM] connectWithToken:[responseObject objectForKey:@"token"] success:^(NSString *userId) {
            NSLog(@"登陆成功。当前登录的用户ID：%@", userId);
        } error:^(RCConnectErrorCode status) {
            NSLog(@"登陆的错误码为:%ld", (long)status);
        } tokenIncorrect:^{
            //token过期或者不正确。
            //如果设置了token有效期并且token过期，请重新请求您的服务器获取新的token
            //如果没有设置token有效期却提示token错误，请检查您客户端和服务器的appkey是否匹配，还有检查您获取token的流程。
            NSLog(@"token错误");
        }];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
