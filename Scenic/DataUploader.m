//
//  DataUploader.m
//  Scenic
//
//  Created by Dan Lynch on 4/24/11.
//  Copyright 2011 UC Berkeley. All rights reserved.
//

#import "DataUploader.h"
#import "UserPhotoContent.h"
#import "CJSONDeserializer.h"

static NSString* base = @"http://www.scenicgps.com/scenic/uploadphoto";

@implementation DataUploader
@synthesize content;

-(void) uploadUserContent: (UserPhotoContent*) _content {
    self.content = _content;
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

-(void) uploadUserContent: (UserPhotoContent*) _content withVideo: (NSURL*) video {
    self.content = _content;
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
    NSData* data = [request responseData];
    CJSONDeserializer* deserializer = [CJSONDeserializer deserializer];
    NSDictionary* dic = [deserializer deserializeAsDictionary:data error:nil];
    int pk = [(NSNumber*) [dic objectForKey: @"pk"] intValue];
    self.content.pk = pk;
}

- (void)requestStarted:(ASIHTTPRequest *)request {
    NSLog(@"req started");
}

- (void)requestFailed:(ASIHTTPRequest *)request {
    NSLog(@"failed");
}

@end
