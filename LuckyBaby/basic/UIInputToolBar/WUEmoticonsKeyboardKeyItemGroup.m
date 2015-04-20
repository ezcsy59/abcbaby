//
//  WUEmoticonsKeyboardKeyItemGroup.m
//  WeicoUI
//
//  Created by YuAo on 1/24/13.
//  Copyright (c) 2013 微酷奥(北京)科技有限公司. All rights reserved.
//

#import "WUEmoticonsKeyboardKeyItemGroup.h"
#import "WUEmoticonsKeyboardKeyCell.h"
#import "WUEmoticonsKeyboardKeysPageFlowLayout.h"

@implementation WUEmoticonsKeyboardKeyItemGroup
@synthesize keyItemCellClass = _keyItemCellClass;

- (Class)keyItemCellClass {
    if (!_keyItemCellClass) {
        _keyItemCellClass = [WUEmoticonsKeyboardKeyCell class];
    }
    return _keyItemCellClass;
}

- (UICollectionViewLayout *)keyItemsLayout {
    if (!_keyItemsLayout) {
        WUEmoticonsKeyboardKeysPageFlowLayout *layout = [[WUEmoticonsKeyboardKeysPageFlowLayout alloc] init];
        //2014.01.17 改变表情大小 和间隔行距
        layout.itemSize = CGSizeMake(30, 30);
        layout.pageContentInsets = UIEdgeInsetsMake(5, 5, 5, 5);
        layout.itemSpacing = 15;
        layout.lineSpacing = 6;
        _keyItemsLayout = layout;
    }
    return _keyItemsLayout;
}

- (void)setKeyItemCellClass:(Class)keyItemCellClass {
    if ([keyItemCellClass isSubclassOfClass:[WUEmoticonsKeyboardKeyCell class]]) {
        _keyItemCellClass = keyItemCellClass;
    }else{
        NSAssert(NO, @"WUEmoticonsKeyboardKeyItemGroup: Setting keyItemCellClass - keyItemCellClass must be a subclass of WUEmoticonsKeyboardKeyCell.class");
    }
}

@end
