//
//  DataUploader.m
//  Scenic
//
//  Created by Dan Lynch on 4/24/11.
//  Copyright 2011 UC Berkeley. All rights reserved.
//

#import "DataUploader.h"
#import "UserPhotoContent.h"

static NSString* base = @"http://www.scenicgps.com/scenic/uploadphoto";

@implementation DataUploader

-(void) uploadUserContent: (UserPhotoContent*) content {
    NSString* title = [content.title stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    double lat = [content.coord.lat doubleValue];
    double lng = [content.coord.lng doubleValue];
    NSString* deviceID = [[UIDevice currentDevice] uniqueIdentifier];
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?title=%@&lat=%f&lng=%f&deviceid=%@&trueheading=%f&magheading=%f", base, title, lat, lng, deviceID, content.heading.trueHeading, content.heading.magneticHeading]];
    ASIFormDataRequest* request = [ASIFormDataRequest requestWithURL:url];
    NSData * imageData = UIImagePNGRepresentation(content.photo);
    NSData * iconData = UIImagePNGRepresentation([content fetchIcon]);
    [request addData:imageData withFileName:@"image.png" andContentType:@"image/png" forKey:@"image"];
    [request addData:iconData withFileName:@"icon.png" andContentType:@"image/png" forKey:@"icon"];
    NSLog(@"%@", [request.url description]);
    
    request.delegate = self;
    [request startAsynchronous];
    NSLog(@"upload attempt");
}

-(void) uploadUserContent: (UserPhotoContent*) content withVideo: (NSURL*) video {
    NSString* title = [content.title stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    double lat = [content.coord.lat doubleValue];
    double lng = [content.coord.lng doubleValue];
    NSString* deviceID = [[UIDevice currentDevice] uniqueIdentifier];
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?title=%@&lat=%f&lng=%f&deviceid=%@&trueheading=%f&magheading=%f", base, title, lat, lng, deviceID, content.heading.trueHeading, content.heading.magneticHeading]];
    ASIFormDataRequest* request = [ASIFormDataRequest requestWithURL:url];
    NSData * data = [[NSData alloc] initWithContentsOfURL:video];
    [request addData:data withFileName:@"movie.mov" andContentType:@"application/octet-stream" forKey:@"image"];
    
    NSData * iconData = UIImagePNGRepresentation([content fetchIcon]);
    [request addData:iconData withFileName:@"icon.png" andContentType:@"image/png" forKey:@"icon"];
    
    request.delegate = self;
    [request startAsynchronous];
    NSLog(@"upload attempt");
}

- (void)requestFinished:(ASIHTTPRequest *)request {
    NSLog(@"request finished!");
}

- (void)requestStarted:(ASIHTTPRequest *)request {
    NSLog(@"req started");
}

- (void)requestFailed:(ASIHTTPRequest *)request {
    NSLog(@"failed");
}

@end
