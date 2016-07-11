//
//  SelectLineWidth.h
//  18-画板
//
//  Created by iphone18 on 16/5/11.
//  Copyright © 2016年 apple18. All rights reserved.
//

#import "BaseView.h"

typedef void(^selectLineWidthBlock)(float lineWidth);

@interface SelectLineWidthView : BaseView

- (void)afterSelect:(selectLineWidthBlock)selectBlock;

@end
