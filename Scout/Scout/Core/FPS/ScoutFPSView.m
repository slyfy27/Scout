//
//  ScoutFPSView.m
//  Scout
//
//  Created by slyfy27 on 2021/7/15.
//

#import "ScoutFPSView.h"

@interface ScoutFPSView()

@property (nonatomic, strong) UILabel *fpsLabel;

@end

@implementation ScoutFPSView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.fpsLabel];
    }
    return self;
}

- (void)setFps:(NSInteger)fps {
    _fpsLabel.text = @(fps).stringValue;
}

- (UILabel *)fpsLabel {
    if (!_fpsLabel) {
        _fpsLabel = [[UILabel alloc] init];
        _fpsLabel.font = [UIFont boldSystemFontOfSize:15];
        _fpsLabel.textColor = [UIColor whiteColor];
    }
    return _fpsLabel;
}

@end
