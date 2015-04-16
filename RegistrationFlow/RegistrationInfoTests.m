//
//  RegistrationInfoTests.m
//  RegistrationFlow
//
//  Created by maxim.k on 4/16/15.
//  Copyright (c) 2015 maxim.k. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "RegistrationInfo.h"


@interface RegistrationInfoTests : XCTestCase {
    RegistrationInfo*   _sut;
}

@end

@implementation RegistrationInfoTests

- (void)setUp {
    [super setUp];
    _sut = [[RegistrationInfo alloc] init];
    _sut.email = @"email@mail.ru";
    _sut.username = @"validUsername1";
    _sut.password = @"1231231231231231";
}

- (void)tearDown {
    _sut = nil;
    [super tearDown];
}

- (void)testClassExists {
    XCTAssertNotNil(_sut);
}

- (void)testHasUsername {
    _sut.username = @"1";
    XCTAssertTrue([_sut.username length] > 0);
}

- (void)testHasEmail {
    _sut.email = @"1";
    XCTAssertTrue([_sut.email length] > 0);
}

- (void)testHasPassword {
    _sut.password = @"1";
    XCTAssertTrue([_sut.password length] > 0);
}

- (void)testValidateUsername {
    NSString* result = [_sut validate];
    
    XCTAssertNil(result);
}

- (void)testValidateUsernameFail {
    _sut.username = @"validUsername1+";
    NSString* result = [_sut validate];
    
    XCTAssertNotNil(result);
}

- (void)testValidateEmail {
    NSString* result = [_sut validate];
    
    XCTAssertNil(result);
}

- (void)testValidateEmailFail {
    _sut.email = @"email";
    NSString* result = [_sut validate];
    
    XCTAssertNotNil(result);
}

- (void)testValidatePassword {
    NSString* result = [_sut validate];
    
    XCTAssertNil(result);
}

- (void)testValidatePasswordFail {
    _sut.password = @"1";
    
    NSString* result = [_sut validate];
    
    XCTAssertNotNil(result);
}

@end
