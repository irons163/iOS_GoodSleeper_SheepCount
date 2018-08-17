 //
//  MyScene.m
//  Try_Sheep_Count
//
//  Created by irons on 2015/4/8.
//  Copyright (c) 2015年 ___FULLUSERNAME___. All rights reserved.
//

#import "MyScene.h"
#import "TextureHelper.h"
#import "MyGameOverScene.h"
#import "MyGameScoreScene.h"
#import <AudioToolbox/AudioToolbox.h>

SKSpriteNode * bar;

int barHeight;
bool touching = false;

#define DEFAULT_SHEEP_LEFT_MAX  6

@implementation MyScene{
    NSMutableArray * sheepArray;
    NSMutableArray * sheepArrayLeft;
    SKSpriteNode * gamePointSingleNode, *gamePointTenNode, *gamePointHunNode, *gamePointTHUNode;
    SKSpriteNode * sheepTextNode;
    int sheepGameScore;
    int gamePointX;
    Boolean isGameRun;
    int ccount;
    NSTimer * timer;
    int sheepLeftMax;
    bool isSheepTouchable;
    double periousTime;
}


-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
//        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
        
        sheepLeftMax = DEFAULT_SHEEP_LEFT_MAX;
        isSheepTouchable = true;
        
        [TextureHelper initTextures];
        
        sheepArray = [[NSMutableArray alloc] init];
        sheepArrayLeft = [[NSMutableArray alloc] init];
        
        isGameRun = true;
        
        SKSpriteNode * backgroundNode = [SKSpriteNode spriteNodeWithImageNamed:@"bg01"];
        
        backgroundNode.size = self.frame.size;
        backgroundNode.anchorPoint = CGPointMake(0, 0);
        backgroundNode.position = CGPointMake(0, 0);
        
        
        [self addChild:backgroundNode];
        
        int gamePointNodeWH = 30;
        
        gamePointX = self.frame.size.width/4;
        int gamePointY = self.frame.size.height*6/8.0;
//        int gamePointY = self.frame.size.height - 50;
        
        gamePointSingleNode = [SKSpriteNode spriteNodeWithTexture:[self getTimeTexture:sheepGameScore%10]];
        gamePointSingleNode.anchorPoint = CGPointMake(0, 0);
        gamePointSingleNode.size = CGSizeMake(gamePointNodeWH, gamePointNodeWH);
        gamePointSingleNode.position = CGPointMake(gamePointX, gamePointY);
//        gamePointSingleNode.zPosition = backgroundLayerZPosition;
        
        gamePointTenNode = [SKSpriteNode spriteNodeWithTexture:[self getTimeTexture:(sheepGameScore)/10]];
        gamePointTenNode.anchorPoint = CGPointMake(0, 0);
        gamePointTenNode.size = CGSizeMake(gamePointNodeWH, gamePointNodeWH);
        gamePointTenNode.position = CGPointMake(gamePointX - gamePointNodeWH, gamePointY);
//        gamePointTenNode.zPosition = backgroundLayerZPosition;
        
        
        gamePointHunNode = [SKSpriteNode spriteNodeWithTexture:[self getTimeTexture:(sheepGameScore)/100]];
        gamePointHunNode.anchorPoint = CGPointMake(0, 0);
        gamePointHunNode.size = CGSizeMake(gamePointNodeWH, gamePointNodeWH);
        gamePointHunNode.position = CGPointMake(gamePointX - gamePointNodeWH*2, gamePointY);
        
        gamePointTHUNode = [SKSpriteNode spriteNodeWithTexture:[self getTimeTexture:(sheepGameScore)/10]];
        gamePointTHUNode.anchorPoint = CGPointMake(0, 0);
        gamePointTHUNode.size = CGSizeMake(gamePointNodeWH, gamePointNodeWH);
        gamePointTHUNode.position = CGPointMake(gamePointX - gamePointNodeWH*3, gamePointY);
        
        [self addChild:gamePointSingleNode];
        [self addChild:gamePointTenNode];
        [self addChild:gamePointHunNode];
        [self addChild:gamePointTHUNode];
        
