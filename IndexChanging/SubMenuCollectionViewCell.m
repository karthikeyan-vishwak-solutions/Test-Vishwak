//
//  SubMenuCollectionViewCell.m
//  MMRevanp2016
//
//  Created by Sureshbabu Naidu on 6/6/16.
//  Copyright © 2016 Vishwak Sol pvt. ltd. All rights reserved.
//

#import "SubMenuCollectionViewCell.h"

@implementation SubMenuCollectionViewCell
@synthesize lblSubMenu;


-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        lblSubMenu = [[UILabel alloc]init];
        [lblSubMenu setFont:[UIFont systemFontOfSize:14]];
        lblSubMenu.textAlignment=NSTextAlignmentCenter;
        [lblSubMenu setBackgroundColor:[UIColor clearColor]];
        [self addSubview:lblSubMenu];
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    CGSize size = self.contentView.frame.size;
    [lblSubMenu setFrame:CGRectMake(0, 0, size.width, 40)];
}
@end
