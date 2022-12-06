//
//  MyGameScoreScene.h
//  Try_Sheep_Count
//
//  Created by irons on 2015/4/28.
//  Copyright (c) 2015年 irons. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "MyScene.h"

@interface MyGameScoreScene : SKScene

@property (nonatomic) SKScene *periousScene;
@property (nonatomic) int sheepGameScore;
@property (nonatomic) bool updateSheepGameScore;
@property (nonatomic, assign) id<returnToMySceneDelegate> delegate;

+ (void)updateSheepGameScore;

@end
