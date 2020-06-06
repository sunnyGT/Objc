#### app id

com.teamidentifir.bundleid

#### app sign

Digital identity used to sign

Contain certificate & public key（for Apple）、 private key（signature）

#### bundle

Applications, frameworks, plug-ins, and other types of software are bundles

Note: Applications are the only type of bundle that third-party developers can create on iOS.

A bundle is a directory with a standardized hierarchical structure that holds executable code and the resources used by that code.

Can contain: executable code, images, sounds, nib files, private frameworks and libraries, plug-ins, loadable bundles, or any other type of code or resource. It also contains a runtime-configuration file called the information property list (Info.plist).

Most types of Xcode projects create a bundle for you when you build the executable


#### category

Category 声明的 属性或者方法都是 可以继承的

Use to:
1. Distribute the implementation of your own classes into separate source files—for example, you could group the methods of a large class into several categories and put each category in a different file.
2. Declare private methods (eg: framework)
3. Multiple Inheritance create iVar or method ( need import category .h like need  Inheritance someClass)

#### class cluster (类簇) 抽象工厂模式
EG: NSNumber NSString NSArray and so on

Benefits:
1. Efficiency (doesn't switch)
2. 减少类的数量简单学习成本低
3. 便于扩展

Considerations:
1. 不易扩展 增加一个子类需要实现相关一系列

#### cocoa touch

Cocoa and Cocoa Touch are the application development environments for OS X and iOS

Cocoa Touch, which includes Foundation and UIKit frameworks, is used for developing applications that run on iOS.

Note: The term “Cocoa” has been used to refer generically to any class or object that is based on the Objective-C runtime and inherits from the root class, NSObject. The terms “Cocoa” or “Cocoa Touch” are also used when referring to application development using any programmatic interface of the respective platforms.

#### Dynamic binding

Dynamic binding is determining the method to invoke at runtime instead of at compile time

#### Dynamic typing

A variable is dynamically typed when the type of the object it points to is not checked at compile time.


简单工厂

构造函数已经不够生成实例 不满足面向对象

专门的类创建具有统一父类的实例

违反 开闭原则

@autorealsepool

每个线程至少维护有一个pool
主线程的 runloop中 注册了两个observer push()优先级最高 保证每个事件会调都发生在pool创建之后. pop()优先级最低 保证在事件会调之后触发 每次唤醒都会创建一个pool 休眠时释放并创建新的pool  退出时释放pool


Tip:

diff Void * and id

id : 任意是指OC 对象
void * : C层面的类型 是指未知类型/未知内容的指针

nil NULL null 
