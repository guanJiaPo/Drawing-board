//
//  SelectColorView.m
//  18-画板
//
//  Created by iphone18 on 16/5/11.
//  Copyright © 2016年 apple18. All rights reserved.
//

#import "SelectColorView.h"

@interface SelectColorView ()
{
    SelectColorBlock _selectColorBlock;
}
@end

@implementation SelectColorView

- (void)afterSelect:(SelectColorBlock)selectBlock{
    
    _selectColorBlock = selectBlock;
}

- (void)selectChangeItem:(UIButton *)sender{
    
    _selectColorBlock(self.contentArray[sender.tag - 100]);
}


@end
