//
//  ViewController.m
//  photo
//
//  Created by 大大赵 on 2017/4/5.
//  Copyright © 2017年 赵世礼. All rights reserved.
//

#import "ViewController.h"
#import "MCLineChartView.h"
@interface ViewController ()<MCLineChartViewDataSource, MCLineChartViewDelegate>

@end

@implementation ViewController
{
    MCLineChartView *_lineChartView;
    NSArray *_datas;
    NSArray *_datas1;
    NSArray *_titles;
    UIScrollView *_scrollview;
    UIImageView *_zbrImage;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    
    
    

    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 220, 100, 20);
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"点击" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:btn];
}

//这个是布局想要生成的页面

-(void)btnClick:(UIButton *)btn
{
    
    _scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height+200)];
    _scrollview.showsHorizontalScrollIndicator = NO;
    _scrollview.showsVerticalScrollIndicator = NO;
   // [self.view addSubview:_scrollview];
    
    
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 300)];
    image.image = [UIImage imageNamed:@"pic_share_bg"];
    [_scrollview addSubview:image];
    
    CAShapeLayer *solidLine =  [CAShapeLayer layer];
    CGMutablePathRef solidPath =  CGPathCreateMutable();
    solidLine.lineWidth = 3 ;
    CGPathAddEllipseInRect(solidPath, nil, CGRectMake((self.view.frame.size.width-150)/2,  50  , 150, 150));
    solidLine.fillColor = [UIColor clearColor].CGColor;
    solidLine.strokeColor = [UIColor whiteColor].CGColor;
    
    solidLine.path = solidPath;
    CGPathRelease(solidPath);
    [image.layer addSublayer:solidLine];
    
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake((self.view.frame.size.width-150)/2, 10, 150, 30)];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"过去一周累计净化空气";
    label.font = [UIFont boldSystemFontOfSize:13];
    [image addSubview:label];
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake((self.view.frame.size.width-150)/2, 80, 150, 80)];
    label2.text = @"1360";
    label2.textColor = [UIColor whiteColor];
    label2.font = [UIFont boldSystemFontOfSize:50];
    label2.textAlignment = NSTextAlignmentCenter;
    [image addSubview:label2];
    
    UILabel *label3 = [[UILabel alloc]initWithFrame:CGRectMake((self.view.frame.size.width-150)/2, 150, 150, 30)];
    label3.text = @"相当于少吸80支烟";
    label3.textColor = [UIColor whiteColor];
    label3.textAlignment = NSTextAlignmentCenter;
    label3.font = [UIFont systemFontOfSize:13];
    [image addSubview:label3];
    
    UILabel *label4 = [[UILabel alloc] initWithFrame:CGRectMake(30, 230, 100, 30)];
    label4.textColor = [UIColor whiteColor];
    label4.text = @"当前室内空气";
    label4.font = [UIFont systemFontOfSize:13];
    [image addSubview:label4];
    
    UILabel *label5 = [[UILabel alloc] initWithFrame:CGRectMake(30, 250, 100, 30)];
    label5.textColor = [UIColor whiteColor];
    label5.text = @"36";
    label5.font = [UIFont boldSystemFontOfSize:25];
    [image addSubview:label5];
    
    UILabel *label6 = [[UILabel alloc] initWithFrame:CGRectMake(30, 270, 120, 30)];
    label6.textColor = [UIColor whiteColor];
    label6.text = @"相当于新西兰空气质量";
    label6.font = [UIFont systemFontOfSize:10];
    [image addSubview:label6];
    
    
    
    for (int i = 0; i<2; i++) {
        UIImageView  *lineRed = [[UIImageView alloc] initWithFrame:CGRectMake(40, 398+i*20, 80, 3)];
        if (i==0) {
            lineRed.backgroundColor = [UIColor redColor];
        }else
        {
            lineRed.backgroundColor = [UIColor blueColor];
        }
        
        [_scrollview addSubview:lineRed];
    }
    NSArray *colorTitle = [NSArray arrayWithObjects:@"室外空气",@"室内空气", nil];
    for (int i = 0; i<2; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(125, 384+i*20, 100, 30)];
        label.text = [colorTitle objectAtIndex:i];
        label.textColor = [UIColor blackColor];
        label.font = [UIFont systemFontOfSize:11];
        [_scrollview addSubview:label];
    }
    
    
    _titles = @[@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六",@"星期日"];
    _datas = [NSArray arrayWithObjects:@"13",@"14",@"20",@"23",@"12",@"16",@"26", nil];
    _datas1 = [NSArray arrayWithObjects:@"32",@"27",@"34",@"43",@"30",@"23",@"34", nil];
    
    
    
    
    
    _lineChartView = [[MCLineChartView alloc] initWithFrame:CGRectMake(0, 424, [UIScreen mainScreen].bounds.size.width, 150)];
    _lineChartView.dotRadius = 10;
    _lineChartView.oppositeY = YES;
    _lineChartView.dataSource = self; 
    _lineChartView.delegate = self;
    _lineChartView.minValue = @1;
    _lineChartView.maxValue = @50;
    _lineChartView.solidDot = YES;
    _lineChartView.numberOfYAxis = 3;
    _lineChartView.dotPadding = 60;//这个是显示X轴  有多少数的比例
    _lineChartView.colorOfXAxis = [UIColor whiteColor];
    _lineChartView.colorOfXText = [UIColor blackColor];
    _lineChartView.colorOfYAxis = [UIColor whiteColor];
    _lineChartView.colorOfYText = [UIColor orangeColor];
    [_scrollview addSubview:_lineChartView];
    
    [_lineChartView reloadDataWithAnimate:YES];
    
    
    UILabel *label7 = [[UILabel alloc] initWithFrame:CGRectMake(0, _lineChartView.frame.origin.y+170, self.view.frame.size.width, 50)];
    label7.text = @"    一周空气对比";
    label7.textColor = [UIColor blackColor];
    label7.font = [UIFont boldSystemFontOfSize:18];
    label7.backgroundColor = [UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha:1.00];
    [_scrollview addSubview:label7];
    
    NSArray *arr = [NSArray arrayWithObjects:@"",@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六",@"星期日", nil];
    
    for (int i = 0; i < arr.count; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20+i*(self.view.frame.size.width-40)/8, label7.frame.origin.y+50+10+10, (self.view.frame.size.width-40)/8, 30)];
        label.text = [arr objectAtIndex:i];
        label.textColor = [UIColor blackColor];
        label.font = [UIFont systemFontOfSize:13];
        label.textAlignment = NSTextAlignmentCenter;
        [_scrollview addSubview:label];
    }
    
    for (int i = 0; i < _datas.count; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake((self.view.frame.size.width-40)/8+i*(self.view.frame.size.width-40)/8+20, label7.frame.origin.y+50+10+30+20, (self.view.frame.size.width-40)/8, 30)];
        label.text = [_datas objectAtIndex:i];
        label.textColor = [UIColor greenColor];
        label.font = [UIFont systemFontOfSize:13];
        label.textAlignment = NSTextAlignmentCenter;
        [_scrollview addSubview:label];
    }
    
    for (int i = 0; i < _datas1.count; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake((self.view.frame.size.width-40)/8+i*(self.view.frame.size.width-40)/8+20, label7.frame.origin.y+50+10+30+20+40, (self.view.frame.size.width-40)/8, 30)];
        label.text = [_datas1 objectAtIndex:i];
        label.textColor = [UIColor orangeColor];
        label.font = [UIFont systemFontOfSize:13];
        label.textAlignment = NSTextAlignmentCenter;
        [_scrollview addSubview:label];
    }
    NSArray *titleArr = [NSArray arrayWithObjects:@"室内",@"室外", nil];
    for (int i = 0; i < titleArr.count; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, label7.frame.origin.y+50+10+30+20+i*40, (self.view.frame.size.width-40)/8, 30)];
        label.text = [titleArr objectAtIndex:i];
        label.textColor = [UIColor blackColor];
        label.font = [UIFont boldSystemFontOfSize:13];
        label.textAlignment = NSTextAlignmentCenter;
        [_scrollview addSubview:label];
    }
    
    _zbrImage = [[UIImageView alloc] initWithFrame:CGRectMake((self.view.frame.size.width-80)/2, label7.frame.origin.y+50+10+30+20+2*40, 80, 80)];
    _zbrImage.image = [UIImage imageNamed:@"pic_public_bg"];
    [_scrollview addSubview:_zbrImage];

    
    [self imageWithView:_scrollview];
}


