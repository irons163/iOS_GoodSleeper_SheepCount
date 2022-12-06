//
//  MyScene.h
//  Try_Sheep_Count
//

//  Copyright (c) 2015年 ___FULLUSERNAME___. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@protocol returnToMySceneDelegate <NSObject>

- (void)startTimer;

@end

@interface MyScene : SKScene <returnToMySceneDelegate>

typedef void(^gameOverDialog)(int);
@property (atomic, copy) gameOverDialog onGameOver;

typedef void(^admob)();
@property (atomic, copy) admob showAdmob;

@property (nonatomic) NSTimeInterval lastSpawnTimeInterval;
@property (nonatomic) NSTimeInterval lastUpdateTimeInterval;

- (void)set;

@end
