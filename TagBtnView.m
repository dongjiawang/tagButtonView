//
//  TagBtnView.m
//  MobileStudy
//
//  Created by henry on 15/12/29.
//
//

#import "TagBtnView.h"

@interface TagBtnView ()

@property (nonatomic, strong) NSMutableArray<UIButton *>    *btnArray;

@end

@implementation TagBtnView {
    UIScrollView        *navgationTabView;
    UIView              *underLine;
}


-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self initBaseScrollView];
        underLine = [[UIView alloc] init];
        underLine.backgroundColor = [UIColor redColor];
        [navgationTabView addSubview:underLine];
        _btnArray = [NSMutableArray array];
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

- (void)setMyTagBarArr:(NSArray *)myTagBarArr {
    //先移除之前的
    if (_btnArray > 0) {
        for(UIButton *btn in _btnArray) {
            [btn removeFromSuperview];
        }
    }
    
    _myTagBarArr = myTagBarArr;
    CGFloat allWith = 0.0;
    for (int i = 0; i < myTagBarArr.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.titleLabel.font = [UIFont systemFontOfSize:16.0];
        [btn setTitle:myTagBarArr[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        CGSize titleSize = [btn.titleLabel.text sizeWithAttributes:@{NSFontAttributeName : btn.titleLabel.font}];
        btn.frame = CGRectMake(0, 0, titleSize.width+30, 30);
        btn.tag = i;
        btn.backgroundColor = [UIColor clearColor];
        
        //添加事件
        
        btn.frame = CGRectMake(allWith, 0, btn.width, navgationTabView.bounds.size.height);
        [btn addTarget:self action:@selector(btPressed:) forControlEvents:UIControlEventTouchUpInside];
        [navgationTabView addSubview:btn];
        if (btn.tag == _currIndex) {
            [btn setSelected:YES];
        }
        btn.layer.cornerRadius = 3;
        allWith += (btn.width + 20);
        
        [_btnArray addObject:btn];
    }
    
    navgationTabView.contentSize = CGSizeMake(allWith, 30);
}

/**
 *  按钮点击事件
 *
 *  @param btn 点击的按钮
 */
-(void)btPressed:(UIButton *)btn {
    [self.touchDelegate clickTagBarAt:btn.tag];
    [self SetHighTag:btn.tag];
}

/**
 *  设置选中按钮的选中状态
 *
 *  @param index 选中按钮
 */
-(void)SetHighTag:(NSInteger)index {
    if (_currIndex == index) return;
    _currIndex = index;
    for (int i=0; i < _btnArray.count; ++i) {
        UIButton *bt = _btnArray[i];
        
        if (bt.tag == index) {
            if([bt respondsToSelector:@selector(setSelected:)]) {
                [bt setSelected:YES];
                underLine.frame = CGRectMake(bt.frame.origin.x, self.frame.size.height - 2, bt.frame.size.width, 2);
            }
        }
        else {
            if([bt respondsToSelector:@selector(setSelected:)]) {
                [bt setSelected:NO];
            }
        }
    }
    //点击按钮视图滑动
    UIButton *btn = _btnArray[index];
    float x = 0;
    if ((btn.frame.origin.x + btn.frame.size.width) > (navgationTabView.frame.size.width - 20)) {
        x = btn.frame.origin.x - 60;
    }
    [navgationTabView scrollRectToVisible:CGRectMake(x, 0, navgationTabView.frame.size.width, navgationTabView.frame.size.height) animated:YES];
}

@end
