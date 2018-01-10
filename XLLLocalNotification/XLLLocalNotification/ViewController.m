//
//  ViewController.m
//  XLLLocalNotification
//
//  Created by 肖乐 on 2018/1/10.
//  Copyright © 2018年 IMMoveMobile. All rights reserved.
//

#import "ViewController.h"
#import <UserNotifications/UserNotifications.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)pushBtnClick:(id)sender {
    
    // 10系统以上
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0)
    {
        // 1.设置触发条件
        UNTimeIntervalNotificationTrigger *timeTrigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:.5f repeats:NO];
        // 2.创建通知内容
        UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
        content.body = @"我是小明";
        content.badge = @([UIApplication sharedApplication].applicationIconBadgeNumber + 1);
        content.sound = [UNNotificationSound defaultSound];
        NSString *detail = @"其实他是假小明";
        content.userInfo = @{
                             @"detail":detail
                             };
        // 3.通知标识
        NSString *requestIdentifier = [NSString stringWithFormat:@"%lf", [[NSDate date] timeIntervalSince1970]];
        // 4.创建通知请求，将1，2，3添加到请求中
        UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:requestIdentifier content:content trigger:timeTrigger];
        // 5.将通知请求添加到通知中心
        [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
           
            if (!error)
            {
                NSLog(@"推送已经添加成功");
            }
        }];
    } else { // iOS10以下
        
        UILocalNotification *notification = [[UILocalNotification alloc] init];
        notification.alertBody = @"我是小明";
        notification.applicationIconBadgeNumber = [UIApplication sharedApplication].applicationIconBadgeNumber + 1;
        notification.soundName = UILocalNotificationDefaultSoundName;
        NSString *detail = @"其实他是假小明";
        notification.userInfo = @{
                                  @"detail":detail
                                  };
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            // 执行此代码之前进入后台
            [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
        });
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
