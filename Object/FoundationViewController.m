//
//  FoundationViewController.m
//  Object
//
//  Created by R G on 2019/10/20.
//  Copyright © 2019 R G. All rights reserved.
//

#import "FoundationViewController.h"

@interface FoundationViewController ()

@end

@implementation FoundationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = self.title;
    NSArray<NSString *> * arr = [NSArray arrayWithObjects:@"111", @1 , nil];
    NSLog(@"%@",arr);
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
