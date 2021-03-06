//
//  UMSWhatTableViewController.m
//  SocialSDK
//
//  Created by umeng on 16/4/25.
//  Copyright © 2016年 dongjianxiong. All rights reserved.
//

#import "UMSUserInfoTableViewController.h"
#import <UMSocialCore/UMSocialCore.h>

#define UMSUserInfoPlatformTypeKey @"UMSUserInfoPlatformTypeKey"
#define UMSUserInfoPlatformNameKey @"UMSUserInfoPlatformNameKey"
#define UMSUserInfoPlatformIconNameKey @"UMSUserInfoPlatformIconNameKey"
@interface UMSUserInfoTableViewController ()

@property (nonatomic, strong) NSMutableArray *platformInfoArray;

@end

@implementation UMSUserInfoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.platformInfoArray = [NSMutableArray arrayWithCapacity:10];

    NSArray *paltformTypeArray = [NSArray arrayWithObjects:@(UMSocialPlatformType_Sina),@(UMSocialPlatformType_WechatSession),@(UMSocialPlatformType_QQ),@(UMSocialPlatformType_Facebook),@(UMSocialPlatformType_Twitter),@(UMSocialPlatformType_Linkedin), nil];
    
    for (NSNumber *platformType in paltformTypeArray) {
        NSMutableDictionary *dict = [self dictWithPlatformName:platformType];
        [dict setValue:platformType forKey:UMSUserInfoPlatformTypeKey];
        if (dict) {
            [self.platformInfoArray addObject:dict];
        }
    }
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (NSMutableDictionary *)dictWithPlatformName:(NSNumber *)platformType
{
    UMSocialPlatformType platformType_int = [platformType integerValue];
    NSString *imageName = nil;
    NSString *paltFormName = nil;
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithCapacity:1];
    switch (platformType_int) {
        case UMSocialPlatformType_Sina:
            imageName = @"UMS_sina_icon";
            paltFormName = @"新浪";
            break;
        case UMSocialPlatformType_WechatSession:
            imageName = @"UMS_wechat_icon";
            paltFormName = @"微信";
            break;
        case UMSocialPlatformType_QQ:
            imageName = @"UMS_qq_icon";
            paltFormName = @"QQ";
            break;
        case UMSocialPlatformType_Facebook:
            imageName = @"UMS_facebook_icon";
            paltFormName = @"Facebook";
            break;
        case UMSocialPlatformType_Twitter:
            imageName = @"UMS_twitter_icon";
            paltFormName = @"Twitter";
            break;

        case UMSocialPlatformType_Linkedin:
            imageName = @"UMS_linkedin_icon";
            paltFormName = @"Linkedin";
            break;
            
        default:
            break;
    }
    [dict setValue:UMSocialPlatformIconWithName(imageName) forKey:UMSUserInfoPlatformIconNameKey];
    [dict setValue:paltFormName forKey:UMSUserInfoPlatformNameKey];
    return dict;
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.platformInfoArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    NSDictionary *dict = self.platformInfoArray[indexPath.row];
    cell.textLabel.text = [dict objectForKey:UMSUserInfoPlatformNameKey];
    // Configure the cell...
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *dict = self.platformInfoArray[indexPath.row];
    UMSocialPlatformType platformType = [[dict objectForKey:UMSUserInfoPlatformTypeKey] integerValue];
    
    //如果需要获得用户信息直接跳转的话，需要先取消授权
    //step1 取消授权
    [[UMSocialManager defaultManager] cancelAuthWithPlatform:platformType completion:^(id result, NSError *error) {
        
        //step2 获得用户信息(获得用户信息中包含检查授权的信息了)
        [[UMSocialManager defaultManager] getUserInfoWithPlatform:platformType currentViewController:self completion:^(id result, NSError *error) {
            
            NSString *message = nil;
            
            if (error) {
                message = @"Get user info fail";
                NSLog(@"Get user info fail with error %@",error);
            }else{
                if ([result isKindOfClass:[UMSocialUserInfoResponse class]]) {
                    UMSocialUserInfoResponse *resp = result;
                    // 授权信息
                    NSLog(@"UserInfoAuthResponse uid: %@", resp.uid);
                    NSLog(@"UserInfoAuthResponse accessToken: %@", resp.accessToken);
                    NSLog(@"UserInfoAuthResponse refreshToken: %@", resp.refreshToken);
                    NSLog(@"UserInfoAuthResponse expiration: %@", resp.expiration);
                    
                    // 用户信息
                    NSLog(@"UserInfoResponse name: %@", resp.name);
                    NSLog(@"UserInfoResponse iconurl: %@", resp.iconurl);
                    NSLog(@"UserInfoResponse gender: %@", resp.gender);
                    
                    // 第三方平台SDK源数据,具体内容视平台而定
                    NSLog(@"OriginalUserProfileResponse: %@", resp.originalResponse);
                    
                    message = [NSString stringWithFormat:@"name: %@\n icon: %@\n gender: %@\n",resp.name,resp.iconurl,resp.gender];
                }else{
                    message = @"Get user info fail";
                    NSLog(@"Get user info fail with  unknow error");
                }
            }
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"UserInfo"
                                                            message:message
                                                           delegate:nil
                                                  cancelButtonTitle:NSLocalizedString(@"sure", @"确定")
                                                  otherButtonTitles:nil];
            [alert show];
        }];
    }];
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
