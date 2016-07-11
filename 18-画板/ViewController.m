//
//  ViewController.m
//  18-画板
//
//  Created by iphone18 on 16/5/11.
//  Copyright © 2016年 apple18. All rights reserved.
//

#import "ViewController.h"
#import "DrawView.h"
#import "ToolView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    DrawView *drawView = [[DrawView alloc]initWithFrame:self.view.frame];
    drawView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:drawView];
    
    
    
    NSArray *contentArray = @[@"颜色",@"线宽",@"橡皮",@"撤销",@"清屏",@"相机",@"保存"];
    
    
    ToolView *toolView = [[ToolView alloc]initWithFrame:CGRectMake(0, 0, 414, 50) WithArray:contentArray];
    toolView.backgroundColor = [UIColor grayColor];
    
    
    [toolView afterSelectColor:^(UIColor *color) {
        
        drawView.strokeColor = color;
        
    } sfterSelectLineWidth:^(float lineWidth) {
        
        drawView.lineWidth = lineWidth;
        
    }];
    
    
    [toolView clickEraserBlock:^{
        
        drawView.strokeColor = [UIColor whiteColor];
        
    } WithUndoBlock:^{
        
        [drawView undo];
        
    } WithClearBlock:^{
        
        [drawView clear];
        
    } WithSaveBlock:^{
        
        [drawView save];
        
    }];
    
    
    [self.view addSubview:toolView];
}













- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
