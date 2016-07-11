//
//  DrawView.m
//  18-画板
//
//  Created by iphone18 on 16/5/11.
//  Copyright © 2016年 apple18. All rights reserved.
//

#import "DrawView.h"
#import "PathModel.h"

@interface DrawView ()

@property (nonatomic,assign) CGMutablePathRef path;
@property (nonatomic,retain) NSMutableArray *pathArray;
@property (nonatomic,assign) BOOL isRelease;

@end


@implementation DrawView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.strokeColor = [UIColor blackColor];
        self.lineWidth = 2;
    }
    return self;
}

- (void)drawRect:(CGRect)rect{
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [self drawView:context];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    //获取到起点
    CGPoint point = [[touches anyObject] locationInView:self];
    
    //创建路径
     self.path = CGPathCreateMutable();
     self.isRelease = NO;
    
    //设置起点
    CGPathMoveToPoint(self.path, NULL, point.x, point.y);
    
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    //获取起点
     CGPoint point = [[touches anyObject] locationInView:self];
    
    //追加路径
    CGPathAddLineToPoint(self.path, NULL, point.x, point.y);
    
    //不能直接调用drawRect方法，使用setNeedsDisplay方法来触发drawRect执行
    [self setNeedsDisplay];

}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    if (self.pathArray == nil) {
        self.pathArray = [NSMutableArray array];
    }
    
    //使用贝塞尔曲线将CGPath包装成对象
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithCGPath:self.path];
    
    PathModel *pathModel = [[PathModel alloc]init];
    
    pathModel.bezierPath = bezierPath;
    pathModel.strokeColor = self.strokeColor;
    pathModel.lineWidth = self.lineWidth;
    
    [self.pathArray addObject:pathModel];

    
    //释放路径
    CGPathRelease(self.path);
    self.isRelease = YES;
}

- (void)drawView:(CGContextRef)context{
   
    
    for (PathModel *model in self.pathArray) {
        
        CGContextAddPath(context, model.bezierPath.CGPath);
        
        //设置上下文状态
        [model.strokeColor setStroke];
        CGContextSetLineWidth(context, model.lineWidth);

        CGContextDrawPath(context, kCGPathStroke);
    }
    
    if (!self.isRelease) {
        
        //将路径添加到上下文
        CGContextAddPath(context, self.path);
        
        //设置上下文状态
        [self.strokeColor setStroke];
        CGContextSetLineWidth(context, self.lineWidth);
        
        //绘制路径
        CGContextDrawPath(context, kCGPathStroke);
    }
    
}


- (void)undo{
    
    [self.pathArray removeLastObject];
    [self setNeedsDisplay];
}

- (void)clear{
    
    [self.pathArray removeAllObjects];
    [self setNeedsDisplay];
}

- (void)save{
    
    UIGraphicsBeginImageContext(CGSizeMake(self.frame.size.width, self.frame.size.height));
    
    //获取到当前指定试图上的内容，并把它放到画板上面
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    UIImageWriteToSavedPhotosAlbum(image, nil, nil, NULL);
}

@end
