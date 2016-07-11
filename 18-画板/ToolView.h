//
//  ToolView.h
//  18-画板
//
//  Created by iphone18 on 16/5/11.
//  Copyright © 2016年 apple18. All rights reserved.
//

#import "BaseView.h"
#import "SelectColorView.h"
#import "SelectLineWidthView.h"

typedef void(^ToolActionBlock)();

@interface ToolView : BaseView

- (void)afterSelectColor:(SelectColorBlock)colorBlock sfterSelectLineWidth:(selectLineWidthBlock)lineWidthBlock;


- (void)clickEraserBlock:(ToolActionBlock)araserBlock WithUndoBlock:(ToolActionBlock)undoBlock WithClearBlock:(ToolActionBlock)clearBlock WithSaveBlock:(ToolActionBlock)saveBlock;



@end
