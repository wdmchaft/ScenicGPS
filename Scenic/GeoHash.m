//
//  GeoHash.m
//  Scenic
//
//  Created by Dan Lynch on 3/11/11.
//  Copyright 2011 UC Berkeley. All rights reserved.
//

#import "GeoHash.h"

// Geohash code from
// http://www.cocoalife.net/2010/01/post_485.html

NSUInteger binary_to_int(NSString *input) {
    NSUInteger result, length;
    result = 0;
    length = [input length];
    for (NSUInteger i = 0; i < length; ++i) {
        if ([input characterAtIndex:i] == '1') {
            result += pow(2, length - i - 1);
        }
    }
    return result;
}

NSString * generate_binary(double input, double max, double min, int cutoff) {
    NSMutableString     *result;
    double              mid;
    result = [NSMutableString string];
    for (int i = 0; i < cutoff; ++i) {
        mid = (max + min) / 2;
        if (input > mid) {
            [result appendString:@"1"];
            min = mid;
        } else {
            [result appendString:@"0"];
            max = mid;
        }
    }
    return [NSString stringWithString:result];
}

@implementation GeoHash

+ (NSString *) hash : (CLLocationCoordinate2D) coord {
    
    int cutoff = 32;
    
    NSString *base32_characters  = @"0123456789bcdefghjkmnpqrstuvwxyz";
    NSString            *bin_lat, *bin_lng;
    NSMutableString     *bin_packed, *result;
    bin_lat = generate_binary(coord.latitude, 90.0, -90.0, cutoff);
    bin_lng = generate_binary(coord.longitude, 180.0, -180.0, cutoff);
    bin_packed = [NSMutableString string];
    for (int i = 0; i < [bin_lat length]; ++i) {
        [bin_packed appendFormat:@"%c%c", [bin_lng characterAtIndex:i], [bin_lat characterAtIndex:i]];
    }
    result = [NSMutableString string];

    for (int i = 0; i < [bin_packed length] / 5; ++i) {
        NSUInteger index;
        index = binary_to_int([bin_packed substringWithRange:NSMakeRange(i * 5, 5)]);
        [result appendFormat:@"%c", [base32_characters characterAtIndex:index]];
    }
 
    NSLog(@"Just hashed (%f, %f) to %@", coord.latitude, coord.longitude, result);
    
    return result;
    
}


@end
