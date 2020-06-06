//
//  KVCFile.h
//  Runtime
//
//  Created by R G on 2019/10/2.
//  Copyright © 2019 R G. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KVCFile : NSObject<NSCopying>

@property NSMutableArray *files;
@property NSString *name;
@end

NS_ASSUME_NONNULL_END
