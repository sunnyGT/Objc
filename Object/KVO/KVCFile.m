//
//  KVCFile.m
//  Runtime
//
//  Created by R G on 2019/10/2.
//  Copyright © 2019 R G. All rights reserved.
//

#import "KVCFile.h"

@implementation KVCFile

- (instancetype)init
{
    self = [super init];
    if (self) {
        _files = [[NSMutableArray alloc] init];
    }
    return self;
}


@end