//        if(sheepGameScore < 10){
//            gamePointSingleNode.hidden = false;
//            gamePointTenNode.hidden = true;
//            gamePointHunNode.hidden = true;
//            gamePointTHUNode.hidden = true;
//            
//            gamePointSingleNode.texture = [self getTimeTexture:sheepGameScore%10];
//        }else if(sheepGameScore < 100){
//            gamePointSingleNode.hidden = false;
//            gamePointTenNode.hidden = false;
//            gamePointHunNode.hidden = true;
//            gamePointTHUNode.hidden = true;
//            
//            gamePointSingleNode.texture = [self getTimeTexture:sheepGameScore%10];
//            gamePointTenNode.texture = [self getTimeTexture:sheepGameScore/10];
//        }else if(sheepGameScore < 1000){
//            gamePointSingleNode.hidden = false;
//            gamePointTenNode.hidden = false;
//            gamePointHunNode.hidden = false;
//            gamePointTHUNode.hidden = true;
//            
//            gamePointSingleNode.texture = [self getTimeTexture:sheepGameScore%10];
//            gamePointTenNode.texture = [self getTimeTexture:sheepGameScore/10%10];
//            gamePointHunNode.texture = [self getTimeTexture:sheepGameScore/100];
//        }else{
//            gamePointSingleNode.hidden = false;
//            gamePointTenNode.hidden = false;
//            gamePointHunNode.hidden = false;
//            gamePointTHUNode.hidden = false;
//            
//            gamePointSingleNode.texture = [self getTimeTexture:sheepGameScore%10];
//            gamePointTenNode.texture = [self getTimeTexture:sheepGameScore/10%10];
//            gamePointHunNode.texture = [self getTimeTexture:sheepGameScore/100%10];
//            gamePointTHUNode.texture = [self getTimeTexture:sheepGameScore/1000%10];
//        }
        
        sheepTextNode = [SKSpriteNode spriteNodeWithImageNamed:@"sheep_text"];
        
        sheepTextNode.anchorPoint = CGPointMake(0, 0);
        
        sheepTextNode.size = CGSizeMake(gamePointNodeWH*4.2, gamePointNodeWH*1.5);
        sheepTextNode.position = CGPointMake(gamePointX - gamePointSingleNode.size.width*3, gamePointY - gamePointSingleNode.size.height - 10);
        
        [self addChild:sheepTextNode];
        
        int screenHeight = self.frame.size.height;
        int screenWidth = self.frame.size.width;
        
        barHeight = self.frame.size.height*4/5.0;
        
        bar = [SKSpriteNode spriteNodeWithImageNamed:@"bar"];
        
        bar.size = CGSizeMake(50, barHeight);
        bar.position = CGPointMake(self.frame.size.width*1/3.0, self.frame.size.height/2 - barHeight/6);
        
        [self addChild:bar];
        
        for(int i = 0; i <10; i++){
            SKSpriteNode * sheep = [self createSheep];
            [sheepArray addObject:sheep];
            [self addChild:sheep];
        }
        
        [self startTimer];
        
    }
    return self;
}

-(void)sheepMove:(SKSpriteNode*)sheep{
//    sheep.position = CGPointMake(self.frame.size.width, 200);
    
    SKAction * actionMove = [SKAction moveTo:CGPointMake(10, 200) duration:3];
    
//    int randomx = ra
    
    actionMove = [SKAction moveBy:CGVectorMake(sheep.position.x-50, sheep.position.y-50) duration:2];
    
    actionMove = [SKAction moveByX:-50 y:-50 duration:2];
    
    [sheep runAction:actionMove];
}

