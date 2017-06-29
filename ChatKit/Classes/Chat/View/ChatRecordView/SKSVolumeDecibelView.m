//
//  SKSVolumeDecibelView.m
//  ChatKit
//
//  Created by iCrany on 2017/1/3.
//
//

#import "SKSVolumeDecibelView.h"
#import "SKSChatProgressView.h"
#import "SKSChatMessageConstant.h"
#import "SKSWeakProxy.h"

@interface SKSVolumeDecibelView()

@property (nonatomic, assign) CGSize viewSize;

@property (nonatomic, strong) SKSChatProgressView *progressVolumeView;

@property (nonatomic, strong) NSTimer *testTimer;//for test

@end

@implementation SKSVolumeDecibelView

- (instancetype)initWithViewSize:(CGSize)viewSize {
    self = [super init];
    if (self) {
        _viewSize = viewSize;
        [self setupUI];
    }
    return self;
}

- (void)dealloc {
    [self stopTimer];
}

- (void)setupUI {
    _progressVolumeView = [[SKSChatProgressView alloc] initWithNumber:4 viewSize:_viewSize];
    [self addSubview:_progressVolumeView];
    _progressVolumeView.frame = CGRectMake(0, 0, _viewSize.width, _viewSize.height);

//    [self startTimer];//for test
}

#pragma mark - NSTimer
- (void)startTimer {
    [self stopTimer];
    _testTimer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:[[SKSWeakProxy alloc] initWithTarget:self] selector:@selector(testTimerAction) userInfo:nil repeats:YES];
    [_testTimer fire];

    [_progressVolumeView startVoiceRecording];//just for test
}

- (void)stopTimer {
    if (_testTimer) {
        [_testTimer invalidate];
        _testTimer = nil;
    }
}

- (void)testTimerAction {
    int random = arc4random_uniform(4);
    DLog(@"testTimerAction, random: %ld", (long)random);
    [_progressVolumeView updateLevel:random];

}

#pragma mark - Helper method
- (void)clearResource {
    [self stopTimer];
    [_progressVolumeView clearResource];
}

- (void)updateLevel:(NSInteger)level {
    [_progressVolumeView updateLevel:level];
}

- (void)startVoiceRecording {
    [_progressVolumeView startVoiceRecording];
}


@end
