//
//  TestingViewController.m
//  IndexChanging
//
//  Created by Dinesh Reddy.C on 9/30/16.
//  Copyright © 2016 Vishwak. All rights reserved.
//

#import "TestingViewController.h"

@interface TestingViewController ()<UIScrollViewDelegate>
@property (nonatomic) UIImageView *imageViewPointer;

@end

@implementation TestingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.clipsToBounds = YES;
    UIImageView *imageView = [[UIImageView alloc] init];
    UIImage* image = [UIImage imageNamed:@"GravityMapMoonGRAIL_732X520.jpg"];
    [imageView setImage:image];
    [self.view addSubview:scrollView];
    [scrollView addSubview:imageView];
    
    scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    imageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.imageViewPointer = imageView;
    scrollView.maximumZoomScale = 2;
    scrollView.minimumZoomScale = .5;
    scrollView.delegate = self;
    scrollView.contentSize = image.size;
    
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(scrollView,imageView);
    NSLog(@"Current views dictionary: %@", viewsDictionary);
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[scrollView]|" options:0 metrics:nil views:viewsDictionary]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[scrollView]|" options:0 metrics:nil views:viewsDictionary]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[imageView(width)]" options:0 metrics:@{@"width":@(self.imageViewPointer.image.size.width)} views:viewsDictionary]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[imageView(height)]" options:0 metrics:@{@"height":@(self.imageViewPointer.image.size.height)} views:viewsDictionary]];
    // Do any additional setup after loading the view.
}
-(UIView*)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    NSLog(@"Current views dictionary: %@", scrollView);
    return self.imageViewPointer;
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
