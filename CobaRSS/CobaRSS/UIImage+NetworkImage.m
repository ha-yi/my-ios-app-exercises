//
//  UIImage+NetworkImage.m
//  CobaRSS
//
//  Created by MSCI on 2/14/14.
//  Copyright (c) 2014 SRIN. All rights reserved.
//

#import "UIImage+NetworkImage.h"

@implementation UIImage (NetworkImage)

+ (void)imageFromURLString:(NSString *)urlString {
    NSURL *url = [NSURL URLWithString:urlString];
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    dispatch_async(queue, ^{
        NSData *data = [NSData dataWithContentsOfURL:url];
        dispatch_async(dispatch_get_main_queue(), ^{
//            UIImage *image = [UIImage imageWithData:data];
//            callback(image);
            [self imageWithData:data];
        });
    });
}

@end