//最主要生成图片的方法
-(UIImage *)imageWithView:(UIView *)view
{
    CGFloat scale = [UIScreen mainScreen].scale;
    UIGraphicsBeginImageContextWithOptions(_scrollview.frame.size, NO, scale);
    [_scrollview.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    if (image != nil) {
                // 写到相册
                UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
            }
            return nil;
}
- (NSUInteger)numberOfLinesInLineChartView:(MCLineChartView *)lineChartView {
    return 4;
}

- (NSUInteger)lineChartView:(MCLineChartView *)lineChartView lineCountAtLineNumber:(NSInteger)number {
    
    
        return [_datas count],[_datas1 count];
}

- (id)lineChartView:(MCLineChartView *)lineChartView valueAtLineNumber:(NSInteger)lineNumber index:(NSInteger)index {
    
        int a = 0;
        
        if ( a == lineNumber) {
            return  _datas [index];
        }
        else
        {
            return _datas1 [index];
        }
}

- (NSString *)lineChartView:(MCLineChartView *)lineChartView titleAtLineNumber:(NSInteger)number {
    
    if (lineChartView == _lineChartView) {
        return _titles[number];
    }else
    {
        return _datas1[number];
    }
    
}

- (UIColor *)lineChartView:(MCLineChartView *)lineChartView lineColorWithLineNumber:(NSInteger)lineNumber {
    if (lineNumber == 0) {
        return [UIColor redColor];
    } else if (lineNumber == 1) {
        return [UIColor lightGrayColor];
    } else if (lineNumber == 2) {
        return [UIColor redColor];
    } else {
        return [UIColor blueColor];
    }
}
//显示多少度的label
- (NSString *)lineChartView:(MCLineChartView *)lineChartView informationOfDotInLineNumber:(NSInteger)lineNumber index:(NSInteger)index {
    
    

        
        
        if (lineNumber==2) {
            if (index == _datas.count - 1) {
                return [NSString stringWithFormat:@"%@℃", _datas[index]];
            }
        }else if (lineNumber == 0)
        {
            if (index == _datas1.count - 1) {
                return [NSString stringWithFormat:@"%@℃", _datas1[index]];
            }
        }
        else
        {
            return nil;
        }
        

    
    return nil;
}
-(void)viewDidLayoutSubviews
{
    _scrollview.contentSize = CGSizeMake(0,_zbrImage.frame.origin.y+120);
    
}

//-(UIImage *)getImageFromView:(UIView *)theView
//{
//    //UIGraphicsBeginImageContext(theView.bounds.size);
//    UIGraphicsBeginImageContextWithOptions(theView.bounds.size, YES, theView.layer.contentsScale);
//    [theView.layer renderInContext:UIGraphicsGetCurrentContext()];
//    UIImage *image=UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    return image;
//}
//- (UIImage *)captureScrollView:(UIScrollView *)scrollView{
//    UIImage* image = nil;
//    UIGraphicsBeginImageContext(_scrollview.contentSize);
//    {
//        CGPoint savedContentOffset = _scrollview.contentOffset;
//        CGRect savedFrame = _scrollview.frame;
//        _scrollview.contentOffset = CGPointZero;
//        _scrollview.frame = CGRectMake(0, 0, 0, _zbrImage.frame.origin.y+120);
//        
//        [_scrollview.layer renderInContext: UIGraphicsGetCurrentContext()];
//        image = UIGraphicsGetImageFromCurrentImageContext();
//        
//        _scrollview.contentOffset = savedContentOffset;
//        _scrollview.frame = savedFrame;
//    }
//    UIGraphicsEndImageContext();
//    
//    if (image != nil) {
//        // 写到相册
//        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
//    }
//    return nil;
//    
//    
//}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
