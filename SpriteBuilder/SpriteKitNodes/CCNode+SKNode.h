//
//  CCNode+SKNode.h
//  SpriteBuilder
//
//  Created by Steffen Itterheim on 23/01/14.
//
//

#import "CCNode.h"

@interface CCNode (SKNode)

// SKNode
@property CGFloat alpha;
@property CGFloat speed;
@property CGFloat xScale;
@property CGFloat yScale;
@property CGFloat zRotation;
@property CGFloat zPosition;
@property BOOL hidden;

// SKSpriteNode
@property CGFloat colorBlendFactor;
@property CGSize size;
@property CCSizeType sizeType;

-(CGPoint) positionRelativeToParent:(CGPoint)position;

@end


/** 
 Some compatibility code must be injected into each CCNode subclass. Since we can't reliably override methods
 in a ObjC category the override must be implemented directly in the subclass. In order to avoid duplicating this
 code for each CCNode subclass (and also avoid modifying cocos2d code as well as swizzling) the code has been added
 to the macros below, so it can be injected into each plugin node subclass with one line of code.
 
 The macro body should be slim and short because it's difficult to debug code in a macro. Complex code in a macro method
 should rather call a CCNode (class/instance) method implemented in above category, passing in self as the node the code should
 act upon for class methods.
 */

#define SKNODE_COMPATIBILITY_HEADER \
@property (nonatomic, readonly)	CGPoint positionAccordingToCocos; \


// Sprite Kit does the right thing here: child nodes are centered on the position of their parent.
// However cocos2d centers child nodes on the parent's lower left contentSize corner. Yay.
// So position needs to be properly converted back and forth to create the desired Sprite Kit behavior.
#define SKNODE_COMPATIBILITY_CODE \
-(void) setPosition:(CGPoint)position { \
	_positionAccordingToCocos = position; \
	[super setPosition:[self positionRelativeToParent:_positionAccordingToCocos]]; \
	_isTransformDirty = _isInverseDirty = YES; \
} \
-(CGPoint) position { \
	return _positionAccordingToCocos; \
} \