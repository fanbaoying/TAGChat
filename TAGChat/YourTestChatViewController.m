//
//  YourTestChatViewController.m
//  TAGChat
//
//  Created by 范保莹 on 2017/3/7.
//  Copyright © 2017年 TAG. All rights reserved.
//

#import "YourTestChatViewController.h"
#import "chatViewController.h"

#import "Nav.h"

#import "FriendTableViewController.h"

#define SCREEN_WIDHN [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface YourTestChatViewController ()

@property(strong,nonatomic)Nav *nav;

@end

@implementation YourTestChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    //给页面添加手势
    UISwipeGestureRecognizer *swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGesture:)];
//    设置轻扫的方向
    swipeGesture.direction = UISwipeGestureRecognizerDirectionRight; //向右
    [self.view addGestureRecognizer:swipeGesture];
    
    
    //导航栏
    
    self.nav = [[Nav alloc]initWithLeftBtn:@"backfinal" andWithTitleLab:@"消息" andWithRightBtn:@"friendlist" andWithBgImg:nil andWithLab1Btn:nil andWithLab2Btn:nil];
                
                
//                initWithTitle:@"消息" bgImg:nil leftBtn:@"backfinal" rightBtn:@"friendlist"];
    [self.nav.leftBtn  addTarget:self action:@selector(leftaction:) forControlEvents:UIControlEventTouchUpInside];
    [self.nav.rightBtn  addTarget:self action:@selector(rightaction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_nav];
    
    //    self.navigationController.navigationBar.hidden=NO;
    
    //    设置需要显示哪些类型的会话
    self.conversationListTableView.frame=CGRectMake(0, 64,SCREEN_WIDHN , SCREEN_HEIGHT-64);
    [self setDisplayConversationTypes:@[@(ConversationType_PRIVATE),
                                        @(ConversationType_DISCUSSION),
                                        @(ConversationType_CHATROOM),
                                        @(ConversationType_GROUP),
                                        @(ConversationType_APPSERVICE),
                                        @(ConversationType_SYSTEM)]];
    //设置需要将哪些类型的会话在会话列表中聚合显示
    [self setCollectionConversationType:@[@(ConversationType_DISCUSSION),
                                          @(ConversationType_GROUP)]];
    
}

//重写RCConversationListViewController的onSelectedTableRow事件
- (void)onSelectedTableRow:(RCConversationModelType)conversationModelType
         conversationModel:(RCConversationModel *)model
               atIndexPath:(NSIndexPath *)indexPath {
    chatViewController *conversationVC = [[chatViewController alloc]init];
    
    conversationVC.conversationType = model.conversationType;
    conversationVC.targetId = model.targetId;
    conversationVC.title=model.conversationTitle ;
    
    
    //     MyNav *nav = [[MyNav alloc]initWithTitle:@"消息" bgImg:nil leftBtn:@"envelopefinal" rightBtn:@"addfinal"];
    
    [self.navigationController pushViewController:conversationVC animated:YES];
}
//轻扫手势触发方法
-(void)swipeGesture:(id)sender
{
    UISwipeGestureRecognizer *swipe = sender;
    
    if (swipe.direction == UISwipeGestureRecognizerDirectionRight)
    {
//        self.tabBarController.tabBar.hidden=NO;
//        AppDelegate * appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
//        appDelegate.mid.hidden = NO;
//        appDelegate.mids.hidden=NO;
        
        [self.navigationController popViewControllerAnimated:YES];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
//左右按钮事件
-(void)leftaction:(UIButton * )sender{
    
    [self.navigationController popViewControllerAnimated:YES];
    //显示下方TARBAR
    //
//    self.tabBarController.tabBar.hidden=NO;
//    AppDelegate * appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
//    appDelegate.mid.hidden = NO;
//    appDelegate.mids.hidden=NO;
}
-(void)rightaction:(UIButton *)sender{
    
    FriendTableViewController *fc=[[FriendTableViewController alloc]init];
    
    [self.navigationController pushViewController:fc animated:YES];
    
    
}
@end
