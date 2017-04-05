//
//  TagBtnView.h
//  MobileStudy
//
//  Created by henry on 15/12/29.
//
//

#import <UIKit/UIKit.h>

@protocol TagBtnTouchDelegate <NSObject>

/**
 *  点击标签
 *
 *  @param index 标签的tag值
 */
-(void)clickTagBarAt:(NSInteger)index;


@end

@interface TagBtnView : UIView <UIScrollViewDelegate>

/**
 *  标签按钮数组
 */
@property(nonatomic, strong) NSArray<NSString *> *myTagBarArr;
/**
 当前选中的下标
 */
@property(nonatomic, assign) NSUInteger          currIndex;
/**
 *  点击代理
 */
@property(nonatomic, weak) id<TagBtnTouchDelegate>touchDelegate;
/**
 *  设置选中按钮的选中状态
 *
 *  @param index 按钮tag
 */
-(void)SetHighTag:(NSInteger)index;

@end
