//
//  KVCViewController.m
//  Object
//
//  Created by R G on 2019/10/20.
//  Copyright © 2019 R G. All rights reserved.
//



/*
 
 [setValue: forKey:]
 
 1. Searches the class of the receiver for an accessor method whose name matches the pattern -set<Key>:. If such a method is found the type of its parameter is checked. If the parameter type is not an object pointer type but the value is nil -setNilValueForKey: is invoked. The default implementation of -setNilValueForKey: raises an NSInvalidArgumentException, but you can override it in your application. Otherwise, if the type of the method's parameter is an object pointer type the method is simply invoked with the value as the argument. If the type of the method's parameter is some other type the inverse of the NSNumber/NSValue conversion done by -valueForKey: is performed before the method is invoked.
 查询是否存在 set<Key> 如果存在 则检查参数 如果参数不是对象且值为nil调用setNilValueForKey 默认会抛出NSInvalidArgumentException 如果是对象类型就简单的赋值,如果是之外的类型 需要转换为nsnumber/nsvalue在方法调用之前
 2. Otherwise (no accessor method is found), if the receiver's class' +accessInstanceVariablesDirectly property returns YES, searches the class of the receiver for an instance variable whose name matches the pattern _<key>, _is<Key>, <key>, or is<Key>, in that order. If such an instance variable is found and its type is an object pointer type the value is retained and the result is set in the instance variable, after the instance variable's old value is first released. If the instance variable's type is some other type its value is set after the same sort of conversion from NSNumber or NSValue as in step 1.
 未查询到set<key> 并且 accessInstanceVariablesDirectly 允许直接访问成员变量
 则按顺序检索成员变量名为_<key>, _is<key>, <key>, is<Key>(注意大小写) 如果查找到就retain value并赋值 旧值会被release
 3. Otherwise (no accessor method or instance variable is found), invokes -setValue:forUndefinedKey:. The default implementation of -setValue:forUndefinedKey: raises an NSUndefinedKeyException, but you can override it in your application.
 1.2都不存在 调用-setValue:forUndefinedKey: 抛出 NSUndefinedKeyException
 */



/*
 
 [valueForKey:]
 
 1. Searches the class of the receiver for an accessor method whose name matches the pattern -get<Key>, -<key>, or -is<Key>, in that order. If such a method is found it is invoked. If the type of the method's result is an object pointer type the result is simply returned. If the type of the result is one of the scalar types supported by NSNumber conversion is done and an NSNumber is returned. Otherwise, conversion is done and an NSValue is returned (new in Mac OS 10.5: results of arbitrary type are converted to NSValues, not just NSPoint, NRange, NSRect, and NSSize).
 匹配 method: -get<Key>, -<key>, or -is<Key>
 检查类型: 1) objc 直接返回  2)nsnumber支持转换的数据类型 返回nsnumber 3)转换为nsvalue
 
 2 (introduced in Mac OS 10.7). Otherwise (no simple accessor method is found), searches the class of the receiver for methods whose names match the patterns -countOf<Key> and -indexIn<Key>OfObject: and -objectIn<Key>AtIndex: (corresponding to the primitive methods defined by the NSOrderedSet class) and also -<key>AtIndexes: (corresponding to -[NSOrderedSet objectsAtIndexes:]). If a count method and an indexOf method and at least one of the other two possible methods are found, a collection proxy object that responds to all NSOrderedSet methods is returned. Each NSOrderedSet message sent to the collection proxy object will result in some combination of -countOf<Key>, -indexIn<Key>OfObject:, -objectIn<Key>AtIndex:, and -<key>AtIndexes: messages being sent to the original receiver of -valueForKey:. If the class of the receiver also implements an optional method whose name matches the pattern -get<Key>:range: that method will be used when appropriate for best performance.
 
 NSOrderset:1) -countOf<Key> or -indexIn<Key>OfObject: or -objectIn<Key>AtIndex:; optional:-get<Key>:range:
 
 3. Otherwise (no simple accessor method or set of ordered set access methods is found), searches the class of the receiver for methods whose names match the patterns -countOf<Key> and -objectIn<Key>AtIndex: (corresponding to the primitive methods defined by the NSArray class) and (introduced in Mac OS 10.4) also -<key>AtIndexes: (corresponding to -[NSArray objectsAtIndexes:]). If a count method and at least one of the other two possible methods are found, a collection proxy object that responds to all NSArray methods is returned. Each NSArray message sent to the collection proxy object will result in some combination of -countOf<Key>, -objectIn<Key>AtIndex:, and -<key>AtIndexes: messages being sent to the original receiver of -valueForKey:. If the class of the receiver also implements an optional method whose name matches the pattern -get<Key>:range: that method will be used when appropriate for best performance.
 NSArray: -countOf<Key>; -objectIn<Key>AtIndex Or -<key>AtIndexes:; optional: -get<Key>:range
 
 4 (introduced in Mac OS 10.4). Otherwise (no simple accessor method or set of ordered set or array access methods is found), searches the class of the receiver for a threesome of methods whose names match the patterns -countOf<Key>, -enumeratorOf<Key>, and -memberOf<Key>: (corresponding to the primitive methods defined by the NSSet class). If all three such methods are found a collection proxy object that responds to all NSSet methods is returned. Each NSSet message sent to the collection proxy object will result in some combination of -countOf<Key>, -enumeratorOf<Key>, and -memberOf<Key>: messages being sent to the original receiver of -valueForKey:.
 NSSet: -countOf<Key>, -enumeratorOf<Key>, and -memberOf<Key>:
 5. Otherwise (no simple accessor method or set of collection access methods is found), if the receiver's class' +accessInstanceVariablesDirectly property returns YES, searches the class of the receiver for an instance variable whose name matches the pattern _<key>, _is<Key>, <key>, or is<Key>, in that order. If such an instance variable is found, the value of the instance variable in the receiver is returned, with the same sort of conversion to NSNumber or NSValue as in step 1.
 
 检查是否允许直接访问 +accessInstanceVariablesDirectly
 匹配:_<key>, _is<Key>, <key>, or is<Key>,
 检查类型 step 1
 6. Otherwise (no simple accessor method, set of collection access methods, or instance variable is found), invokes -valueForUndefinedKey: and returns the result. The default implementation of -valueForUndefinedKey: raises an NSUndefinedKeyException, but you can override it in your application.
 // 未找到 1)调用:-valueForUndefinedKey  2)抛出NSUndefinedKeyException
 */

#import "KVCViewController.h"
#import "KVC.h"

@interface KVCViewController ()

@property (nonatomic, assign) bool animationed;
@end

@implementation KVCViewController

- (BOOL)isAnimationed {
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    KVC *k = [KVC new];
    NSError *error;
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:k requiringSecureCoding:true error:&error];
    [k setValue:nil forKey:@"name"];
    
    // accessInstanceVariablesDirectly 为ture
    [k setValue:nil forKey:@"height"];// 对应_height, _isHeight, height, isHeight

    
    id h = @"2";// [k valueForKey:@"height"];
    id child = [[k valueForKey:@"child"] lastObject];
    NSLog(@"%@, %@", h, child);
}

@end
