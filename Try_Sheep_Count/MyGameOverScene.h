//
//  MyGameOverScene.h
//  Try_Sheep_Count
//
//  Created by irons on 2015/4/21.
//  Copyright (c) 2015年 irons. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "MyScene.h"

@interface MyGameOverScene : SKScene

@property (nonatomic) NSTimeInterval lastSpawnTimeInterval;
@property (nonatomic) NSTimeInterval lastUpdateTimeInterval;
@property (nonatomic) SKSpriteNode *backgroundNode;
@property (nonatomic) SKScene *periousScene;
@property (nonatomic, assign) id<returnToMySceneDelegate> delegate;

@end
