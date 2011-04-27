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

- (void) uploadImage: (UIImage*) image {
    NSURL * url = [[[NSURL alloc] initWithString:@"http://www.scenicgps.com/scenic/uploadphoto?title=asdfasdfas&lat=32.3&lng=55.5&deviceid=23423432423"] autorelease];
    ASIFormDataRequest* request = [ASIFormDataRequest requestWithURL:url];
    NSData * imageData = UIImagePNGRepresentation(image);
    [request addData:imageData withFileName:@"a.png" andContentType:@"image/png" forKey:@"image"];
    
    request.delegate = self;
    [request startAsynchronous];
    NSLog(@"upload attempt");
}

-(void) uploadUserContent: (UserPhotoContent*) content {
    NSString* title = [content.title stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    double lat = [content.coord.lat doubleValue];
    double lng = [content.coord.lng doubleValue];
    NSString* deviceID = [[UIDevice currentDevice] uniqueIdentifier];
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?title=%@&lat=%f&lng=%f&deviceid=%@", base, title, lat, lng, deviceID]];
    ASIFormDataRequest* request = [ASIFormDataRequest requestWithURL:url];
    NSData * imageData = UIImagePNGRepresentation(content.photo);
    [request addData:imageData withFileName:@"a.png" andContentType:@"image/png" forKey:@"image"];
    request.delegate = self;
    [request startAsynchronous];
    NSLog(@"upload attempt");
}

-(void) uploadUserContent: (UserPhotoContent*) content withVideo: (NSURL*) video {
    NSString* title = [content.title stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    double lat = [content.coord.lat doubleValue];
    double lng = [content.coord.lng doubleValue];
    NSString* deviceID = [[UIDevice currentDevice] uniqueIdentifier];
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?title=%@&lat=%f&lng=%f&deviceid=%@", base, title, lat, lng, deviceID]];
    ASIFormDataRequest* request = [ASIFormDataRequest requestWithURL:url];
    NSData * data = [[NSData alloc] initWithContentsOfURL:video];
    [request addData:data withFileName:@"movie.mov" andContentType:@"application/octet-stream" forKey:@"image"];
    request.delegate = self;
    [request startAsynchronous];
    NSLog(@"upload attempt");
}

- (void) uploadFile: (NSURL*) file {    
    NSURL * url = [[[NSURL alloc] initWithString:@"http://www.dan-lynch.com/upload.php"] autorelease];
    ASIFormDataRequest* request = [ASIFormDataRequest requestWithURL:url];
    NSData * data = [[NSData alloc] initWithContentsOfURL:file];
    [request addData:data withFileName:@"test.mov" andContentType:@"application/octet-stream" forKey:@"uploadedfile"];  
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
