//
//  KVC.m
//  Object
//
//  Created by R G on 2019/10/20.
//  Copyright © 2019 R G. All rights reserved.
//

#import "KVC.h"
#import <UIKit/UIKit.h>


@interface KVC() {
    CGFloat _isHeight;
    NSArray *_arr;
}


@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) CGFloat age;

@end


@implementation KVC
@dynamic child;

static int const _inChild[] = {0, 1, 2};

+ (BOOL)supportsSecureCoding {
    return YES;
}

+ (BOOL)accessInstanceVariablesDirectly {
    return YES;
}

//非对象类型并且value为nil
- (void)setNilValueForKey:(NSString *)key {
    NSLog(@"%@", key);
}

// 对于非对象集合可以利用KVC这个机制直接返回对象类型
- (NSUInteger)countOfChild {
    
    return (sizeof(_inChild) / sizeof(*_inChild));
}

- (id)objectInChildAtIndex:(NSUInteger)index {
    
    return @(_inChild[index]);
}

- (void)encodeWithCoder:(nonnull NSCoder *)aCoder {
    [aCoder encodeObject:self.name forKey: @"name"];
}

- (nullable instancetype)initWithCoder:(nonnull NSCoder *)aDecoder {
    self = [super init];
    _name = [aDecoder decodeObjectForKey:@"name"];
    return self;
}

@end