-(void)sheepWalkL:(SKSpriteNode*)sheep{
    
    int x = arc4random_uniform(161)-80;
    int y = arc4random_uniform(81)-40;
    
    if(sheep.position.x - sheep.size.width/2 + x < 0){
        x = 0 - (sheep.position.x - sheep.size.width/2);
    }else if(sheep.position.x + sheep.size.width + x > bar.position.x){
        x = bar.position.x - (sheep.position.x + sheep.size.width);
    }
    
    if(sheep.position.y - sheep.size.height/2 + y < 0){
        y = 0 - (sheep.position.y - sheep.size.height/2);
    }else if(sheep.position.y + sheep.size.height + y > barHeight){
        y = barHeight - (sheep.position.y + sheep.size.height);
    }
    
    if (x>0) {
        sheep.xScale = -1;
    }else{
        sheep.xScale = 1;
    }
    
    SKTexture * texture = [SKTexture textureWithImageNamed:@"sheep_mimi01"];
    SKTexture * texture2 = [SKTexture textureWithImageNamed:@"sheep_mimi02"];
    SKTexture * texture3 = [SKTexture textureWithImageNamed:@"sheep_mimi03"];
    
    NSArray * nsArray = @[texture, texture2, texture3];
    
    SKAction *sheepAnimation = [SKAction animateWithTextures:nsArray timePerFrame:0.3];
    
    sheepAnimation = [SKAction repeatActionForever:sheepAnimation];
    
    SKAction * delayAction = [SKAction waitForDuration:1.0];
    
    SKAction * randomWalk = [SKAction runBlock:^{
        [self sheepWalkL:sheep];
    }];
    
    SKAction * end = [SKAction runBlock:^{
        [sheep removeAllActions];
        [sheep runAction:[SKAction sequence:@[[SKAction runBlock:^{
            sheep.texture = [SKTexture textureWithImageNamed:@"sheep1"];
        }], delayAction, randomWalk]]];
        sheep.texture = [SKTexture textureWithImageNamed:@"sheep1"];
    }];
    
    SKAction * actionMove = [SKAction moveByX:x y:y duration:2];
    
    //    [sheep runAction:[SKAction sequence:@[actionMove, end]]];
    [sheep runAction:[SKAction group:@[[SKAction sequence:@[actionMove, end]], sheepAnimation]]];
}

