//
//  SKSVolumeDecibelView.h
//  ChatKit
//
//  Created by iCrany on 2017/1/3.
//
//



@interface SKSVolumeDecibelView : UIView

- (instancetype)initWithViewSize:(CGSize)viewSize;

- (void)clearResource;
- (void)updateLevel:(NSInteger)level;

- (void)startVoiceRecording;

@end
