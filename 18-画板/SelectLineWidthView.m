//
//  SelectLineWidth.m
//  18-画板
//
//  Created by iphone18 on 16/5/11.
//  Copyright © 2016年 apple18. All rights reserved.
//

#import "SelectLineWidthView.h"

@interface SelectLineWidthView ()
{
    selectLineWidthBlock _selectLineWidthBlock;
}
@end

@implementation SelectLineWidthView


- (void)afterSelect:(selectLineWidthBlock)selectBlock{
    
    _selectLineWidthBlock = selectBlock;
}


- (void)selectChangeItem:(UIButton *)sender{
    
    float lineWidth = [self.contentArray[sender.tag - 100] floatValue];
    
    _selectLineWidthBlock(lineWidth);
}

@end
