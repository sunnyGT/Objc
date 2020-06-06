//
//  KVC.h
//  Object
//
//  Created by R G on 2019/10/20.
//  Copyright © 2019 R G. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KVC : NSObject<NSCoding, NSSecureCoding>

@property (nonatomic, copy, readonly) NSArray *child;
@end

NS_ASSUME_NONNULL_END
