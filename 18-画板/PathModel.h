//
//  PathModel.h
//  18-画板
//
//  Created by iphone18 on 16/5/11.
//  Copyright © 2016年 apple18. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PathModel : NSObject

@property (nonatomic,retain) UIBezierPath *bezierPath;
@property (nonatomic,retain) UIColor *strokeColor;
@property (nonatomic,assign) CGFloat lineWidth;

@end
