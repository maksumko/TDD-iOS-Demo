//
//  RegistrationScreenTests.m
//  RegistrationFlow
//
//  Created by maxim.k on 4/16/15.
//  Copyright (c) 2015 maxim.k. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "RegistrationScreen.h"


@interface RegistrationScreenTests : XCTestCase {
    RegistrationScreen* _sut;
}

@end

@implementation RegistrationScreenTests

- (void)setUp {
    [super setUp];
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    _sut = [storyboard instantiateViewControllerWithIdentifier:@"registration"];
}

- (void)tearDown {
    _sut = nil;
    [super tearDown];
}

- (void)testScreenExists {
    XCTAssertNotNil(_sut);
}

- (void)testControllerInstantiatesWithCorrectClass {
    XCTAssertTrue([_sut isKindOfClass:[RegistrationScreen class]]);
}

- (void)testOutlets {
    [_sut view];
    
    XCTAssertNotNil(_sut.usernameField);
    XCTAssertNotNil(_sut.emailField);
    XCTAssertNotNil(_sut.passwordField);
    
    XCTAssertNotNil(_sut.registerButton);
}

- (void)testCallsActionOnTap {
    [_sut view];
    
    XCTAssertTrue([[_sut.registerButton actionsForTarget:_sut forControlEvent:UIControlEventTouchUpInside] containsObject:NSStringFromSelector(@selector(tapRegister:))]);
}

@end
