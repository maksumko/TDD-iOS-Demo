//
//  main.m
//  RegistrationFlow
//
//  Created by maxim.k on 4/16/15.
//  Copyright (c) 2015 maxim.k. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"


int main(int argc, char * argv[]) {
    @autoreleasepool {
        Class delegate;
        if(NSClassFromString(@"XCTestCase")) {
            delegate = [UIResponder class];
        } else {
            delegate = [AppDelegate class];
        }
        return UIApplicationMain(argc, argv, nil, NSStringFromClass(delegate));
    }
}
