//
//  ScoutFPSMonitor.m
//  Scout
//
//  Created by slyfy27 on 2021/7/16.
//

#import "ScoutFPSMonitor.h"
#import <UIKit/UIKit.h>

@interface ScoutFPSMonitor() {
    
}

@property (nonatomic, strong) CADisplayLink *fpsLink;
@property (nonatomic, assign) NSUInteger count;
@property (nonatomic, assign) NSTimeInterval lastTime;
@property (nonatomic, assign) BOOL isStart;
@property (nonatomic, assign) NSInteger fps;

@end

@implementation ScoutFPSMonitor

- (instancetype)init{
    self = [super init];
    if (self) {
        _isStart = NO;
        _count = 0;
        _lastTime = 0;
    }
    return self;
}

- (void)start {
    if (_fpsLink) {
        _fpsLink.paused = NO;
    } else {
        _fpsLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(trigger:)];
        [_fpsLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    }
}

- (void)stop {
    if (!_fpsLink) {
        _fpsLink.paused = YES;
        [_fpsLink invalidate];
        _fpsLink = nil;
        _isStart = NO;
        _lastTime = 0;
        _count = 0;
    }
}

- (void)trigger:(CADisplayLink *)link{
    if (_lastTime == 0) {
        _lastTime = link.timestamp;
        return;
    }
    _count++;
    NSTimeInterval delta = link.timestamp - _lastTime;
    if (delta < 1) {
        return;
    }
    _lastTime = link.timestamp;
    CGFloat fps = _count / delta;
    _count = 0;
    
    NSInteger intFps = (NSInteger)(fps+0.5);
    _fps = intFps;
    NSLog(@"%ld",(long)_fps);
}

@end
