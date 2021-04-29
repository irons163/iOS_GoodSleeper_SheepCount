//
//  ViewController.m
//  Try_Sheep_Count
//
//  Created by irons on 2015/4/8.
//  Copyright (c) 2015年 ___FULLUSERNAME___. All rights reserved.
//

#import "ViewController.h"
#import "MyScene.h"
#import "GameOverViewController.h"

bool isFirstLoad = true;

@implementation ViewController {
    MyScene * scene;
    ADBannerView * adBannerView;
    GADInterstitial *interstitial;
}

- (void)viewDidLoad {
    adBannerView = [[ADBannerView alloc] initWithFrame:CGRectMake(0, -50, 200, 30)];
    adBannerView.delegate = self;
    adBannerView.alpha = 1.0f;
    [self.view addSubview:adBannerView];
    
    
    NSLog(@"Google Mobile Ads SDK version: %@", [GADRequest sdkVersion]);
    
//    interstitial = [self createAndLoadInterstitial];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    if(isFirstLoad){
        isFirstLoad = false;
        
        SKView * skView = (SKView *)self.view;
        scene = [MyScene sceneWithSize:skView.frame.size];
        scene.scaleMode = SKSceneScaleModeAspectFill;
        
        // Present the scene.
        [skView presentScene:scene];
        
        scene.onGameOver = ^(int gameScore){
            [self showScore:gameScore];
        };
        
        scene.showAdmob = ^(){
            dispatch_async(dispatch_get_main_queue(), ^{
//                [self showAdmob];
            });
        };
        
    }
}

- (BOOL)shouldAutorotate {
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (void)showScore:(int)gameScore {
    GameOverViewController* gameOverDialogViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"GameOverViewController"];
    gameOverDialogViewController.delegate = self;
    
    gameOverDialogViewController.gameScore = gameScore;
    
    self.navigationController.modalPresentationStyle = UIModalPresentationCurrentContext;
    
    [self.navigationController presentViewController:gameOverDialogViewController animated:YES completion:^{
    }];
}

- (void)showAdmob {
    if ([interstitial isReady]) {
        [interstitial presentFromRootViewController:self];
    }
}

- (void)bannerViewDidLoadAd:(ADBannerView *)banner {
    [self layoutAnimated:true];
}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error {
    [self layoutAnimated:true];
}

- (void)layoutAnimated:(BOOL)animated {
    CGRect contentFrame = self.view.bounds;
    CGRect bannerFrame = adBannerView.frame;
    if (adBannerView.bannerLoaded) {
        contentFrame.size.height = 0;
        bannerFrame.origin.y = contentFrame.size.height;
    } else {
        bannerFrame.origin.y = contentFrame.size.height;
    }
    
    [UIView animateWithDuration:animated ? 0.25 : 0.0 animations:^{
        adBannerView.frame = contentFrame;
        [adBannerView layoutIfNeeded];
        adBannerView.frame = bannerFrame;
    }];
}


- (GADInterstitial *)createAndLoadInterstitial {
    GADInterstitial *interstitial = [[GADInterstitial alloc] init];
    interstitial.adUnitID = @"ca-app-pub-2566742856382887/8779587052";
    interstitial.delegate = self;
    [interstitial loadRequest:[GADRequest request]];
    return interstitial;
}

- (void)interstitialDidDismissScreen:(GADInterstitial *)interstitial {
    self->interstitial = [self createAndLoadInterstitial];
}

@end
