//
//  AVViewController.m
//  IndexChanging
//
//  Created by Dinesh Reddy.C on 9/27/16.
//  Copyright © 2016 Vishwak. All rights reserved.
//

#import "AVViewController.h"
@import AVFoundation;
@import AVKit;
@interface AVViewController ()
- (IBAction)playPauseAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btn;

@end

@implementation AVViewController
- (IBAction)playPauseAction:(id)sender{
//    if ([[(UIButton *)sender currentTitle] isEqualToString:@"Play"]) {
//        [self.playerView playVideo];
//        [(UIButton *)sender setTitle:@"Pause" forState:UIControlStateNormal];
//    }else{
//        [self.playerView pauseVideo];
//        [(UIButton *)sender setTitle:@"Play" forState:UIControlStateNormal];
//    }
    
    //normal url
    NSURL *videoURL = [NSURL URLWithString:@"https://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4"];
    AVPlayer *player = [AVPlayer playerWithURL:videoURL];
    AVPlayerViewController *playerViewController = [AVPlayerViewController new];
    playerViewController.player = player;
    [self presentViewController:playerViewController animated:YES completion:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.playerView loadWithVideoId:@"8qy28gk0FSM"];
//v=8qy28gk0FSM
    //M7lc1UVf-VE
    // Do any additional setup after loading the view.
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
