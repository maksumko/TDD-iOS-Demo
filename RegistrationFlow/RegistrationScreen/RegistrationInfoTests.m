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
    XCTAssertNil([_sut validate]);
}

- (void)testValidateUsernameFail {
    _sut.username = @"validUsername1+";

    XCTAssertNotNil([_sut validate]);
}

- (void)testValidateEmail {
    XCTAssertNil([_sut validate]);
}

- (void)testValidateEmailFail {
    _sut.email = @"email";

    XCTAssertNotNil([_sut validate]);
}

- (void)testValidatePassword {
    XCTAssertNil([_sut validate]);
}

- (void)testValidatePasswordFail {
    _sut.password = @"1";
    
    XCTAssertNotNil([_sut validate]);
}

@end
