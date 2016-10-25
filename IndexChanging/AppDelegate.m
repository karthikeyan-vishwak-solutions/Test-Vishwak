//
//  AppDelegate.m
//  IndexChanging
//
//  Created by Dinesh Reddy.C on 9/27/16.
//  Copyright © 2016 Vishwak. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

-(BOOL)date:(NSDate*)date isBetweenDate:(NSDate*)beginDate andDate:(NSDate*)endDate
{
    if ([date compare:beginDate] == NSOrderedAscending)
        return NO;
    if ([date compare:endDate] == NSOrderedDescending)
        return NO;
    return YES;
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
    [dateFormatter1 setDateFormat:@"HH.mm"];
    NSString *strCurrentTime = [dateFormatter1 stringFromDate:[NSDate date]]; NSLog(@"Check float value: %.2f",[strCurrentTime floatValue]);
    if ([strCurrentTime floatValue] >= 18.00 || [strCurrentTime floatValue] <= 6.00){ NSLog(@"It's night time");
    }else{
        NSLog(@"It's day time");
    }
    
    NSDate *today = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"dd-MM-yyyy hh:mm a"];
    NSLocale *twelveHourLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    [formatter setLocale:twelveHourLocale];
    NSLog(@"%@",[formatter stringFromDate:today]);
    NSString *currentstring = [formatter stringFromDate:today];
    NSMutableArray *fromarra = [[currentstring componentsSeparatedByString:@" "] mutableCopy];
    [fromarra replaceObjectAtIndex:1 withObject:@"06:00"];
    [fromarra replaceObjectAtIndex:2 withObject:@"AM"];
    NSString *fromstring = [fromarra componentsJoinedByString:@" "];
    NSDate *fromdate = [formatter dateFromString:fromstring];
    NSMutableArray *toarra = [[currentstring componentsSeparatedByString:@" "] mutableCopy];
    [toarra replaceObjectAtIndex:1 withObject:@"06:00"];
    [toarra replaceObjectAtIndex:2 withObject:@"PM"];
    NSString *tostring = [toarra componentsJoinedByString:@" "];
    NSDate *todate = [formatter dateFromString:tostring];
    // Do any additional setup after loading the view, typically from a nib.
    if ([self date:today isBetweenDate:fromdate andDate:todate])
    {
        NSLog(@"06:00 AM to 06:00 PM");
    }
    else
    {
        NSLog(@"06:00 PM to 06:00 AM");
    }
    // Override point for customization after application launch.
    NSLog(@"%@",[self createSectionWithArtical]);
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
-(NSMutableArray *)createSectionWithArtical{
    int totalSection = 2;
    int tempArticalCount = 0;
    NSMutableDictionary *articalJson;
    NSMutableArray *articalArray;
    NSMutableDictionary *sectionJson;
    NSMutableArray *finalArray = [NSMutableArray array];
    for (int i = 0; i <= totalSection; i++) {
        sectionJson = [NSMutableDictionary dictionary];
        NSMutableDictionary *tempDic = [NSMutableDictionary dictionary];
        [tempDic setObject:[NSString stringWithFormat:@"%d",i] forKey:@"sectionId"];
        if (i == 0) {
            tempArticalCount = 5;
        }else if (i == 1){
            tempArticalCount = 10;
        }else{
           tempArticalCount = 15;
        }
        articalArray =[NSMutableArray array];
        for (int j = 0; j < tempArticalCount; j++) {
            articalJson = [NSMutableDictionary dictionary];
            [articalJson setObject:[NSString stringWithFormat:@"%d",j] forKey:@"articalId"];
            [articalArray addObject:articalJson];
        }
        [tempDic setObject:articalArray forKey:@"articals"];
        [finalArray addObject:tempDic];
    }
    return  finalArray;
}
@end
