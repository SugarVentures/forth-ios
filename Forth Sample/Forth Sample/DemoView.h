//
//  DemoView.h
//  Forth Sample
//
//  Created by Hinh Tinh Thach on 29/10/15.
//  Copyright © 2015 Fort TV. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#include <OpenGLES/ES2/gl.h>
#include <OpenGLES/ES2/glext.h>

@interface DemoView : UIView {
    CAEAGLLayer* _eaglLayer;
    EAGLContext* _context;
    GLuint _colorRenderBuffer;
}

@end