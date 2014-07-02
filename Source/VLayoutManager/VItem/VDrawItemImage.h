//
//  PKDrawItemImage.h
//  Vote
//
//  Created by yuan on 13-12-30.
//  Copyright (c) 2013年 yuan.he. All rights reserved.
//

#import "VDrawItem.h"

typedef enum
{
    VDrawItemModeFill,
    VDrawItemModeAbscrat
}VDrawItemMode;

typedef enum
{
    VDrawItemTypeNoraml,
    VDrawItemTypeHighlighted
}VDrawItemType;

@interface VDrawItemImage : VDrawItem

@property (nonatomic, strong)  UIImage *image;
@property (nonatomic, strong)  NSString *imageName;
@property (nonatomic, assign)  BOOL isLocalImage;
@property (nonatomic, assign)  VDrawItemMode mode;
@property (nonatomic, assign)  VDrawItemType type;

@end
