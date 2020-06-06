

###
CF requires all objects be at least 16 bytes.
```
size_t instanceSize(size_t extraBytes) {
    size_t size = alignedInstanceSize() + extraBytes;
    if (size < 16) size = 16;
    return size;
} 

```

### ARC rules:

1. You cannot explicitly invoke dealloc, or implement or invoke retain, release, retainCount, or autorelease.
The prohibition extends to using @selector(retain), @selector(release), and so on.

You may implement a dealloc method if you need to manage resources other than releasing instance variables. You do not have to (indeed you cannot) release instance variables, but you may need to invoke [systemClassInstance setDelegate:nil] on system classes and other code that isn’t compiled using ARC.

Custom dealloc methods in ARC do not require a call to [super dealloc] (it actually results in a compiler error). The chaining to super is automated and enforced by the compiler.

You can still use CFRetain, CFRelease, and other related functions with Core Foundation-style objects (see Managing Toll-Free Bridging).

2. You cannot use NSAllocateObject or NSDeallocateObject.
You create objects using alloc; the runtime takes care of deallocating objects.

3. You cannot use object pointers in C structures.
Rather than using a struct, you can create an Objective-C class to manage the data instead.

4. There is no casual casting between id and void *.
5. You must use special casts that tell the compiler about object lifetime. You need to do this to cast between Objective-C objects and Core Foundation types that you pass as function arguments. For more details, see Managing Toll-Free Bridging.

6. You cannot use NSAutoreleasePool objects.
ARC provides @autoreleasepool blocks instead. These have an advantage of being more efficient than NSAutoreleasePool.

7. You cannot use memory zones.
There is no need to use NSZone any more—they are ignored by the modern Objective-C runtime anyway.

To allow interoperation with manual retain-release code, ARC imposes a constraint on method naming:

8. You cannot give an accessor a name that begins with new. This in turn means that you can’t, for example, declare a property whose name begins with new unless you specify a different getter:


###  ARC Property Attributes

1. __strong

__strong is the default. An object remains “alive” as long as there is a strong pointer to it.

2. __weak

__weak specifies a reference that does not keep the referenced object alive. A weak reference is set to nil when there are no strong references to the object.

3. __unsafe_unretained

__unsafe_unretained specifies a reference that does not keep the referenced object alive and is not set to nil when there are no strong references to the object. If the object it references is deallocated, the pointer is left dangling.

4. __autoreleasing

__autoreleasing is used to denote arguments that are passed by reference (id *) and are autoreleased on return.

编译器根据修饰符添加必要的retain release autorelease代码

5. copy

NSCopying: copyWithZone:  copy
NSMutableCopying: mutableCopyWithZone: mutablCopy

shallow: 只拷贝指针 如:[immutable(objc) copy]

deep: 创建新的拷贝内容 1)mutablCopy 2)[(mutable)objc copy]

note: shallow & deep 的考虑是要基于不同的层面去思考对象的copy行为

"What kind of copying-deep or shallow-does your class need?"
"Does your class's superclass implement NSCopying?"
"Are you familiar with the implementations of your class's superclasses?"

NSObject 默认不实现copy 提供copy接口

Implement NSCopying using alloc and init... in classes that don't inherit copyWithZone:.

Implement NSCopying by invoking the superclass's copyWithZone: when NSCopying behavior is inherited. If the superclass implementation might use NSCopyObject(), make explicit assignments to pointer instance variables for retained objects.
[过时](NSCopyObject() 创建的对象初始值不为nil 需要考虑 在setIvar: 导致引用计数的变化)
Implement NSCopying by retaining the original instead of creating a new copy when the class and its contents are immutable.

6. retain vs strong
strong和retain的语义表示需要retain操作, alive 对象
strong 还可能有另外的一些操作 比如在arc在对block的copy

7. assign vs weak
assign 和 weak 都不持有对象
weak会将没有strong reference的对象置为 nil
weak指针有slide table管理释放时需要对表进行一系列操作

8. assign vs __unsafe_unretained
(assign is effectively unsafe_unretained  may be)

__unsafe_unretained use in  the case of a C struct with a oc object  struct will strong retained it but  the compiler cannot reliably do when struct be free realse a the oc object in struct  


### ARC & coreFoundation
Through toll-free bridging, in a method where you see for example an NSLocale * parameter, you can pass a CFLocaleRef, and in a function where you see a CFLocaleRef parameter, you can pass an NSLocale instance. You also have to provide other information for the compiler: first, you have to cast one type to the other; in addition, you may have to indicate the object lifetime semantics.

1. __bridge transfers a pointer between Objective-C and Core Foundation with no transfer of ownership.
2. __bridge_retained or CFBridgingRetain casts an Objective-C pointer to a Core Foundation pointer and also transfers ownership to you.
You are responsible for calling CFRelease or a related function to relinquish ownership of the object.

3. __bridge_transfer or CFBridgingRelease moves a non-Objective-C pointer to Objective-C and also transfers ownership to ARC.
ARC is responsible for relinquishing ownership of the object.

objc 和 corefoundation 之间转换 1)通过关键字转换 2)告诉编译器如何管理内存 __bridge __bridge_retained __bridge_transfer


### @autorealsepool
Used to:

1. 在非UI framework下编程 ed 使用命令行
2. for 创建太多临时变量
3. 使用多线程时

每个线程维护自己的autorelease pool block(栈) 如果long live非主线需要创建 pool管理

App启动后，苹果在主线程 RunLoop 里注册了两个 Observer，其回调都是 _wrapRunLoopWithAutoreleasePoolHandler()。

第一个 Observer 监视的事件是 Entry(即将进入Loop)，其回调内会调用 _objc_autoreleasePoolPush() 创建自动释放池。其 order 是-2147483647，优先级最高，保证创建释放池发生在其他所有回调之前。

第二个 Observer 监视了两个事件： BeforeWaiting(准备进入休眠) 时调用_objc_autoreleasePoolPop() 和 _objc_autoreleasePoolPush() 释放旧的池并创建新池；Exit(即将退出Loop) 时调用 _objc_autoreleasePoolPop() 来释放自动释放池。这个 Observer 的 order 是 2147483647，优先级最低，保证其释放池子发生在其他所有回调之后。

在主线程执行的代码，通常是写在诸如事件回调、Timer回调内的。这些回调会被 RunLoop 创建好的 AutoreleasePool 环绕着，所以不会出现内存泄漏，开发者也不必显示创建 Pool 了。