-(void)sheepWalkR:(SKSpriteNode*)sheep{
    
    int x = arc4random_uniform(161)-80;
    int y = arc4random_uniform(81)-40;
    
    if(sheep.position.x + x < bar.position.x+bar.size.width){
        x = bar.position.x+bar.size.width - sheep.position.x;
    }else if(sheep.position.x + sheep.size.width + x > self.frame.size.width){
        x = self.frame.size.width - (sheep.position.x + sheep.size.width);
    }
    
    if(sheep.position.y - sheep.size.height/2 + y < 0){
        y = 0 - (sheep.position.y - sheep.size.height/2);
    }else if(sheep.position.y + sheep.size.height + y > barHeight){
        y = barHeight - (sheep.position.y + sheep.size.height);
    }
    
    if (x>0) {
        sheep.xScale = -1;
    }else{
        sheep.xScale = 1;
    }
    
    SKTexture * texture = [SKTexture textureWithImageNamed:@"sheep1"];
    SKTexture * texture2 = [SKTexture textureWithImageNamed:@"sheep2"];
    SKTexture * texture3 = [SKTexture textureWithImageNamed:@"sheep3"];
    
    NSArray * nsArray = @[texture, texture2, texture3];
    
    SKAction *sheepAnimation = [SKAction animateWithTextures:nsArray timePerFrame:0.3];
    
    sheepAnimation = [SKAction repeatActionForever:sheepAnimation];
    
    SKAction * delayAction = [SKAction waitForDuration:1.0];
   
    SKAction * randomWalk = [SKAction runBlock:^{
        [self sheepWalkR:sheep];
    }];
    
    SKAction * end = [SKAction runBlock:^{
        [sheep removeAllActions];
        sheep.texture = [SKTexture textureWithImageNamed:@"sheep1"];
        [sheep runAction:[SKAction sequence:@[delayAction, randomWalk]]];
    }];
    
    SKAction * actionMove = [SKAction moveByX:x y:y duration:2];
    
//    [sheep runAction:[SKAction sequence:@[actionMove, end]]];
    [sheep runAction:[SKAction group:@[[SKAction sequence:@[actionMove, end]], sheepAnimation]]];
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
//    for (UITouch *touch in touches) {
//        CGPoint location = [touch locationInNode:self];
//        
//        SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithImageNamed:@"Spaceship"];
//        
//        sprite.position = location;
//        
//        SKAction *action = [SKAction rotateByAngle:M_PI duration:1];
//        
//        [sprite runAction:[SKAction repeatActionForever:action]];
//        
//        [self addChild:sprite];
//    }
    
    [timer invalidate];
    
    [self startTimer];
    
    UITouch * touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    
    if (!isSheepTouchable) {
        return;
    }
    
    if(touching)
        return;
    
    touching = true;
    
    for (int i = 0; i < sheepArray.count; i++) {
        SKSpriteNode * sheep = sheepArray[i];
        
        CGRect rect = [sheep calculateAccumulatedFrame];
        bool isCollision = CGRectContainsPoint(rect, location);
        if(isCollision){
            [sheep removeAllActions];
            
            [sheepArray removeObject:sheep];
            SKSpriteNode * newSheep = [self createSheep];
            [sheepArray addObject:newSheep];
            [self addChild:newSheep];
            
            sheep.texture = [SKTexture textureWithImageNamed:@"sheep_jump1"];
            sheep.xScale = 1;
            
            SKAction* upAction = [SKAction moveByX:0 y:50 duration:0.5];
            upAction.timingMode = SKActionTimingEaseOut;
            SKAction* downAction = [SKAction moveByX:0 y:-50 duration: 0.5]; downAction.timingMode = SKActionTimingEaseIn;
            // 3
            //        topNode.runAction(SKAction.sequence(
            //                                            [upAction, downAction, SKAction.removeFromParent()]))
            
            SKAction* upEnd = [SKAction runBlock:^{
                sheep.texture = [SKTexture textureWithImageNamed:@"sheep_jump3"];
            }];
            
            SKAction* horzAction = [SKAction moveToX:50 duration:1.0];
            
            SKAction * end;
            
            
            double currentTime = [[NSDate date] timeIntervalSince1970]*1000;
            
            NSLog(@"currentTime:%lf, periousTime:%lf",currentTime,periousTime);
            
            if(currentTime - periousTime > 500){
                end = [SKAction runBlock:^{
                    [sheep removeAllActions];
                    [sheepArrayLeft addObject:sheep];
                    if(sheepArrayLeft.count > sheepLeftMax){
                        SKSpriteNode* removeSheep = sheepArrayLeft[0];
                        [removeSheep removeAllActions];
                        [sheepArrayLeft removeObjectAtIndex:0];
                        removeSheep.xScale = 1;
                        SKAction* removeAction = [SKAction moveTo:CGPointMake(-removeSheep.size.width, removeSheep.position.y) duration:2];
                        SKAction* removeEnd = [SKAction runBlock:^{
                            [removeSheep removeFromParent];
                        }];
                        [removeSheep runAction:[SKAction sequence:@[removeAction, removeEnd]]];
                        
                    }
                    [self changeGamePoint];
                    [self sheepWalkL:sheep];
                }];
            }else{
                
                if(currentTime - periousTime < 200 && sheepArrayLeft.count >= sheepLeftMax){
                    
                        
                    NSLog(@"currentTime:%lf, periousTime:%lf",currentTime,periousTime);
                    
                    end = [SKAction runBlock:^{
                        [sheep removeAllActions];
                        [sheepArrayLeft addObject:sheep];
                        
                        [self changeGamePoint];
                        
                        if(isSheepTouchable){

                            NSLog(@"currentTime:%lf, periousTime:%lf",currentTime,periousTime);

                            sheep.texture = [SKTexture textureWithImageNamed:@"sheep_angry01"];
                            SKAction * sheepBumpToScreen = [SKAction scaleTo:8 duration:2];
                            //                        sheep.anchorPoint = CGPointMake(0.5, 0.5);
                            SKAction * bumpEnd = [SKAction runBlock:^{
                                isSheepTouchable = true;
                                AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
                                [sheep removeFromParent];
                                [sheepArrayLeft removeObject:sheep];
                            }];

                            sheep.anchorPoint = CGPointMake(0.5, 0.5);
                            sheep.zPosition = 2;

                            int randomMoveX = arc4random_uniform(self.frame.size.width/4.0) + self.frame.size.width/3.0;

                            SKAction * bumpMove = [SKAction moveTo:CGPointMake((self.position.x + randomMoveX), sheep.position.y) duration:2];

                            isSheepTouchable = false;

                            [sheep removeAllActions];
                            [sheepArrayLeft removeObject:sheep];

                            [sheep runAction:[SKAction sequence:@[[SKAction group:@[sheepBumpToScreen, bumpMove]], bumpEnd]]];

                            return;
                        }else{

                        }
                        
                        
                        
                        SKTexture * texture = [SKTexture textureWithImageNamed:@"sheep_faildown01"];
                        SKTexture * texture2 = [SKTexture textureWithImageNamed:@"sheep_faildown02"];
                        SKTexture * texture3 = [SKTexture textureWithImageNamed:@"sheep_faildown03"];
                        
                        NSArray * nsArray = @[texture, texture2, texture3];
                        
                        SKAction* fallDownAnimation = [SKAction repeatAction:[SKAction animateWithTextures:nsArray timePerFrame:0.1] count:5];
                        
                        
                        
                        SKAction* fallDwonEnd;
                        if(sheepArrayLeft.count > sheepLeftMax){
                            SKSpriteNode* removeSheep = sheepArrayLeft[0];
                            [removeSheep removeAllActions];
                            [sheepArrayLeft removeObjectAtIndex:0];
                            removeSheep.xScale = 1;
                            SKAction* removeAction = [SKAction moveTo:CGPointMake(-removeSheep.size.width, removeSheep.position.y) duration:2];
                            SKAction* removeEnd = [SKAction runBlock:^{
                                [removeSheep removeFromParent];
                                
                            }];
                            
                            [removeSheep runAction:[SKAction sequence:@[removeAction, removeEnd]]];
                            
                            //                        fallDwonEnd = [SKAction runBlock:^{
                            //                            [removeSheep runAction:[SKAction sequence:@[removeAction, removeEnd]]];
                            //                        }];
                        }else{
                            
                        }
                        
                        fallDwonEnd = [SKAction runBlock:^{
                            [self sheepWalkL:sheep];
                        }];
                        [sheep runAction:[SKAction sequence:@[fallDownAnimation, fallDwonEnd]]];
                        
                    }];
                    
                }else{
                    
                    end = [SKAction runBlock:^{
                        [sheep removeAllActions];
                        [sheepArrayLeft addObject:sheep];
                        
                        [self changeGamePoint];
                        
                        //                    if (sheepArrayLeft.count > 10) {
//                        if(currentTime - periousTime < 5 && sheepArrayLeft.count > sheepLeftMax&& isSheepTouchable){
//                            
//                            NSLog(@"currentTime:%lf, periousTime:%lf",currentTime,periousTime);
//                            
//                            sheep.texture = [SKTexture textureWithImageNamed:@"sheep_angry01"];
//                            SKAction * sheepBumpToScreen = [SKAction scaleTo:8 duration:2];
//                            //                        sheep.anchorPoint = CGPointMake(0.5, 0.5);
//                            SKAction * bumpEnd = [SKAction runBlock:^{
//                                isSheepTouchable = true;
//                                AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
//                                [sheep removeFromParent];
//                                [sheepArrayLeft removeObject:sheep];
//                            }];
//                            
//                            sheep.anchorPoint = CGPointMake(0.5, 0.5);
//                            sheep.zPosition = 2;
//                            
//                            int randomMoveX = arc4random_uniform(self.frame.size.width/4.0) + self.frame.size.width/3.0;
//                            
//                            SKAction * bumpMove = [SKAction moveTo:CGPointMake((self.position.x + randomMoveX), sheep.position.y) duration:2];
//                            
//                            isSheepTouchable = false;
//                            
//                            [sheep removeAllActions];
//                            [sheepArrayLeft removeObject:sheep];
//                            
//                            [sheep runAction:[SKAction sequence:@[[SKAction group:@[sheepBumpToScreen, bumpMove]], bumpEnd]]];
//                            
//                            return;
//                        }else{
//                            
//                        }
                        
                        
                        
                        SKTexture * texture = [SKTexture textureWithImageNamed:@"sheep_faildown01"];
                        SKTexture * texture2 = [SKTexture textureWithImageNamed:@"sheep_faildown02"];
                        SKTexture * texture3 = [SKTexture textureWithImageNamed:@"sheep_faildown03"];
                        
                        NSArray * nsArray = @[texture, texture2, texture3];
                        
                        SKAction* fallDownAnimation = [SKAction repeatAction:[SKAction animateWithTextures:nsArray timePerFrame:0.1] count:5];
                        
                        
                        
                        SKAction* fallDwonEnd;
                        if(sheepArrayLeft.count > sheepLeftMax){
                            SKSpriteNode* removeSheep = sheepArrayLeft[0];
                            [removeSheep removeAllActions];
                            [sheepArrayLeft removeObjectAtIndex:0];
                            removeSheep.xScale = 1;
                            SKAction* removeAction = [SKAction moveTo:CGPointMake(-removeSheep.size.width, removeSheep.position.y) duration:2];
                            SKAction* removeEnd = [SKAction runBlock:^{
                                [removeSheep removeFromParent];
                                
                            }];
                            
                            [removeSheep runAction:[SKAction sequence:@[removeAction, removeEnd]]];
                            
                            //                        fallDwonEnd = [SKAction runBlock:^{
                            //                            [removeSheep runAction:[SKAction sequence:@[removeAction, removeEnd]]];
                            //                        }];
                        }else{
                            
                        }
                        
                        fallDwonEnd = [SKAction runBlock:^{
                            [self sheepWalkL:sheep];
                        }];
                        [sheep runAction:[SKAction sequence:@[fallDownAnimation, fallDwonEnd]]];
                        
                    }];
                }
                
            }
            
            periousTime = currentTime;
            
            
            [sheep runAction:[SKAction group:@[[SKAction sequence:@[upAction, upEnd, downAction, end]], horzAction]]];
            
            
            
            break;
            
        }

    }
    
    touching = false;
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    
    if(!isGameRun)
        return;
    
    /* Called before each frame is rendered */
    // 获取时间增量
    // 如果我们运行的每秒帧数低于60，我们依然希望一切和每秒60帧移动的位移相同
    CFTimeInterval timeSinceLast = currentTime - self.lastUpdateTimeInterval;
    self.lastUpdateTimeInterval = currentTime;
    if (timeSinceLast > 1) { // 如果上次更新后得时间增量大于1秒
        timeSinceLast = 1.0 / 60.0;
        self.lastUpdateTimeInterval = currentTime;
    }
    
    [self updateWithTimeSinceLastUpdate:timeSinceLast];
}

