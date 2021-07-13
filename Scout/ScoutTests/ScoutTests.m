//
//  ScoutTests.m
//  ScoutTests
//
//  Created by slyfy27 on 2021/7/13.
//

#import <XCTest/XCTest.h>
#import "NSObject+Scout.h"

@interface NSObject (swizzleTest)

- (NSString *)swizzleDes;

@end

@implementation NSObject (swizzleTest)

- (NSString *)swizzleDes {
    return @"123";
}

- (NSString *)swizzleDes1 {
    return @"1234";
}

@end

@interface ScoutTests : XCTestCase

@end

@implementation ScoutTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    NSString *str1 = @"1";
           NSString *str2 = @"1";
           NSString *str3 = str1;
           XCTAssertEqual(str1, str2, @"a1 and a2 should point to the same object"); // 通过测试
           XCTAssertEqual(str1, str3, @"a1 and a2 should point to the same object"); // 通过测试
    
    NSObject *obj = [NSObject new];
    
    [NSObject scout_swizzleSEL:@selector(description) withSEL:@selector(swizzleDes)];
    XCTAssertEqual(obj.description, @"123");
    
    [NSObject scout_swizzleSEL:@selector(description) withSEL:@selector(swizzleDes1)];
    XCTAssertEqual(obj.description, @"1234");
    
    [NSObject scout_swizzleSEL:@selector(description) withSEL:@selector(swizzleDes)];
    NSLog(@"%@",obj.description);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
