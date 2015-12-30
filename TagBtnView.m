//
//  TagBtnView.m
//  MobileStudy
//
//  Created by henry on 15/12/29.
//
//

#import "TagBtnView.h"

@implementation TagBtnView {
    UIScrollView        *navgationTabView;
    UIView              *underLine;
    NSUInteger          cliciIndex;
}


-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initBaseScrollView];
        underLine = [[UIView alloc] init];
        underLine.backgroundColor = CreateColorByRGB(TitleBgImgViewColor);
        [self addSubview:underLine];
    }
    return self;
}

-(void)initBaseScrollView {
    navgationTabView = [[UIScrollView alloc] initWithFrame:self.bounds];
    navgationTabView.backgroundColor = [UIColor whiteColor];
    navgationTabView.showsHorizontalScrollIndicator = NO;
    navgationTabView.delegate = self;
    [self addSubview:navgationTabView];
}
/**
 *  重新加载数据，数据即为bar
 */
-(void) ReloadData {
    //先移除之前的
    for(UIButton *btn in self.myTagBarArr)
    {
        [btn removeFromSuperview];
    }
    
    //重新设置新的
    self.myTagBarArr = [self.dataSourceDelegate tagBarDataArray];
    
    //添加事件
    CGFloat allWith = 0.0;
    for(UIButton *btn in self.myTagBarArr)
    {
        if([btn respondsToSelector:@selector(addTarget:action:forControlEvents:)])
        {
            btn.frame = CGRectMake(allWith, 0, btn.width, 30);
            [btn addTarget:self action:@selector(btPressed:) forControlEvents:UIControlEventTouchUpInside];
            
            [navgationTabView addSubview:btn];
            if (btn.tag == cliciIndex) {
                [btn setSelected:YES];
            }
        }
        btn.layer.cornerRadius = 3;
        allWith += (btn.width + 20);
    }
    
    navgationTabView.contentSize = CGSizeMake(allWith, 30);
}
/**
 *  按钮点击事件
 *
 *  @param btn 点击的按钮
 */
-(void) btPressed:(UIButton *) btn
{
    //点击按钮视图滑动
    float x = navgationTabView.frame.size.width * (btn.tag - 1) * (60 / self.frame.size.width) - 60;
    [navgationTabView scrollRectToVisible:CGRectMake(x, 0, navgationTabView.frame.size.width, navgationTabView.frame.size.height) animated:YES];
    
    [self.touchDelegate clickTagBarAt:btn.tag];
}

/**
 *  设置选中按钮的选中状态
 *
 *  @param index 选中按钮
 */
-(void) SetHighTag:(NSInteger) index
{
    cliciIndex = index;
    for (int i=0; i < [self.myTagBarArr count]; ++i)
    {
        UIButton *bt = [self.myTagBarArr objectAtIndex:i];
        
        if (bt.tag == index)
        {
            if([bt respondsToSelector:@selector(setSelected:)])
            {
                [bt setSelected:YES];
                underLine.frame = CGRectMake(bt.frame.origin.x, self.height - 2, bt.frame.size.width, 2);
            }
        }
        else
        {
            if([bt respondsToSelector:@selector(setSelected:)])
            {
                [bt setSelected:NO];
            }
        }
    }
}

@end
