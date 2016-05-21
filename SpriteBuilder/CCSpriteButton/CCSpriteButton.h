//
//  DWScrollView.h
//  v3
//
//  Created by Kevin Hury on 10/22/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "cocos2d.h"
#import "cocos2d-ui.h"

@interface CCSpriteButton : CCControl

@property (nonatomic, strong) CCSpriteFrame *normalFrame;
@property (nonatomic, strong) CCSpriteFrame *selectedFrame;
@property (nonatomic, strong) CCSpriteFrame *disabledFrame;


-(id) initWithNormalSprite:(CCSprite *)normal
            selectedSprite:(CCSprite *)selected
            disabledSprite:(CCSprite *)disabled;


@end
