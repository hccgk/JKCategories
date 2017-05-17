//
//  NSArray+Overstep.m
//  
//
//  Created by 川何 on 2017/5/17.
//
//

#import "NSArray+Overstep.h"

@implementation NSArray (Overstep)
+ (void)load{
    [super load];
    //  替换不可变数组中的方法
    Method oldObjectAtIndex = class_getInstanceMethod(objc_getClass("__NSArrayI"), @selector(objectAtIndex:));
    Method newObjectAtIndex = class_getInstanceMethod(objc_getClass("__NSArrayI"), @selector(JKobjectAtIndex:));
    method_exchangeImplementations(oldObjectAtIndex, newObjectAtIndex);
    //  替换可变数组中的方法
    Method oldMutableObjectAtIndex = class_getInstanceMethod(objc_getClass("__NSArrayM"), @selector(objectAtIndex:));
    Method newMutableObjectAtIndex =  class_getInstanceMethod(objc_getClass("__NSArrayM"), @selector(JKmutableObjectAtIndex:));
    method_exchangeImplementations(oldMutableObjectAtIndex, newMutableObjectAtIndex);
}
- (id)JKobjectAtIndex:(NSUInteger)index{
    if (index > self.count - 1 || !self.count){
        @try {
            return [self JKobjectAtIndex:index];
        } @catch (NSException *exception) {
            NSLog(@"数组越界...");
            return nil;
        } @finally {
            
        }
    }
    else{
        return [self JKobjectAtIndex:index];
    }
}

- (id)JKmutableObjectAtIndex:(NSUInteger)index{
    if (index > self.count - 1 || !self.count){
        @try {
            return [self JKmutableObjectAtIndex:index];
        } @catch (NSException *exception) {
            //__throwOutException  抛出异常
            NSLog(@"数组越界...");
            return nil;
        } @finally {
            
        }
    }
    else{
        return [self JKmutableObjectAtIndex:index];
    }
}
@end
