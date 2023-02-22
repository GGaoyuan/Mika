//
//  AppDelegate.m
//  Mika
//
//  Created by gaoyuan on 2023/2/22.
//

#import "AppDelegate.h"
#import "Mika-Bridging-Header.h"
#import "Mika-Swift.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    HomeViewController *homeViewController = [[HomeViewController alloc] init];
    self.window.rootViewController = homeViewController;
    [self.window makeKeyAndVisible];
    
    return YES;
}



@end
