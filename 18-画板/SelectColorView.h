//
//  SelectColorView.h
//  18-画板
//
//  Created by iphone18 on 16/5/11.
//  Copyright © 2016年 apple18. All rights reserved.
//

#import "BaseView.h"

typedef void(^SelectColorBlock)(UIColor *color);

@interface SelectColorView : BaseView

- (void)afterSelect:(SelectColorBlock)selectBlock;

@end
