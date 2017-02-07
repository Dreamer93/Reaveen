//
//  CustomProgressBar.m
//  ReaveenDestiny
//
//  Created by Matic Vrenko on 28/01/16.
//  Copyright © 2016 Matic Teršek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CustomProgressBar.h"
@implementation CustomProgressBar

- (id)init: (SKSpriteNode*) sprite   {
    if (self = [super init]) {
        self.maskNode = [SKSpriteNode spriteNodeWithTexture:sprite.texture size:sprite.size];
        //self.maskNode = [SKSpriteNode spriteNodeWithColor:[SKColor whiteColor]    size:CGSizeMake(600,40)];
        [self addChild:sprite];
    }
    return self;
}

- (void) setProgress:(CGFloat) progress {
    self.maskNode.xScale = progress;
}


@end