- (void)updateWithTimeSinceLastUpdate:(CFTimeInterval)timeSinceLast {
    self.lastSpawnTimeInterval += timeSinceLast;
    
    if (self.lastSpawnTimeInterval > 0.5) {
        self.lastSpawnTimeInterval = 0;
        
        ccount++;
        
        if(ccount==10)    {
            
            
            int continueAttackCounter = 0;
            
            int r = arc4random_uniform(40);
            
            ccount = 0;
        }
 
    }else if(self.lastSpawnTimeInterval > 0.3){
        
    }
}

-(SKSpriteNode*)createSheep{
    int randomSheepInitGoToX = arc4random_uniform(self.frame.size.width/2)+bar.position.x + bar.size.width;
    int randomSheepInitY = arc4random_uniform(self.frame.size.height/2) + 30;
    
    SKSpriteNode *sheep = [SKSpriteNode spriteNodeWithImageNamed:@"sheep1"];
    
    sheep.size = CGSizeMake(70, 70);
    
    sheep.position = CGPointMake(self.frame.size.width, randomSheepInitY);
    
    SKAction * actionMove = [SKAction moveTo:CGPointMake(randomSheepInitGoToX, randomSheepInitY) duration:3];
    
    SKTexture * texture = [SKTexture textureWithImageNamed:@"sheep1"];
    SKTexture * texture2 = [SKTexture textureWithImageNamed:@"sheep2"];
    SKTexture * texture3 = [SKTexture textureWithImageNamed:@"sheep3"];
    
    NSArray * nsArray = @[texture, texture2, texture3];
    
    SKAction *sheepAnimation = [SKAction animateWithTextures:nsArray timePerFrame:0.3];
    
    sheepAnimation = [SKAction repeatActionForever:sheepAnimation];
    
    SKAction * end = [SKAction runBlock:^{
        [sheep removeAllActions];
        [self sheepWalkR:sheep];
    }];
    
    [sheep runAction:[SKAction group:@[[SKAction sequence:@[actionMove, end]], sheepAnimation]]];
    
    return sheep;
}

