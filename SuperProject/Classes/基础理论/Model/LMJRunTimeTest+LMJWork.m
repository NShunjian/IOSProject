//
//  LMJRunTimeTest+LMJWork.m
//  SuperProject
//
//  Created by NShunJian on 2018/1/20.
//  Copyright © 2018年 superMan. All rights reserved.
//

#import "LMJRunTimeTest+LMJWork.h"


static void *workKey_ = &workKey_;

@implementation LMJRunTimeTest (LMJWork)




- (NSString *)workName
{
    return objc_getAssociatedObject(self, workKey_);
}


- (void)setWorkName:(NSString *)workName
{
    objc_setAssociatedObject(self, workKey_, workName, OBJC_ASSOCIATION_COPY);
}





@end
