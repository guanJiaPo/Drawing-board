//
//  ToolView.m
//  18-画板
//
//  Created by iphone18 on 16/5/11.
//  Copyright © 2016年 apple18. All rights reserved.
//

#import "ToolView.h"

typedef enum : NSUInteger {
    kColorSelect = 100,
    kLineWidthSelect,
    KEraserSelect,
    kUndoSelect,
    kClearScreenSelect,
    kcameraSelect,
    kSaveSelect
} kSelectItem;

@interface ToolView ()
{
    SelectColorBlock _selectColorBlock;
    selectLineWidthBlock _selectLineWidthBlock;
    
    ToolActionBlock _araserBlock;
    ToolActionBlock _undoBlock;
    ToolActionBlock _clearBlock;
    ToolActionBlock _saveBlock;
    
}
@property (nonatomic,strong) SelectColorView *selectColorView;
@property (nonatomic,strong) SelectLineWidthView *selectLineWidthView;


@end

@implementation ToolView

- (void)selectChangeItem:(UIButton *)sender{
    
    switch (sender.tag) {
        case kColorSelect:
            
            [self forcrHideView:self.selectColorView];
            [self showHideColorSelectView];
        
            break;
        
        case kLineWidthSelect:
            
            [self forcrHideView:self.selectLineWidthView];
            [self showHideLineWidthSelectView];
            
            break;
            
        case KEraserSelect:{
            
            _araserBlock();
        }
            break;

        case kUndoSelect:
            
            _undoBlock();
            
            break;

        case kClearScreenSelect:
            
            _clearBlock();
            
            break;
        case kcameraSelect:
            
            [self showHideColorSelectView];
            
            break;

        case kSaveSelect:
            
            _saveBlock();
            
            break;

        default:
            break;
    }
    
}

//让颜色选择视图显示或隐藏
- (void)showHideColorSelectView{
    
    NSArray *colorArray = @[[UIColor redColor],[UIColor greenColor],[UIColor orangeColor],[UIColor magentaColor],[UIColor blueColor],[UIColor yellowColor],[UIColor cyanColor]];
    
    
    if (self.selectColorView == nil) {
        
        self.selectColorView = [[SelectColorView alloc]initWithFrame:CGRectMake(0, -50, 414, 50) WithArray:colorArray];
        
        [self.selectColorView afterSelect:^(UIColor *color) {
            
            _selectColorBlock(color);
            [self forcrHideView:nil];
        }];
        
        [self addSubview:self.selectColorView];
    }
    
    [self showHideView:self.selectColorView];
}


- (void)showHideLineWidthSelectView{
    
    NSArray *lineWidthArray = @[@"1",@"2",@"3",@"4",@"5",@"8",@"10",@"12",@"15",@"18",@"20"];
    
    if (self.selectLineWidthView == nil) {
        
        self.selectLineWidthView = [[SelectLineWidthView alloc]initWithFrame:CGRectMake(0, -50, 414, 50) WithArray:lineWidthArray];
        
        [self.selectLineWidthView afterSelect:^(float lineWidth) {
            
            _selectLineWidthBlock(lineWidth);
            
            [self forcrHideView:nil];
        }];
        
        [self addSubview:self.selectLineWidthView];
    }
    
    
    [self showHideView:self.selectLineWidthView];
    
}


//让视图动画式显示或消失
- (void)showHideView:(UIView *)view{
    
    //保存要消失或出现的视图的frame
    CGRect colorFrame = view.frame;
    
    //保存当前工具栏的frame
    CGRect toolFrame = self.frame;
    
    if (colorFrame.origin.y>0) {
        colorFrame.origin.y = -50;
        toolFrame.size.height = 50;
    }else{
        
        colorFrame.origin.y = 50;
        toolFrame.size.height = 100;
    }
    
    [UIView animateWithDuration:0.5 animations:^{
        
        view.frame = colorFrame;
        self.frame = toolFrame;
        
    }];
    
}


//强制隐藏视图
- (void)forcrHideView:(UIView *)view{
    
    UIView *showView = nil;
    
    if (self.selectColorView.frame.origin.y>0) {
        
        showView = self.selectColorView;
        
    }else if(self.selectLineWidthView.frame.origin.y>0){
        
        showView = self.selectLineWidthView;
        
    }else{
        
        return;
    }
    
    if (view == showView) {
        
        return;
    }
    
    CGRect showFrame = showView.frame;
    CGRect toolFrame = self.frame;
    
    showFrame.origin.y = -50;
    toolFrame.size.height = 50;
    
    [UIView animateWithDuration:0.5 animations:^{
        
        showView.frame = showFrame;
        
        self.frame = toolFrame;
    }];
}
    


- (void)afterSelectColor:(SelectColorBlock)colorBlock sfterSelectLineWidth:(selectLineWidthBlock)lineWidthBlock{
    
    _selectLineWidthBlock = lineWidthBlock;
    _selectColorBlock = colorBlock;
}


- (void)clickEraserBlock:(ToolActionBlock)araserBlock WithUndoBlock:(ToolActionBlock)undoBlock WithClearBlock:(ToolActionBlock)clearBlock WithSaveBlock:(ToolActionBlock)saveBlock{
    
    _araserBlock = araserBlock;
    _undoBlock = undoBlock;
    _clearBlock = clearBlock;
    _saveBlock = saveBlock;
}


@end
