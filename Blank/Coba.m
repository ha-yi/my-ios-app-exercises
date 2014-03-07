//
//  Coba.m
//  Blank
//
//  Created by MSCI on 2/17/14.
//
//

#import "Coba.h"

@implementation Coba
- (void) testLogWithString:(NSString) text {
    NSLog(text);
}

@end

int main() {
    Coba c = [[Coba alloc] init];
    [c testLogWithString:@"coba coba"];
    return 0;
}
