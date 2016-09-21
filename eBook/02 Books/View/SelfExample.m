//
//  SelfExample.m
//  eBook
//
//  Created by CYC on 16/5/2.
//  Copyright © 2016年 CaoYicheng. All rights reserved.
//

#import "SelfExample.h"

static SelfExample *instance = nil;

@implementation SelfExample

+ (id)shareInstance {
    
    if (instance == nil) {
        
        instance = [[SelfExample alloc] init];
        
    }
    
    return instance;
}

//调用init方法会走下面这个方法
+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    
    if (instance == nil) {
        
        //调用父类的方法创建单例
        instance = [super allocWithZone:zone];
        
    }
    
    return instance;
    
}

- (id)copy {
    
    return self;
    
}

@end
