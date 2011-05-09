//
//  ScenicAppDelegate.m
//  Scenic
//
//  Created by Jack Reilly on 3/2/11.
//  Copyright 2011 UC Berkeley. All rights reserved.
//

#import "ScenicAppDelegate.h"
#import "CDHelper.h"
#import "Reachability.h"

@implementation ScenicAppDelegate
@synthesize tabVC;

@synthesize window=_window;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{   
    // Override point for customization after application launch.
    self.window.rootViewController = tabVC;
    [self.window makeKeyAndVisible];


    
    return YES;
    

}

- (void)navigationController:(UINavigationController *)navigationController 
      willShowViewController:(UIViewController *)viewController animated:(BOOL)animated 
{
    [viewController viewWillAppear:animated];
}

- (void)navigationController:(UINavigationController *)navigationController 
       didShowViewController:(UIViewController *)viewController animated:(BOOL)animated 
{
    [viewController viewDidAppear:animated];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
    

    
//    Reachability * reach = [Reachability reachabilityForInternetConnection];
//
//    
//    if ([reach isReachable]) {
//        
//        NSURL * url = [[[NSURL alloc] initWithString:@"http://www.scenicgps.com/scenic/"] autorelease];
//        NSURLRequest * req = [[[NSURLRequest alloc] initWithURL:url] autorelease];
//        NSError *theError = NULL;
//        NSURLResponse *theResponse = NULL;
//        NSData *theResponseData = [NSURLConnection sendSynchronousRequest:req returningResponse:&theResponse error:&theError];
//        NSString *theResponseString = [[[NSString alloc] initWithData:theResponseData encoding:NSUTF8StringEncoding] autorelease];
//    
//
//        if ('{' != [theResponseString characterAtIndex:0]) {
//            
//            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Connection" message:@"You are not connected" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
//            [alert show];
//            [alert release];
//            
//        }
//        
//    } else {
//        
//        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Connection" message:@"Network is not reachable" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
//        [alert show];
//        [alert release];    
//    }
    
    
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

- (void)dealloc
{
    [_window release];
    [tabVC release];
    [super dealloc];
}


@end
