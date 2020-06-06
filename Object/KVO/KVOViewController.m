//
//  KVOViewController.m
//  Object
//
//  Created by R G on 2019/10/20.
//  Copyright © 2019 R G. All rights reserved.
//

#import "KVOViewController.h"
#import "KVCFile.h"
#import <Foundation/Foundation.h>


@interface Numbers : NSObject
@property (nonatomic, strong) NSNumber *num;
@property (nonatomic, strong) NSNumber *total;
@end

@implementation Numbers

- (NSNumber *)total {
    
    return @(self.num.integerValue + 5);
}

// category 中无法使用
+ (NSSet<NSString *> *)keyPathsForValuesAffectingTotal {
    return  [NSSet setWithObjects:@"num", nil];
}


+ (NSSet<NSString *> *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
    return [super keyPathsForValuesAffectingValueForKey:key];
}

/*
 原理 : isa swizzl 注册时创建中间类继承当前类,修改isa指向中间类, 重写class (tip: 不要使用is指针去判断一个类的关系 应该使用class)
 notification 和 KVO的区别 一个通过中间类转发 一个是直接发
 */
@end

@interface KVOViewController ()

@property (nonatomic, strong) Numbers * num;
@property (nonatomic, strong) KVCFile *f;
@property (nonatomic, strong) NSMutableArray *observables;
@end


static void *p = &p; // 区分监听对像

@implementation KVOViewController



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.observables addObject:@"1"];
    [self.num setValue:@1 forKey:@"num"];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.f = [KVCFile new];
    self.num = [Numbers new];
    [self.f addObserver:self forKeyPath:@"files" options:NSKeyValueObservingOptionNew context:p];
    [self.num addObserver:self forKeyPath:@"total" options:NSKeyValueObservingOptionNew context:p];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    if (p == context) {
        NSLog(@"%@", change);
    }
}

- (void)dealloc {
    [_f removeObserver:self forKeyPath:@"files"];
}

- (NSMutableArray *)observables {
    if (!_observables) {
        // 监听集合
        _observables = [self.f mutableArrayValueForKey:@"files"];
    }
    return _observables;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
