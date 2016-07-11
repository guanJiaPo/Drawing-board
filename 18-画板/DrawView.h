//
//  DrawView.h
//  18-画板
//
//  Created by iphone18 on 16/5/11.
//  Copyright © 2016年 apple18. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrawView : UIView

@property (nonatomic,retain) UIColor *strokeColor;
@property (nonatomic,assign) CGFloat lineWidth;


- (void)undo;
- (void)clear;
- (void)save;

@end
