//
//  MyGameScoreScene.m
//  Try_Sheep_Count
//
//  Created by irons on 2015/4/28.
//  Copyright (c) 2015年 irons. All rights reserved.
//

#import "MyGameScoreScene.h"
#import "TextureHelper.h"
#import "MyGameOverScene.h"

@implementation MyGameScoreScene{
    SKSpriteNode * gamePointSingleNode, *gamePointTenNode, *gamePointHunNode, *gamePointTHUNode;
    SKSpriteNode * sheepSleepNode;
}

-(instancetype)initWithSize:(CGSize)size{
    if (self = [super initWithSize:size]) {
        
        SKSpriteNode * backgroundNode = [SKSpriteNode spriteNodeWithImageNamed:@"bg02"];
        
        backgroundNode.size = self.frame.size;
        backgroundNode.anchorPoint = CGPointMake(0, 0);
        backgroundNode.position = CGPointMake(0, 0);
        
        [self addChild:backgroundNode];
        

        
        SKSpriteNode * cumulative = [SKSpriteNode spriteNodeWithImageNamed:@"cumulative"];
        cumulative.size = CGSizeMake(400, 80);
        cumulative.anchorPoint = CGPointMake(0, 0);
        cumulative.position = CGPointMake(0, self.frame.size.height - cumulative.size.height - 50);
        
        [self addChild:cumulative];
        
        SKTexture * texture1 = [SKTexture textureWithImageNamed:@"sheep_sleep1"];
        SKTexture * texture2 = [SKTexture textureWithImageNamed:@"sheep_sleep2"];
        SKTexture * texture3 = [SKTexture textureWithImageNamed:@"sheep_sleep3"];
        SKTexture * texture4 = [SKTexture textureWithImageNamed:@"sheep_sleep4"];
        SKTexture * texture5 = [SKTexture textureWithImageNamed:@"sheep_sleep5"];
        
        sheepSleepNode = [SKSpriteNode spriteNodeWithTexture:texture1];
        sheepSleepNode.anchorPoint = CGPointMake(0.5, 0.5);
        sheepSleepNode.size = CGSizeMake(self.frame.size.width/2, self.frame.size.height/4.0*3);
        sheepSleepNode.position = CGPointMake(self.size.width/4.0*3, self.frame.size.height/3);
        
        [self addChild:sheepSleepNode];
        
        SKAction * sleepAction = [SKAction animateWithTextures:@[texture1, texture2, texture3, texture4, texture5] timePerFrame:0.3];
        
        [sheepSleepNode runAction:[SKAction repeatActionForever:sleepAction]];
        
    }
    return self;
}

-(void)update:(NSTimeInterval)currentTime{
    
    if(self.updateSheepGameScore){
        
        int gamePointNodeWH = 60;
        
        int gamePointX = self.frame.size.width/3;
        int gamePointY = self.frame.size.height*2/8.0;
        
        gamePointSingleNode = [SKSpriteNode spriteNodeWithTexture:[self getTimeTexture:self.sheepGameScore%10]];
        gamePointSingleNode.anchorPoint = CGPointMake(0, 0);
        gamePointSingleNode.size = CGSizeMake(gamePointNodeWH, gamePointNodeWH);
        gamePointSingleNode.position = CGPointMake(gamePointX, gamePointY);
        //        gamePointSingleNode.zPosition = backgroundLayerZPosition;
        
        gamePointTenNode = [SKSpriteNode spriteNodeWithTexture:[self getTimeTexture:(self.sheepGameScore)/10%10]];
        gamePointTenNode.anchorPoint = CGPointMake(0, 0);
        gamePointTenNode.size = CGSizeMake(gamePointNodeWH, gamePointNodeWH);
        gamePointTenNode.position = CGPointMake(gamePointX - gamePointNodeWH, gamePointY);
        //        gamePointTenNode.zPosition = backgroundLayerZPosition;
        
        gamePointHunNode = [SKSpriteNode spriteNodeWithTexture:[self getTimeTexture:(self.sheepGameScore)/100%10]];
        gamePointHunNode.anchorPoint = CGPointMake(0, 0);
        gamePointHunNode.size = CGSizeMake(gamePointNodeWH, gamePointNodeWH);
        gamePointHunNode.position = CGPointMake(gamePointX - gamePointNodeWH*2, gamePointY);
        
        gamePointTHUNode = [SKSpriteNode spriteNodeWithTexture:[self getTimeTexture:(self.sheepGameScore)/1000%10]];
        gamePointTHUNode.anchorPoint = CGPointMake(0, 0);
        gamePointTHUNode.size = CGSizeMake(gamePointNodeWH, gamePointNodeWH);
        gamePointTHUNode.position = CGPointMake(gamePointX - gamePointNodeWH*3, gamePointY);
        
        [self addChild:gamePointSingleNode];
        [self addChild:gamePointTenNode];
        [self addChild:gamePointHunNode];
        [self addChild:gamePointTHUNode];
        
        self.updateSheepGameScore = false;
    }
    
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
//    f
    ((MyScene*)self.periousScene).showAdmob();
    
    MyGameOverScene * myGameOverScene = [MyGameOverScene sceneWithSize:self.view.frame.size];
    myGameOverScene.scaleMode = self.scaleMode;
    myGameOverScene.periousScene = self.periousScene;
    myGameOverScene.delegate = self.delegate;
    
    SKTransition * trans = [SKTransition flipHorizontalWithDuration:0.5];
    [self.view presentScene:myGameOverScene transition:trans];
    
    [self removeFromParent];
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
    }
    return texture;
}


@end
