//
//  DWScrollView.m
//  v3
//
//  Created by Kevin Hury on 10/22/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "CCSpriteButton.h"
#import "CCControlSubclass.h"


@implementation CCSpriteButton
{
    CCSprite *_normalImage;
    CCSprite *_selectedImage;
    CCSprite *_disabledImage;
}


- (id)init
{
    return [self initWithNormalSprite:[CCSprite emptySprite] selectedSprite:[CCSprite emptySprite] disabledSprite:[CCSprite emptySprite]];
}

-(id) initWithNormalSprite:(CCSprite *)normal
            selectedSprite:(CCSprite *)selected
            disabledSprite:(CCSprite *)disabled
{
    if (self = [super init])
    {
        NSAssert(normal, @"CCSpriteButton must contain normalSprite");
        selected = selected ?: [CCSprite emptySprite];
        disabled = disabled ?: [CCSprite emptySprite];
        
        _normalImage = normal;
        _selectedImage = selected;
        _disabledImage = disabled;
        
        normal.anchorPoint = selected.anchorPoint = disabled.anchorPoint = CGPointZero;
        
        [self addChild:normal];
        [self addChild:selected];
        [self addChild:disabled];
        
        self.contentSize = _normalImage.contentSize;
        self.anchorPoint = CGPointMake(0.5f, 0.5f);
        
        self.cascadeOpacityEnabled = YES;
        self.cascadeColorEnabled = YES;
        
        [self needsLayout];
        [self stateChanged];
    }
    return self;
}


-(void)setNormalFrame:(CCSpriteFrame *)normalFrame
{
    _normalFrame = normalFrame;
    _normalImage.spriteFrame = normalFrame;
    [self setContentSize:[_normalImage contentSize]];
    [self stateChanged];
}

-(void)setSelectedFrame:(CCSpriteFrame *)selectedFrame
{
    _selectedFrame = selectedFrame;
    _selectedImage.spriteFrame = selectedFrame;
    [self stateChanged];
}

-(void)setDisabledFrame:(CCSpriteFrame *)disabledFrame
{
    _disabledFrame = disabledFrame;
    _disabledImage.spriteFrame = disabledFrame;
    [self stateChanged];
}

-(void)stateChanged
{
    if (self.enabled) {
        if (self.highlighted && self.selectedFrame) {
            _normalImage.visible = NO;
            _selectedImage.visible = YES;
            _disabledImage.visible = NO;
        }
        else {
            _normalImage.visible = YES;
            _selectedImage.visible = NO;
            _disabledImage.visible = NO;
        }
    }
    else if(_disabledImage) {
        _normalImage.visible = NO;
        _selectedImage.visible = NO;
        _disabledImage.visible = YES;
    }
    else {
        _normalImage.visible = NO;
        _selectedImage.visible = YES;
        _disabledImage.visible = NO;
    }
}



- (void) touchEntered:(CCTouch *)touch withEvent:(CCTouchEvent *)event
{
    if (!self.enabled) return;
    
    self.highlighted = YES;
}

- (void) touchExited:(CCTouch *)touch withEvent:(CCTouchEvent *)event
{
    self.highlighted = NO;
}

- (void) touchUpInside:(CCTouch *)touch withEvent:(CCTouchEvent *)event
{
    if (self.enabled) [self triggerAction];
    
    self.highlighted = NO;
}

- (void) touchUpOutside:(CCTouch *)touch withEvent:(CCTouchEvent *)event
{
    self.highlighted = NO;
}

@end
