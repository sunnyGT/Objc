//
//  MemoryViewController.m
//  Object
//
//  Created by R G on 2019/10/20.
//  Copyright © 2019 R G. All rights reserved.
//

#import "MemoryViewController.h"

@interface MemoryViewController ()

@property (nonatomic, assign) NSObject *assignObjc;
@property (nonatomic, assign) CGFloat num;


@property (nonatomic, retain) NSObject *retainObjc;
@property (nonatomic, strong) NSObject *strongObjc;

// note: NSObject 默认不实现copy 提供copy接口
@property (nonatomic, copy) NSObject *cObjc;

@property (nonatomic, weak) NSObject *weakObjc;

@property (nonatomic, unsafe_unretained) NSObject *uuObjc;
@property (nonatomic, unsafe_unretained)CGFloat a;


@property (nonatomic, copy) NSString *cStr;
@end

@implementation MemoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString * oStr = [NSString string];
    NSString * __autoreleasing cStr = [oStr copy];
    NSString * mcStr = [oStr mutableCopy];
    [mcStr performSelector:@selector(appendString:) withObject:@"1"];
    
    NSLog(@"%@",NSStringFromClass(self.class));
    NSLog(@"%p", &oStr);
    NSLog(@"%p", &cStr);
    NSLog(@"%p", &mcStr);
    

    // Do any additional setup after loading the view.
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
