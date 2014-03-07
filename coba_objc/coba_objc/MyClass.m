//
//  MyClass.m
//  coba_objc
//
//  Created by MSCI on 2/17/14.
//  Copyright (c) 2014 SRIN. All rights reserved.
//

#define Shit NSString
#define BULLSHIT NSLog
#define CRAP NSString

#import "MyClass.h"
enum gender {
    Male = 0,
    Female = 1
}JenisKelamin;

@implementation MyClass

- (void) coba {
    NSLog(@"example");
}

@end

int main() {
    MyClass *c = [[MyClass alloc] init];
    [c coba];
    NSArray *myArray = [NSArray arrayWithObjects:@"1",@"2", @"3", @"4", nil];
    for(CRAP *c in myArray) {
        NSLog(@"this is CRAP: %@", c);
    }
    
    [myArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSLog(@"this is super CRAP : %@", obj);
        if ([obj isEqualToString:@"3"]) {
            return;
        }
    }];
    
    Shit *tai = @"Shit is something pooped up after you go to toilet in 10 minutes";
    printf("there is something here..... here we go.... %d, %d, %d ....",1, 2, 3 );
    BULLSHIT(@"bullshit: %@", tai);
    return 0;
}