-(void)checkAndSheepBumpToScreen{
    
}

-(void)changeGamePoint{
    sheepGameScore++;
    
    gamePointSingleNode.texture = [self getTimeTexture:sheepGameScore%10];
    
    gamePointTenNode.texture = [self getTimeTexture:(sheepGameScore)/10%10];
    
    gamePointHunNode.texture = [self getTimeTexture:(sheepGameScore)/100%10];
    
    gamePointTHUNode.texture = [self getTimeTexture:(sheepGameScore)/1000%10];
}

-(void)showScore{
//    self.onGameOver(sheepGameScore);
    [self moveTrans];
    return;

}

-(void)moveTrans{
//    MyGameOverScene * myGameOverScene = [MyGameOverScene sceneWithSize:self.view.bounds.size];
//    myGameOverScene.scaleMode = self.scaleMode;
//    myGameOverScene.periousScene = self;
//    
//    SKTransition * trans = [SKTransition flipHorizontalWithDuration:0.5];
//    
//    [self.view presentScene:myGameOverScene transition:trans];
    
    MyGameScoreScene * myGameScoreScene = [MyGameScoreScene sceneWithSize:self.view.frame.size];
    myGameScoreScene.scaleMode = self.scaleMode;
    myGameScoreScene.periousScene = self;
    myGameScoreScene.sheepGameScore = sheepGameScore;
    myGameScoreScene.updateSheepGameScore = true;
    myGameScoreScene.delegate = self;
    
    SKTransition * trans = [SKTransition flipHorizontalWithDuration:0.5];
    
    [self.view presentScene:myGameScoreScene transition:trans];
}

-(void)startTimer{
    timer =  [NSTimer scheduledTimerWithTimeInterval:15.0
                                              target:self
                                            selector:@selector(showScore)
                                            userInfo:nil
                                             repeats:NO];
}

-(SKTexture*)getTimeTexture:(int)time{
    SKTexture* texture;
    switch (time) {
        case 0:
            texture = [TextureHelper timeTextures][0];
            break;
        case 1:
            texture = [TextureHelper timeTextures][1];
            break;
        case 2:
            texture = [TextureHelper timeTextures][2];
            break;
        case 3:
            texture = [TextureHelper timeTextures][3];
            break;
        case 4:
            texture = [TextureHelper timeTextures][4];
            break;
        case 5:
            texture = [TextureHelper timeTextures][5];
            break;
        case 6:
            texture = [TextureHelper timeTextures][6];
            break;
        case 7:
            texture = [TextureHelper timeTextures][7];
            break;
        case 8:
            texture = [TextureHelper timeTextures][8];
            break;
        case 9:
            texture = [TextureHelper timeTextures][9];
            break;
//        default:
//            texture = [self getTimeTexture:time/10];
//            break;
    }
    return texture;
}

@end
