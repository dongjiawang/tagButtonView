//
//  TagBtnView.h
//  MobileStudy
//
//  Created by henry on 15/12/29.
//
//

#import <UIKit/UIKit.h>

@protocol TagBtnDataSourceDelegate <NSObject>

/**
 *  标签数据源
 *
 */
-(NSArray *) tagBarDataArray;

@end

@protocol TagBtnTouchDelegate <NSObject>

/**
 *  点击标签
 *
 *  @param index 标签的tag值
 */
-(void) clickTagBarAt:(NSInteger) index;


@end

@interface TagBtnView : UIView <UIScrollViewDelegate>

/**
 *  标签按钮数组
 */
@property(nonatomic, strong) NSArray *myTagBarArr;
/**
 *  数据源代理
 */
@property(nonatomic, weak) id<TagBtnDataSourceDelegate>dataSourceDelegate;
/**
 *  点击代理
 */
@property(nonatomic, weak) id<TagBtnTouchDelegate>touchDelegate;
/**
 *  设置选中按钮的选中状态
 *
 *  @param index 按钮tag
 */
-(void) SetHighTag:(NSInteger) index;
/**
 *  重新加载标签栏数据，根据数据创建按钮
 */
-(void) ReloadData;

@end
