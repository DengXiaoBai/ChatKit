//
//  SKSChatProgressView.m
//  ChatKit
//
//  Created by iCrany on 2017/1/3.
//
//

#import "SKSChatProgressView.h"
#import "SKSProgressLineView.h"
#import "SKSChatMessageConstant.h"
#import "SKSWeakProxy.h"

static CGFloat kDurationTimeInterval = 0.4;

@interface SKSChatProgressView()

@property (nonatomic, assign) NSInteger number;
@property (nonatomic, assign) CGSize viewSize;
@property (nonatomic, assign) NSInteger newLevel;//default is 0
@property (nonatomic, assign) NSInteger currentLevel;//default is 0, 当前的 level

@property (nonatomic, strong) NSMutableArray *progressLineList;

@property (nonatomic, strong) NSTimer *fetchLevelTimer;//定时获取音量的定时器

@end

@implementation SKSChatProgressView

- (instancetype)initWithNumber:(NSInteger)number viewSize:(CGSize)viewSize {
    self = [super init];
    if (self) {
        _number = number;
        _viewSize = viewSize;
        _progressLineList = [[NSMutableArray alloc] init];
        _newLevel = 0;
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    self.clipsToBounds = YES;

    CGFloat gap = 15;
    CGFloat eachHeight = 6;
    CGFloat decreasing = 4;//每级递减值，只是某一边的

    //从下到上的布局
    for (NSInteger i = 0; i < _number; i++) {
        NSInteger temp = _number - i;
        SKSProgressLineView *lineView = [[SKSProgressLineView alloc] init];
        [self addSubview:lineView];
        CGFloat width = _viewSize.width - 2 * decreasing * temp;
        CGFloat x = (_viewSize.width - width) / 2;
        CGFloat y = _viewSize.height - (gap + eachHeight) * i - eachHeight;
        lineView.frame = CGRectMake(x, y, width, eachHeight);
        [_progressLineList addObject:lineView];

        if (i == 0) {
            [lineView updateUIIsHighlight:YES];
        }
    }
}


#pragma mark - Timer method
- (void)startTimer {
    [self stopTimer];
    _fetchLevelTimer = [NSTimer scheduledTimerWithTimeInterval:kDurationTimeInterval target:[[SKSWeakProxy alloc] initWithTarget:self] selector:@selector(fetchLevelTimerAction) userInfo:nil repeats:YES];
    [_fetchLevelTimer fire];
}

- (void)stopTimer {
    if (_fetchLevelTimer) {
        [_fetchLevelTimer invalidate];
        _fetchLevelTimer = nil;
    }
}

- (void)updateLevel:(NSInteger)level {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (level <= 0) {
            _newLevel = 0;
        } else {
            if (_newLevel > _number) {
                _newLevel = _number - 1;
            } else {
                _newLevel = level;
            }
        }
    });
}

- (void)fetchLevelTimerAction {
    NSInteger currentLevel = _currentLevel;
    NSInteger newLevel = _newLevel;
    if (newLevel >= _progressLineList.count) {
        newLevel = _progressLineList.count - 1;
    }

    if (newLevel < 1) {
        newLevel = 1;
    }

    CGFloat delayTime = 0;
    CGFloat delayGap = 0.1;
    NSInteger count = 0;

    if (currentLevel < newLevel) {
        for (NSInteger i = currentLevel; i <= newLevel; i++) {
            delayTime = delayGap * count;
            NSDictionary *dict = @{
                    @"index": @(i),
                    @"isHighlight": @(YES)
            };
            [self performSelector:@selector(updateProcressLineViewWithDict:) withObject:dict afterDelay:delayTime];
            count++;
        }
    } else if (currentLevel > newLevel) {
        for (NSInteger i = currentLevel; i >= newLevel; i--) {
            delayTime = delayGap * count;
            NSDictionary *dict = @{
                    @"index": @(i),
                    @"isHighlight": @(NO)
            };
            [self performSelector:@selector(updateProcressLineViewWithDict:) withObject:dict afterDelay:delayTime];
            count++;
        }
    }
    _currentLevel = newLevel;
}

- (void)updateProcressLineViewWithDict:(NSDictionary *)dict {
    NSInteger index = [[dict objectForKey:@"index"] integerValue];
    BOOL isHighlight = [[dict objectForKey:@"isHighlight"] boolValue];
    if (index >= 0 && index < _progressLineList.count) {
        SKSProgressLineView *lineView = _progressLineList[index];
        [lineView updateUIIsHighlight:isHighlight];
    }
}

- (void)clearResource {
    [self stopTimer];
}

- (void)startVoiceRecording {
    [self startTimer];
}
@end
