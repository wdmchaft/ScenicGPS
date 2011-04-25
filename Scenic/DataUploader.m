//
//  DataUploader.m
//  Scenic
//
//  Created by Dan Lynch on 4/24/11.
//  Copyright 2011 UC Berkeley. All rights reserved.
//

#import "DataUploader.h"


@implementation DataUploader

- (void) uploadImage: (UIImage*) image {
    NSURL * url = [[[NSURL alloc] initWithString:@"http://www.dan-lynch.com/upload.php"] autorelease];
    ASIFormDataRequest* request = [ASIFormDataRequest requestWithURL:url];
    NSData * imageData = UIImagePNGRepresentation(image);
    [request addData:imageData withFileName:@"image.png" andContentType:@"image/png" forKey:@"uploadedfile"];
    //[request addPostValue:@"122" forKey:@"lat"];
    //[request addPostValue:@"122" forKey:@"lng"];
    
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
