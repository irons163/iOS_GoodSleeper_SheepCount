//
//  MyGameOverScene.m
//  Try_Sheep_Count
//
//  Created by irons on 2015/4/21.
//  Copyright (c) 2015年 irons. All rights reserved.
//

#import "MyGameOverScene.h"
#import "TextureHelper.h"

@implementation MyGameOverScene {
    SKSpriteNode *continueBtn;
    SKSpriteNode *leaveBtn;
    SKSpriteNode *sheepStandNode;
}

int ccount;

- (instancetype)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        SKSpriteNode *backgroundNode = [SKSpriteNode spriteNodeWithImageNamed:@"bg02"];
        
        backgroundNode.size = self.frame.size;
        backgroundNode.anchorPoint = CGPointMake(0, 0);
        backgroundNode.position = CGPointMake(0, 0);
        
        [self addChild:backgroundNode];
        
        continueBtn = [SKSpriteNode spriteNodeWithImageNamed:@"sheep_text2"];
        
        continueBtn.anchorPoint = CGPointMake(0, 0);
        continueBtn.size = CGSizeMake(self.frame.size.width / 3.0, self.frame.size.height / 5.0);
        continueBtn.position = CGPointMake(0, 0);
        
        [self addChild:continueBtn];
        
        sheepStandNode = [SKSpriteNode spriteNodeWithImageNamed:@"sheep1"];
        
        sheepStandNode.anchorPoint = CGPointMake(0.5, 0.5);
        sheepStandNode.size = CGSizeMake(self.frame.size.width / 5.0 * 3, self.frame.size.height / 10.0 * 9);
        sheepStandNode.position = CGPointMake(self.frame.size.width / 2.0, self.frame.size.height / 2.0);
        
        [self addChild:sheepStandNode];
    }
    return self;
}

- (void)update:(CFTimeInterval)currentTime {
    CFTimeInterval timeSinceLast = currentTime - self.lastUpdateTimeInterval;
    self.lastUpdateTimeInterval = currentTime;
    if (timeSinceLast > 1) {
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
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    
    if (CGRectContainsPoint(continueBtn.calculateAccumulatedFrame, location)) {
        [self.view presentScene:self.periousScene];
        [self.delegate startTimer];
    }
}

@end
