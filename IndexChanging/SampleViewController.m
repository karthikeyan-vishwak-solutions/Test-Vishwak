//
//  SampleViewController.m
//  MMRevanp2016
//
//  Created by Sureshbabu Naidu on 9/5/16.
//  Copyright © 2016 Vishwak Sol pvt. ltd. All rights reserved.
//

#import "SampleViewController.h"
#import "SubMenuCollectionViewCell.h"
@import AVKit;
@import AVFoundation;
@interface SampleViewController (){
    NSMutableArray *subMenu;
    float selectedOffset;
    NSMutableArray *topArray;
    NSMutableArray *bottomArray;
    NSMutableArray *commonArray;
    int selectedIndex;
    int pageCount;
    int scale;
    int getNotify;
    int articalInt;
    int articalIntSection;
    
    BOOL scrollDirection;

}
@property (nonatomic) CGFloat lastContentOffset;

@end
@implementation SampleViewController
@synthesize submenuCollectionView,homeNewsCollectionView;
//-(void)makeDatasoruce{
//    for (int i = 0; i < 20; i++) {
//        [bottomArray addObject:[NSString stringWithFormat:@"%d",i]];
//    }
//
//}
-(NSMutableArray *)createSectionWithArtical{
    int totalSection = 2;
    int tempArticalCount = 0;
    NSMutableDictionary *articalJson;
    NSMutableArray *articalArray;
    NSMutableDictionary *sectionJson;
    NSMutableArray *finalArray = [NSMutableArray array];
    for (int i = 0; i <= totalSection; i++) {
        sectionJson = [NSMutableDictionary dictionary];
        NSMutableDictionary *tempDic = [NSMutableDictionary dictionary];
        [tempDic setObject:[NSString stringWithFormat:@"%d",i] forKey:@"sectionId"];
        if (i == 0) {
            tempArticalCount = 5;
        }else if (i == 1){
            tempArticalCount = 10;
        }else{
            tempArticalCount = 15;
        }
        articalArray =[NSMutableArray array];
        for (int j = 0; j < tempArticalCount; j++) {
            articalJson = [NSMutableDictionary dictionary];
            [articalJson setObject:[NSString stringWithFormat:@"%d",j] forKey:@"articalId"];
            [articalArray addObject:articalJson];
        }
        [tempDic setObject:articalArray forKey:@"articals"];
        [finalArray addObject:tempDic];
    }
    return  finalArray;
}
- (void)viewDidLoad{
    [super viewDidLoad];
    scale = 1.0;
    subMenu = [[NSMutableArray alloc]init];
    topArray = [NSMutableArray array];
    bottomArray = [NSMutableArray array];
    commonArray = [NSMutableArray array];
    commonArray = [self createSectionWithArtical];
//    for (int i = 0; i < 3; i++) {
//        [topArray addObject:[NSString stringWithFormat:@"%d",i]];
//    }
   // [self makeDatasoruce];
    getNotify = 0;
    selectedIndex = 0;
    selectedOffset = 0.0;
    articalIntSection = 0;
    [submenuCollectionView registerClass:[SubMenuCollectionViewCell class] forCellWithReuseIdentifier:@"subMenuCell"];
    [homeNewsCollectionView registerClass:[SubMenuCollectionViewCell class] forCellWithReuseIdentifier:@"subMenuCell"];
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
//    flowLayout.minimumLineSpacing = 0;
//    flowLayout.minimumLineSpacing = 0;
   // [self.homeNewsCollectionView setPagingEnabled: YES];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    [self.homeNewsCollectionView setCollectionViewLayout:flowLayout];

}

#pragma mark UIcollectionView Delegate Methods
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (collectionView == submenuCollectionView){
        return [commonArray count];
    }else{
        NSDictionary  *tempDic = [commonArray objectAtIndex:articalIntSection];
         articalInt = (int)[[tempDic valueForKey:@"articals"]count];
        return articalInt;
    }
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView == submenuCollectionView){
        return CGSizeMake(100, submenuCollectionView.frame.size.height);
    }else{
        return CGSizeMake((((homeNewsCollectionView.frame.size.width)/2)), homeNewsCollectionView.frame.size.height-20);
    }
    
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
     SubMenuCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"subMenuCell"  forIndexPath:indexPath];
    cell.layer.shouldRasterize = YES;
    cell.layer.rasterizationScale = [UIScreen mainScreen].scale;
    [cell.lblSubMenu setText:[NSString stringWithFormat:@"Cell #%ld",(long)indexPath.item]];
     [cell setBackgroundColor:[UIColor whiteColor]];
    if (collectionView == submenuCollectionView){
        cell.lblSubMenu.textColor = indexPath.row == selectedIndex ? [UIColor redColor] : [UIColor blackColor];
    }
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    int tempInt = 0;
    int tempSelectedInt = 0;
    if (collectionView == submenuCollectionView){
        tempInt = tempInt + indexPath.item;
        articalIntSection = tempInt;
        tempSelectedInt = tempSelectedInt + indexPath.item;
        selectedIndex = tempSelectedInt;
        if (articalIntSection >=[commonArray count]) {
            
        }else{
            [submenuCollectionView reloadData];
            [homeNewsCollectionView reloadData];
            [self.homeNewsCollectionView setContentOffset:CGPointMake(0, 0)];
    }
    }
}
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView == submenuCollectionView){
        static NSString *identifier = @"cellNew";
        SubMenuCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
        [cell.lblSubMenu setTextColor:[UIColor blackColor]];
    }else{
        
    }
}


//- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    CGRect visibleRect = (CGRect){.origin = self.homeNewsCollectionView.contentOffset, .size = self.homeNewsCollectionView.frame.size};
//    CGPoint visiblePoint = CGPointMake(CGRectGetMidX(visibleRect), CGRectGetMidY(visibleRect));
//    NSIndexPath *visibleIndexPath = [self.homeNewsCollectionView indexPathForItemAtPoint:visiblePoint];
//    
//    if (selectedOffset > scrollView.contentOffset.x){
//        if ([self shouldReloadDataAtIndex:visibleIndexPath.row+1]) {
//            [self setSelectedIndexForPageIndex:visibleIndexPath.row+1];
//            return;
//        }
//    }
//    selectedOffset = scrollView.contentOffset.x;
//}




- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [scrollView setLastContentOffset:scrollView.contentOffset];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (scrollView == homeNewsCollectionView){
        if (scale == 1.0){
            [self calledAfterEndOfScroll:scrollView];
        }
        
    }
    CGRect visibleRect = (CGRect){.origin = self.homeNewsCollectionView.contentOffset, .size = self.homeNewsCollectionView.frame.size};
    CGPoint visiblePoint = CGPointMake(CGRectGetMidX(visibleRect), CGRectGetMidY(visibleRect));
    NSIndexPath *visibleIndexPath = [self.homeNewsCollectionView indexPathForItemAtPoint:visiblePoint];
    if (scrollView.scrollDirectionX == ScrollDirectionRight) {
        //Do something with your views etc
        
        if (visibleIndexPath.row == 0)
        {
            [self CalledOnRightSideMove];
        }
        NSLog(@"scrolling right side %d",visibleIndexPath.row);
        scrollDirection = YES;
    }else{
        NSLog(@"scrolling left side");
        scrollDirection = NO;
        if ([self shouldReloadDataAtIndex:visibleIndexPath.row+1]) {
            [self setSelectedIndexForPageIndex:visibleIndexPath.row+1];
            return;
        }
    }
    selectedOffset = scrollView.contentOffset.x;
    
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView == homeNewsCollectionView){
        if (scale == 1.0){
            [self calledAfterEndOfScroll:scrollView];
        }
    }
    
}
-(void)CalledOnRightSideMove{
    articalIntSection = articalIntSection - 1;
    selectedIndex = selectedIndex - 1;
    if (articalIntSection < 0 && selectedIndex <0){
        articalIntSection = 0;
    }else{
        dispatch_async(dispatch_get_main_queue(), ^{
            [submenuCollectionView reloadData];
            [homeNewsCollectionView reloadData];
        });
        dispatch_async(dispatch_get_main_queue(), ^{
            [UIView performWithoutAnimation:^{
                [UIView animateWithDuration:0
                                      delay:0
                                    options:1
                                 animations:^{
                                     
                                     [self.homeNewsCollectionView setContentOffset:CGPointMake(articalInt*((homeNewsCollectionView.frame.size.width)/2), 0) animated:NO];
                                 } completion:nil];
            }];
            
           
        });
    }
    
}

-(void)previousDirection{
    articalIntSection = articalIntSection + 1;
    selectedIndex = selectedIndex + 1;
    [submenuCollectionView reloadData];
    [homeNewsCollectionView reloadData];
}
-(void)setSelectedIndexForPageIndex:(int)pageIndex{
    int tempIndex = pageIndex;
    if (tempIndex / articalInt < [commonArray count]) {
        if (scrollDirection == YES) {
            //right side
            
        }else{
            //left side
            articalIntSection = articalIntSection + 1;
            selectedIndex = selectedIndex + 1;
            if (articalIntSection >=[commonArray count]) {
                articalIntSection = articalIntSection - 1;
                selectedIndex = selectedIndex - 1;
            }else{
                [self.homeNewsCollectionView setContentOffset:CGPointMake(0, 0)];
            }
        }
        [submenuCollectionView reloadData];
        [homeNewsCollectionView reloadData];
    }
}

-(BOOL)shouldReloadDataAtIndex:(long)index{
    return index % articalInt == 0;
}

-(void)calledAfterEndOfScroll:(UIScrollView *)scrollView{
    homeNewsCollectionView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    float currentOffset = scrollView.contentOffset.x;
    float pageIndex = currentOffset/(homeNewsCollectionView.frame.size.width/2);
    pageCount = (int)pageIndex;
    float decimalValue = fmod(pageIndex, 1.0);
    if (decimalValue>0.8){
        pageCount =pageCount+1;
    }else{
    }
    if (articalIntSection >= [commonArray count]) {
        return;
    }else{

    NSIndexPath *iPath = [NSIndexPath indexPathForItem:pageCount inSection:0];
    [homeNewsCollectionView scrollToItemAtIndexPath:iPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
    }
}


@end
