//
//  ChatTestViewModel.m
//  AtFirstSight
//
//  Created by iCrany on 2016/11/14.
//  Copyright © 2016年 Sachsen. All rights reserved.
//

#import <CoreLocation/CLLocation.h>
#import <ChatKit/SKSMenuItemProtocol.h>
#import <ChatKit/SKSChatMessage.h>
#import <ChatKit/SKSDefaultValueMaker.h>
#import <ChatKit/SKSChatMessageModel.h>
#import <ChatKit/SKSChatSessionConfig.h>
#import <ChatKit/SKSVoiceMessageObject.h>
#import <ChatKit/SKSTypingMessageObject.h>
#import <ChatKit/SKSLocationMessageObject.h>
#import <ChatKit/SKSRealTimeVideoOrVoiceMessageObject.h>
#import <ChatKit/SKSCoreTextMessageObject.h>
#import <ChatKit/SKSMenuItemBaseObject.h>
#import <ChatKit/SKSDateCallMessageObject.h>
#import <ChatKit/SKSChatMessageConstant.h>
#import <GRMustache/GRMustacheTemplate.h>
#import <ChatKit/SKSUnReadMessageObject.h>
#import "ChatTestViewModel.h"
#import "ChatDefaultValueMaker.h"
#import "ChatDateActivityMessageObject.h"
#import "ChatPrivacyDateOfferMessageObject.h"
#import "ChatPrivacyGiftOfferMessageObject.h"
#import "ChatConfirmMeetMessageObject.h"
#import "ChatDateJoinedPreviewMessageObject.h"
#import "ChatYOMessageObject.h"
#import "ChatImpressMessageObject.h"
#import "ChatConstant.h"


@interface ChatTestViewModel()

@end

@implementation ChatTestViewModel

- (instancetype)init {
    self = [super init];
    if (self) {
        _messageList = [[NSMutableArray alloc] init];
        self.sessionConfig = [[ChatDefaultValueMaker shareInstance] getDefaultSessionConfig];
        [self prepareTestMessageModel];
    }
    return self;
}

- (void)prepareTestMessageModel {

    NSString *content = @"dfah";
    SKSChatMessageModel *textMessageModel = [self wrapperTextMessageWithContent:content mesageSourceType:SKSMessageSourceTypeReceive timestampDesc:@"昨天 11:01"];

    content = @"15918888888";
    SKSChatMessageModel *textMessageModel1 = [self wrapperTextMessageWithContent:content mesageSourceType:SKSMessageSourceTypeReceive timestampDesc:@"昨天 10:45"];

    content = @"我是接受的消息222";
    SKSChatMessageModel *textMessageModel2 = [self wrapperTextMessageWithContent:content mesageSourceType:SKSMessageSourceTypeReceive timestampDesc:@"昨天 11:00"];

    content = @"你好，我是用来测试的!，哈哈 http://www.baidu.com";
    SKSChatMessageModel *textMessageModel3 = [self wrapperTextMessageWithContent:content mesageSourceType:SKSMessageSourceTypeReceive timestampDesc:@"昨天 10:40"];

    content = @"You are calling cellForRowAtIndexPath outside of a tableView reload. This will either give you a reused cell or a brand new instance but not the cell shown on the screen at the time.What you should do is call reloadRowsAtIndexPaths:withRowAnimation.Your code should have a dataSource that you update where you are currently trying to update the cell's bottomLabel.Then your code should look something like this:";
    SKSChatMessageModel *textMessageModel4 = [self wrapperTextMessageWithContent:content mesageSourceType:SKSMessageSourceTypeReceive timestampDesc:@"前天 10:30"];

    content = @"哈哈哈哈哈哈哈哈，哈哈哈哈哈哈哈哈，呜呜呜呜呜呜呜呜，哦我我我我我";
    SKSChatMessageModel *textMessageModel5 = [self wrapperTextMessageWithContent:content mesageSourceType:SKSMessageSourceTypeSend timestampDesc:nil];

    content = @"我有一个梦想";
    SKSChatMessageModel *textMessageModel6 = [self wrapperTextMessageWithContent:content mesageSourceType:SKSMessageSourceTypeSend timestampDesc:@"前天 05:49"];

    content = @"h";
    SKSChatMessageModel *textMessageModel7 = [self wrapperTextMessageWithContent:content mesageSourceType:SKSMessageSourceTypeSend timestampDesc:nil];


    NSDictionary *yoDict = @{
            @"content" : @"YO",
            @"type" : @(1),
            @"font" : @"HeartlandRegular",
            @"color" : @"#547fe2"
    };
    NSString *yoContent = [ChatTestViewModel dict2Json:yoDict];
    SKSChatMessage *yoMessage = [[SKSChatMessage alloc] init];
    yoMessage.messageSourceType = SKSMessageSourceTypeSend;
    yoMessage.messageMediaType = SKSMessageMediaTypeYO;
    yoMessage.text = @"YO";
    yoMessage.menuItemList = [self getMenuItemListWithMessage:yoMessage];
    SKSChatMessageModel *yoMessageModel = [[SKSChatMessageModel alloc] initWithMessage:yoMessage];
    yoMessageModel.layoutConfig = [self.sessionConfig layoutConfigWithMessage:yoMessage];
    yoMessageModel.sessionConfig = self.sessionConfig;
    yoMessageModel.shouldShowReadControl = YES;

    ChatYOMessageObject *yoMessageObject = [[ChatYOMessageObject alloc] initWithText:yoContent];
    yoMessageObject.message = yoMessage;
    yoMessage.messageAdditionalObject = yoMessageObject;

    SKSChatMessage *yoMessage1 = [[SKSChatMessage alloc] init];
    yoMessage1.messageSourceType = SKSMessageSourceTypeReceive;
    yoMessage1.messageMediaType = SKSMessageMediaTypeYO;
    yoMessage1.text = @"YO";
    yoMessage1.menuItemList = [self getMenuItemListWithMessage:yoMessage1];


    NSDictionary *yo1Dict = @{
            @"content" : @"YO",
            @"type" : @(1),
            @"font" : @"HeartlandRegular",
            @"color" : @"#507fe2"
    };
    NSString *yo1Content = [ChatTestViewModel dict2Json:yo1Dict];
    ChatYOMessageObject *yoMessageObject1 = [[ChatYOMessageObject alloc] initWithText:yo1Content];
    yoMessageObject1.message = yoMessage1;
    yoMessage1.messageAdditionalObject = yoMessageObject1;

    SKSChatMessageModel *yoMessageModel1 = [[SKSChatMessageModel alloc] initWithMessage:yoMessage1];
    yoMessageModel1.shouldShowAvatar = YES;
    yoMessageModel1.shouldShowTimestamp = YES;
    yoMessageModel1.shouldAvatarOnBottom = YES;
    yoMessageModel1.layoutConfig = [self.sessionConfig layoutConfigWithMessage:yoMessage1];
    yoMessageModel1.sessionConfig = self.sessionConfig;

    
    
    SKSChatMessage *emoticonMessage = [[SKSChatMessage alloc] init];
    emoticonMessage.messageSourceType = SKSMessageSourceTypeSend;
    emoticonMessage.messageMediaType = SKSMessageMediaTypeEmoticon;
    emoticonMessage.menuItemList = [self getMenuItemListWithMessage:emoticonMessage];
    emoticonMessage.timestampDesc = @"今天 18:43";
    SKSChatMessageModel *emoticonMessageModel = [[SKSChatMessageModel alloc] initWithMessage:emoticonMessage];
    emoticonMessageModel.shouldShowTimestamp = YES;
    emoticonMessageModel.shouldShowReadControl = YES;
    emoticonMessageModel.layoutConfig = [self.sessionConfig layoutConfigWithMessage:emoticonMessage];
    emoticonMessageModel.sessionConfig = self.sessionConfig;
    
    SKSChatMessage *emoticonMessage1 = [[SKSChatMessage alloc] init];
    emoticonMessage1.messageSourceType = SKSMessageSourceTypeReceive;
    emoticonMessage1.messageMediaType = SKSMessageMediaTypeEmoticon;
    emoticonMessage1.messageDeliveryState = SKSMessageDeliveryStateRead;
    emoticonMessage1.menuItemList = [self getMenuItemListWithMessage:emoticonMessage1];
    emoticonMessage1.timestampDesc = @"今天 18：55";
    SKSChatMessageModel *emoticonMessageModel1 = [[SKSChatMessageModel alloc] initWithMessage:emoticonMessage1];
    emoticonMessageModel1.shouldShowTimestamp = YES;
    emoticonMessageModel1.shouldShowAvatar = YES;
    emoticonMessageModel1.layoutConfig = [self.sessionConfig layoutConfigWithMessage:emoticonMessage1];
    emoticonMessageModel1.sessionConfig = self.sessionConfig;

    SKSChatMessageModel *voiceMessageModel = [self wrapperVoiceMessageWithSourceType:SKSMessageSourceTypeSend isShowTimestamp:YES isFirstTimePlay:YES duration:30];
    SKSChatMessageModel *voiceMessageModel1 = [self wrapperVoiceMessageWithSourceType:SKSMessageSourceTypeReceive isShowTimestamp:YES isFirstTimePlay:YES duration:5];
    SKSChatMessageModel *voiceMessageModel2 = [self wrapperVoiceMessageWithSourceType:SKSMessageSourceTypeReceive isShowTimestamp:NO isFirstTimePlay:YES duration:5];
    SKSChatMessageModel *voiceMessageModel3 = [self wrapperVoiceMessageWithSourceType:SKSMessageSourceTypeReceive isShowTimestamp:NO isFirstTimePlay:NO duration:60];
    SKSChatMessageModel *voiceMessageModel4 = [self wrapperVoiceMessageWithSourceType:SKSMessageSourceTypeSend isShowTimestamp:NO isFirstTimePlay:NO duration:60];
    SKSChatMessageModel *voiceMessageModel5 = [self wrapperVoiceMessageWithSourceType:SKSMessageSourceTypeSend isShowTimestamp:NO isFirstTimePlay:NO duration:60];

    
    SKSChatMessage *typingMessage = [[SKSChatMessage alloc] init];
    SKSTypingMessageObject *typingMessageObject = [[SKSTypingMessageObject alloc] initWithAnimationImageNameList:@[
                                                                                                                   @"icon-dots-1",
                                                                                                                   @"icon-dots-2",
                                                                                                                   @"icon-dots-3"
                                                                                                                   ]];
    typingMessage.messageAdditionalObject = typingMessageObject;
    typingMessage.messageSourceType = SKSMessageSourceTypeReceive;
    typingMessage.messageMediaType = SKSMessageMediaTypeTyping;
    SKSChatMessageModel *typingMessageModel = [[SKSChatMessageModel alloc] initWithMessage:typingMessage];
    typingMessageModel.shouldShowAvatar = YES;
    typingMessageModel.shouldShowTimestamp = NO;
    typingMessageModel.layoutConfig = [self.sessionConfig layoutConfigWithMessage:typingMessage];
    typingMessageModel.sessionConfig = self.sessionConfig;

    //Location
    SKSChatMessage *locationMessage = [[SKSChatMessage alloc] init];
    locationMessage.messageSourceType = SKSMessageSourceTypeReceive;
    locationMessage.messageMediaType = SKSMessageMediaTypeLocation;
    SKSLocationMessageObject *locationMessageObject = [[SKSLocationMessageObject alloc] initWithLocationImageUrl:@"" locationTitile:@"关东升" locationDesc: @"广东省广州市华南农业大学" coordinate2D: CLLocationCoordinate2DMake(0, 0)];
    locationMessage.messageAdditionalObject = locationMessageObject;
    locationMessage.menuItemList = [self getMenuItemListWithMessage:locationMessage];
    locationMessage.timestampDesc = @"今天 19:04";
    SKSChatMessageModel *locationMessageModel = [[SKSChatMessageModel alloc] initWithMessage:locationMessage];
    locationMessageModel.shouldShowAvatar = YES;
    locationMessageModel.shouldShowTimestamp = YES;
    locationMessageModel.layoutConfig = [self.sessionConfig layoutConfigWithMessage:locationMessage];
    locationMessageModel.sessionConfig = self.sessionConfig;
    
    SKSChatMessage *locationMessage1 = [[SKSChatMessage alloc] init];
    locationMessage1.messageSourceType = SKSMessageSourceTypeSend;
    locationMessage1.messageMediaType = SKSMessageMediaTypeLocation;
    locationMessage1.messageDeliveryState = SKSMessageDeliveryStateRead;
    locationMessage1.menuItemList = [self getMenuItemListWithMessage:locationMessage1];
    locationMessage1.timestampDesc = @"今天: 19:05";
    SKSLocationMessageObject *locationMessageObject1 = [[SKSLocationMessageObject alloc] initWithLocationImageUrl:@"" locationTitile:@"广州塔小蛮腰" locationDesc: @"广东省广州市天河区某个地方" coordinate2D: CLLocationCoordinate2DMake(0, 0)];
    locationMessage1.messageAdditionalObject = locationMessageObject1;
    SKSChatMessageModel *locationMessageModel1 = [[SKSChatMessageModel alloc] initWithMessage:locationMessage1];
    locationMessageModel1.shouldShowTimestamp = YES;
    locationMessageModel1.layoutConfig = [self.sessionConfig layoutConfigWithMessage:locationMessage1];
    locationMessageModel1.sessionConfig = self.sessionConfig;
    locationMessageModel1.shouldShowReadControl = YES;

    //RealTime video
    SKSChatMessageModel *realTimeVideoMessageModel = [self wrapperRealTimeVoiceOrVideoWithMessageMediaType:SKSMessageMediaTypeRealTimeVideo sourceType:SKSMessageSourceTypeReceive callState:SKSMessageCallStateAccept duration:30 sessionId:1];
    SKSChatMessageModel *realTimeVideoMessageModel1 = [self wrapperRealTimeVoiceOrVideoWithMessageMediaType:SKSMessageMediaTypeRealTimeVideo sourceType:SKSMessageSourceTypeSend callState:SKSMessageCallStateBusy duration:30 sessionId:2];


    //RealTime Voice
    SKSChatMessageModel *realTimeVoiceMessageModel = [self wrapperRealTimeVoiceOrVideoWithMessageMediaType:SKSMessageMediaTypeRealTimeVoice sourceType:SKSMessageSourceTypeReceive callState:SKSMessageCallStateNoResponse duration:30 sessionId:3];
    SKSChatMessageModel *realTimeVoiceMessageModel1 = [self wrapperRealTimeVoiceOrVideoWithMessageMediaType:SKSMessageMediaTypeRealTimeVoice sourceType:SKSMessageSourceTypeSend callState:SKSMessageCallStateFail duration:30 sessionId:4];

    //Tip
    SKSChatMessage *tipMessage = [[SKSChatMessage alloc] init];
    tipMessage.text = @"这是一条描述信息，不是具体的某些聊天信息， 我是用来凑够长度的，哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈";
    tipMessage.messageSourceType = SKSMessageSourceTypeCenter;
    tipMessage.messageMediaType = SKSMessageMediaTypeTipLabel;
    
    SKSChatMessageModel *tipMessageModel = [[SKSChatMessageModel alloc] initWithMessage:tipMessage];
    tipMessageModel.layoutConfig = [self.sessionConfig layoutConfigWithMessage:tipMessage];
    tipMessageModel.sessionConfig = self.sessionConfig;



    //Core Text

    NSString *templatePath = [[NSBundle mainBundle] pathForResource:@"chat_admin" ofType:@"html"];
    NSString *templateHtml = [NSString stringWithContentsOfFile:templatePath encoding:NSUTF8StringEncoding error:NULL];
    NSError *error;

    //指定字体格式:
    NSString * fontTestContent = @"<p><font size='15px' face=\"PingFangSC-Medium\">PingFangSC-Medium 字体</font></p>";
    SKSChatMessageModel *coreTextMessageModel = [self wrapperCoreTextMessageWithMsgId:11111 htmlText:@"<p><h2>这个是CoreText</h2>, <a style='color:red; text-decoration:none' href='ChatSessionViewController.nickname.tapAction'>你好sdfdsfsfsdf</a></p>"];
    SKSChatMessageModel *coreTextMessageModel1 = [self wrapperCoreTextMessageWithMsgId:11112 htmlText:fontTestContent];

    //附近有人置顶了一个约会，快来看看吧！一起吃饭聊天看电影
    NSString *stickTopContent = @"<p><span>附近有人置顶了一个约会，快来看看吧！</span> <span class='activity_title'>一起吃饭聊天</span></p>";
    //设置这个渲染引擎

    NSString *renderChatHtml = [GRMustacheTemplate renderObject:@{@"key_content" : stickTopContent,
            @"key_css_name" : @"chat" } fromString:templateHtml error:&error];
    SKSChatMessageModel *coreTextMessageModel2 = [self wrapperCoreTextMessageWithMsgId:111113 htmlText:renderChatHtml];


    NSString *cancelActivityContent = @"<p><span class='activity_nickname'><font face=\"PingFangSC-Medium\">王尼玛</font></span>决定取消\"<span class='activity_title'>一起吃饭聊天看电影</span>\"的邀约，他无法在这个约会中呼叫你，已返还 99 <img style=\"width:16px; height:16px;\" src=\"common-coin-icon.jpg\"> 到你的账户~</p>";
    renderChatHtml = [GRMustacheTemplate renderObject:@{@"key_content" : cancelActivityContent, @"key_css_name" : @"chat"} fromString:templateHtml error:&error];
    SKSChatMessageModel *coreTextMessageModel3 = [self wrapperCoreTextMessageWithMsgId:111114 htmlText:renderChatHtml];


    NSString *endActivityContent = @"<p>你报名的约会已结束，已返还999 <img style=\"width:16px; height:16px;\" src=\"common-coin-icon.jpg\"> 到你的账户~ <span class='activity_title'>一起聊天吃饭看电影</span></p>";
    renderChatHtml = [GRMustacheTemplate renderObject: @{
            @"key_content" : endActivityContent,
            @"key_css_name" : @"chat"
    } fromString:templateHtml error:&error];
    SKSChatMessageModel *coreTextMessageModel4 = [self wrapperCoreTextMessageWithMsgId:111115 htmlText:renderChatHtml];

    NSString *registerSuccessContent = @"<p><span class='activity_nickname'><font face=\"PingFangSC-Medium\">小李子</font></span>,你好，我是一见客服，很开心又多了一个小伙伴😊。快去首页发布你的专属邀约吧，带上承载满满诚意的 <img style=\"width:16px; height:16px;\" src=\"common-roses-icon.png\">, 在报名的用户中选择一位心仪的ta, 共赴心动之约~</p>";
    renderChatHtml = [GRMustacheTemplate renderObject: @{
            @"key_content" : registerSuccessContent,
            @"key_css_name" : @"chat"
    } fromString:templateHtml error:&error];
    SKSChatMessageModel *coreTextMessageModel5 = [self wrapperCoreTextMessageWithMsgId:111116 htmlText:renderChatHtml];
    coreTextMessageModel5.shouldShowTimestamp = YES;

   //not support
    SKSChatMessage *notSupportMessage = [[SKSChatMessage alloc] init];
    notSupportMessage.messageSourceType = SKSMessageSourceTypeReceive;//只能是receive 来的
    notSupportMessage.messageMediaType = SKSMessageMediaTypeUnsupport;
    notSupportMessage.messageDeliveryState = SKSMessageDeliveryStateSent;
    notSupportMessage.text = @"该应用版本不支持显示该类型消息，请升级至最新版本";

    SKSChatMessageModel *notSupportMessageModel = [[SKSChatMessageModel alloc] initWithMessage:notSupportMessage];
    notSupportMessageModel.sessionConfig = self.sessionConfig;
    notSupportMessageModel.layoutConfig = [self.sessionConfig layoutConfigWithMessage:notSupportMessage];
    notSupportMessageModel.shouldShowAvatar = YES;


    //Date Call
    SKSChatMessageModel *dateCallMessageModel = [self wrapperDateCallMessageWithFromUserId:@"123" toUserId:@"1234" activityAuthorId:@"1234" callStatus:SKSMessageCallStateAccept duration:2000 sourceType:SKSMessageSourceTypeReceive];
    SKSChatMessageModel *dateCallMessageModel1 = [self wrapperDateCallMessageWithFromUserId:@"123" toUserId:@"1234" activityAuthorId:@"123" callStatus:SKSMessageCallStateNoResponse duration:0 sourceType:SKSMessageSourceTypeSend];
    SKSChatMessageModel *dateCallMessageModel2 = [self wrapperDateCallMessageWithFromUserId:@"123" toUserId:@"1234" activityAuthorId:@"123" callStatus:SKSMessageCallStateCancel duration:0 sourceType:SKSMessageSourceTypeReceive];
    SKSChatMessageModel *dateCallMessageModel3 = [self wrapperDateCallMessageWithFromUserId:@"123" toUserId:@"1234" activityAuthorId:@"123" callStatus:SKSMessageCallStateReject duration:0 sourceType:SKSMessageSourceTypeReceive];
    SKSChatMessageModel *dateCallMessageModel4 = [self wrapperDateCallMessageWithFromUserId:@"123" toUserId:@"1234" activityAuthorId:@"123" callStatus:SKSMessageCallStateFail duration:0 sourceType:SKSMessageSourceTypeReceive];
    SKSChatMessageModel *dateCallMessageModel5 = [self wrapperDateCallMessageWithFromUserId:@"123" toUserId:@"1234" activityAuthorId:@"123" callStatus:SKSMessageCallStateBusy duration:0 sourceType:SKSMessageSourceTypeReceive];
    SKSChatMessageModel *dateCallMessageModel6 = [self wrapperDateCallMessageWithFromUserId:@"123" toUserId:@"1234" activityAuthorId:@"1234" callStatus:SKSMessageCallStateFail duration:0 sourceType:SKSMessageSourceTypeReceive];
    SKSChatMessageModel *dateCallMessageModel7 = [self wrapperDateCallMessageWithFromUserId:@"123" toUserId:@"1234" activityAuthorId:@"1234" callStatus:SKSMessageCallStateReject duration:0 sourceType:SKSMessageSourceTypeReceive];
    SKSChatMessageModel *dateCallMessageModel8 = [self wrapperDateCallMessageWithFromUserId:@"1234" toUserId:@"123" activityAuthorId:@"1234" callStatus:SKSMessageCallStateCancel duration:0 sourceType:SKSMessageSourceTypeReceive];
    SKSChatMessageModel *dateCallMessageModel9 = [self wrapperDateCallMessageWithFromUserId:@"1234" toUserId:@"123" activityAuthorId:@"1234" callStatus:SKSMessageCallStateBusy duration:0 sourceType:SKSMessageSourceTypeReceive];
    SKSChatMessageModel *dateCallMessageModel10 = [self wrapperDateCallMessageWithFromUserId:@"123" toUserId:@"1234" activityAuthorId:@"123" callStatus:SKSMessageCallStateFail duration:0 sourceType:SKSMessageSourceTypeSend];
    SKSChatMessageModel *dateCallMessageModel11 = [self wrapperDateCallMessageWithFromUserId:@"123" toUserId:@"1234" activityAuthorId:@"123" callStatus:SKSMessageCallStateReject duration:0 sourceType:SKSMessageSourceTypeSend];
    SKSChatMessageModel *dateCallMessageModel12 = [self wrapperDateCallMessageWithFromUserId:@"123" toUserId:@"1234" activityAuthorId:@"123" callStatus:SKSMessageCallStateCancel duration:0 sourceType:SKSMessageSourceTypeSend];
    SKSChatMessageModel *dateCallMessageModel13 = [self wrapperDateCallMessageWithFromUserId:@"123" toUserId:@"1234" activityAuthorId:@"123" callStatus:SKSMessageCallStateBusy duration:0 sourceType:SKSMessageSourceTypeSend];
    SKSChatMessageModel *dateCallMessageModel14 = [self wrapperDateCallMessageWithFromUserId:@"123" toUserId:@"1234" activityAuthorId:@"123" callStatus:SKSMessageCallStateAccept duration:40000 sourceType:SKSMessageSourceTypeSend];

    //Date offer
    SKSChatMessageModel *dateOfferMessageModel = [self wrapperChatMessageModelWithDateOfferState:SKSDateOfferStateNotProcessed sourceType:SKSMessageSourceTypeReceive];
    SKSChatMessageModel *dateOfferMessageModel1 = [self wrapperChatMessageModelWithDateOfferState:SKSDateOfferStateOfferInvalid sourceType:SKSMessageSourceTypeReceive];
    SKSChatMessageModel *dateOfferMessageModel2 = [self wrapperChatMessageModelWithDateOfferState:SKSDateOfferStateOfferRejected sourceType:SKSMessageSourceTypeReceive];
    SKSChatMessageModel *dateOfferMessageModel3 = [self wrapperChatMessageModelWithDateOfferState:SKSDateOfferStateOfferAccepted sourceType:SKSMessageSourceTypeReceive];

    SKSChatMessageModel *dateOfferMessageModel4 = [self wrapperChatMessageModelWithDateOfferState:SKSDateOfferStateMakeOffer sourceType:SKSMessageSourceTypeSend];
    SKSChatMessageModel *dateOfferMessageModel5 = [self wrapperChatMessageModelWithDateOfferState:SKSDateOfferStateOfferAccepted sourceType:SKSMessageSourceTypeSend];
    SKSChatMessageModel *dateOfferMessageModel6 = [self wrapperChatMessageModelWithDateOfferState:SKSDateOfferStateOfferRejected sourceType:SKSMessageSourceTypeSend];
    SKSChatMessageModel *dateOfferMessageModel7 = [self wrapperChatMessageModelWithDateOfferState:SKSDateOfferStateOfferInvalid sourceType:SKSMessageSourceTypeSend];

    //Date Preview Message
    SKSChatMessageModel *dateJoinedPreviewMessageModel = [self wrapperChatMessageModelWithTitle:@"一起吃饭看电影吧，哈哈哈哈哈哈1eeeeeeeeeeee" roseCount:9999 activtyState:SKSActivityState_PUBLISHED];
    SKSChatMessageModel *dateJoinedPreviewMessageModel1 = [self wrapperChatMessageModelWithTitle:@"一起吃饭看电影吧哈哈哈哈哈哈哈2" roseCount:666 activtyState:SKSActivityState_EXPIRED];
    SKSChatMessageModel *dateJoinedPreviewMessageModel2 = [self wrapperChatMessageModelWithTitle:@"一起吃饭看电影吧哈哈哈哈哈哈哈3" roseCount:0 activtyState:SKSActivityState_PUBLISHED];
    SKSChatMessageModel *dateJoinedPreviewMessageModel3 = [self wrapperChatMessageModelWithTitle:@"10086-1" roseCount:0 activtyState:SKSActivityState_PUBLISHED];
    SKSChatMessageModel *dateJoinedPreviewMessageModel4 = [self wrapperChatMessageModelWithTitle:@"10086-2" roseCount:123 activtyState:SKSActivityState_PUBLISHED];

    //Confirm meet message
    SKSChatMessageModel *confirmMeetMessageModel = [self wrapperConfirmMeetMessageWithActivityTitle:@"我们一起去玩游艇划船吧，哈哈还" dateOfferState:SKSDateOfferStateNotProcessed nickname:@"哈哈还"];
    SKSChatMessageModel *confirmMeetMessageModel1 = [self wrapperConfirmMeetMessageWithActivityTitle:@"我们一起去玩游艇划船吧，哈哈还2" dateOfferState:SKSDateOfferStateOfferInvalid nickname:@"哈哈还"];

    //Impress message
    SKSChatMessageModel *impressMessageModel = [self wrapperImpressMessageWithUserId:@"123" nickname:@"我是用户甲" SKSChatGender:SKSChatGenderMale impressStatus:SKSImpressStatusNotProgress];
    SKSChatMessageModel *impressMessageModel1 = [self wrapperImpressMessageWithUserId:@"123" nickname:@"我是用户乙" SKSChatGender:SKSChatGenderFemale impressStatus:SKSImpressStatusSuccess];
    SKSChatMessageModel *impressMessageModel2 = [self wrapperImpressMessageWithUserId:@"123" nickname:@"我是用户丙" SKSChatGender:SKSChatGenderFemale impressStatus:SKSImpressStatusInvalid];

    //UnRead message
    SKSChatMessageModel *unReadMessageModel = [self wrapperUnReadMessageWithUnReadCount:3903];
    SKSChatMessageModel *unReadMessageModel1 = [self wrapperUnReadMessageWithUnReadCount:1];
    SKSChatMessageModel *unReadMessageModel2 = [self wrapperUnReadMessageWithUnReadCount:13];
    SKSChatMessageModel *unReadMessageModel3 = [self wrapperUnReadMessageWithUnReadCount:199];

    //Privacy Activity message
    SKSChatMessageModel *privacyActivityMessageModel = [self wrapperPrivacyActivityWithPlace:@"地点一，凑字数lalla" detailPlace:@"" title:@"地点标题一标题标题标题标题标题" withCash:400 privateDateOfferState:SKSPrivacyDateOfferStateUnhandle messageSourceType:SKSMessageSourceTypeReceive];
    SKSChatMessageModel *privacyActivityMessageModel1 = [self wrapperPrivacyActivityWithPlace:@"地点二，凑字数lallalalalallalalalalalalal拉拉拉拉" detailPlace:@"" title:@"地点标题二标题标题标题标题标题" withCash:500 privateDateOfferState:SKSPrivacyDateOfferStateAccept messageSourceType:SKSMessageSourceTypeReceive];
    SKSChatMessageModel *privacyActivityMessageModel2 = [self wrapperPrivacyActivityWithPlace:@"地点三，凑字数lallalalalallalalalalalalal拉拉拉拉" detailPlace:@"" title:@"地点标题三标题标题标题标题标题" withCash:600 privateDateOfferState:SKSPrivacyDateOfferStateThinkAbout messageSourceType:SKSMessageSourceTypeReceive];
    SKSChatMessageModel *privacyActivityMessageModel3 = [self wrapperPrivacyActivityWithPlace:@"地点四，凑字数lallalalalallalalalalalalal拉拉拉拉" detailPlace:@"" title:@"地点标题四标题标题标题标题标题" withCash:600 privateDateOfferState:SKSPrivacyDateOfferStateReject messageSourceType:SKSMessageSourceTypeReceive];
    SKSChatMessageModel *privacyActivityMessageModel4 = [self wrapperPrivacyActivityWithPlace:@"地点五，凑字数lallalalalallalalalalalalal拉拉拉拉" detailPlace:@"" title:@"地点标题五标题标题标题标题标题" withCash:600 privateDateOfferState:SKSPrivacyDateOfferStateInvalid messageSourceType:SKSMessageSourceTypeReceive];
    SKSChatMessageModel *privacyActivityMessageModel5 = [self wrapperPrivacyActivityWithPlace:@"地点六，凑字数lallalalalallalalalalalalal拉拉拉拉" detailPlace:@"" title:@"地点标题六标题标题标题标题标题" withCash:600 privateDateOfferState:SKSPrivacyDateOfferStateAccept messageSourceType:SKSMessageSourceTypeSend];
    SKSChatMessageModel *privacyActivityMessageModel6 = [self wrapperPrivacyActivityWithPlace:@"地点七，凑字数lallalalalallalalalalalalal拉拉拉拉" detailPlace:@"" title:@"地点标题七标题标题标题标题标题" withCash:600 privateDateOfferState:SKSPrivacyDateOfferStateUnhandle messageSourceType:SKSMessageSourceTypeSend];
    SKSChatMessageModel *privacyActivityMessageModel7 = [self wrapperPrivacyActivityWithPlace:@"地点七，凑字数lallalalalallalalalalalalal拉拉拉拉" detailPlace:@"" title:@"地点标题七标题标题标题标题标题" withCash:600 privateDateOfferState:SKSPrivacyDateOfferStateReject messageSourceType:SKSMessageSourceTypeSend];
    SKSChatMessageModel *privacyActivityMessageModel8 = [self wrapperPrivacyActivityWithPlace:@"地点七，凑字数lallalalalallalalalalalalal拉拉拉拉" detailPlace:@"" title:@"地点标题七标题标题标题标题标题" withCash:600 privateDateOfferState:SKSPrivacyDateOfferStateMet messageSourceType:SKSMessageSourceTypeSend];

    //Privacy send roses message
    SKSChatMessageModel *privacySendRosesMessageModel = [self wrapperPrivacySendRosesWithRosesCount:300 state:SKSPrivacyGiftOfferStateUnhandle sourceType:SKSMessageSourceTypeReceive];
    SKSChatMessageModel *privacySendRosesMessageModel1 = [self wrapperPrivacySendRosesWithRosesCount:400 state:SKSPrivacyGiftOfferStateAccept sourceType:SKSMessageSourceTypeReceive];
    SKSChatMessageModel *privacySendRosesMessageModel2 = [self wrapperPrivacySendRosesWithRosesCount:500 state:SKSPrivacyGiftOfferStateReject sourceType:SKSMessageSourceTypeReceive];
    SKSChatMessageModel *privacySendRosesMessageModel3 = [self wrapperPrivacySendRosesWithRosesCount:500 state:SKSPrivacyGiftOfferStateReject sourceType:SKSMessageSourceTypeSend];

    [_messageList addObject:textMessageModel4];
    [_messageList addObject:textMessageModel2];
    [_messageList addObject:textMessageModel3];
    [_messageList addObject:textMessageModel1];
    [_messageList addObject:yoMessageModel];
    [_messageList addObject:yoMessageModel1];
    [_messageList addObject:emoticonMessageModel];
    [_messageList addObject:emoticonMessageModel1];
    [_messageList addObject:voiceMessageModel1];
    [_messageList addObject:voiceMessageModel];
    [_messageList addObject:typingMessageModel];
    [_messageList addObject:locationMessageModel];
    [_messageList addObject:locationMessageModel1];
    [_messageList addObject:realTimeVideoMessageModel];
    [_messageList addObject:realTimeVideoMessageModel1];
    [_messageList addObject:realTimeVoiceMessageModel];
    [_messageList addObject:realTimeVoiceMessageModel1];
    [_messageList addObject:tipMessageModel];
    [_messageList addObject:notSupportMessageModel];
    [_messageList addObject:dateJoinedPreviewMessageModel];
    [_messageList addObject:dateJoinedPreviewMessageModel1];
    [_messageList addObject:dateJoinedPreviewMessageModel2];
    [_messageList addObject:dateOfferMessageModel];
    [_messageList addObject:dateOfferMessageModel1];
    [_messageList addObject:dateOfferMessageModel2];
    [_messageList addObject:dateOfferMessageModel3];
    [_messageList addObject:dateOfferMessageModel4];
    [_messageList addObject:dateOfferMessageModel5];
    [_messageList addObject:dateOfferMessageModel6];
    [_messageList addObject:dateOfferMessageModel7];
    [_messageList addObject:coreTextMessageModel];
    [_messageList addObject:dateCallMessageModel];
    [_messageList addObject:dateCallMessageModel1];
    [_messageList addObject:dateCallMessageModel2];
    [_messageList addObject:dateCallMessageModel3];
    [_messageList addObject:dateCallMessageModel4];
    [_messageList addObject:dateCallMessageModel5];
    [_messageList addObject:dateCallMessageModel6];
    [_messageList addObject:dateCallMessageModel7];
    [_messageList addObject:dateCallMessageModel8];
    [_messageList addObject:dateCallMessageModel9];
    [_messageList addObject:dateCallMessageModel10];
    [_messageList addObject:dateCallMessageModel11];
    [_messageList addObject:dateCallMessageModel12];
    [_messageList addObject:dateCallMessageModel13];
    [_messageList addObject:dateCallMessageModel14];
    [_messageList addObject:confirmMeetMessageModel];
    [_messageList addObject:confirmMeetMessageModel1];

    [_messageList addObject:impressMessageModel];
    [_messageList addObject:impressMessageModel1];
    [_messageList addObject:impressMessageModel2];

    [_messageList addObject:coreTextMessageModel1];
    [_messageList addObject:coreTextMessageModel2];
    [_messageList addObject:coreTextMessageModel3];
    [_messageList addObject:coreTextMessageModel4];
    [_messageList addObject:coreTextMessageModel5];
    [_messageList addObject:voiceMessageModel1];
    [_messageList addObject:voiceMessageModel2];
    [_messageList addObject:voiceMessageModel3];
    [_messageList addObject:unReadMessageModel];
    [_messageList addObject:voiceMessageModel3];
    [_messageList addObject:unReadMessageModel1];
    [_messageList addObject:unReadMessageModel2];
    [_messageList addObject:unReadMessageModel3];

    [_messageList addObject:dateJoinedPreviewMessageModel];
    [_messageList addObject:dateJoinedPreviewMessageModel1];
    [_messageList addObject:dateJoinedPreviewMessageModel2];
    [_messageList addObject:dateJoinedPreviewMessageModel3];

    [_messageList addObject:voiceMessageModel3];
    [_messageList addObject:voiceMessageModel4];
    [_messageList addObject:voiceMessageModel5];

    [_messageList addObject:realTimeVideoMessageModel];
    [_messageList addObject:realTimeVideoMessageModel1];
    [_messageList addObject:realTimeVoiceMessageModel];
    [_messageList addObject:realTimeVoiceMessageModel1];

    [_messageList addObject:locationMessageModel];
    [_messageList addObject:locationMessageModel1];

    [_messageList addObject:dateJoinedPreviewMessageModel];
    [_messageList addObject:dateJoinedPreviewMessageModel1];
    [_messageList addObject:dateJoinedPreviewMessageModel2];
    [_messageList addObject:dateJoinedPreviewMessageModel3];
    [_messageList addObject:dateJoinedPreviewMessageModel4];

    [_messageList addObject:textMessageModel];
    [_messageList addObject:textMessageModel1];
    [_messageList addObject:textMessageModel2];
    [_messageList addObject:textMessageModel3];
    [_messageList addObject:textMessageModel4];
    [_messageList addObject:textMessageModel5];
    [_messageList addObject:textMessageModel6];
    [_messageList addObject:textMessageModel7];

    [_messageList addObject:realTimeVideoMessageModel];
    [_messageList addObject:realTimeVideoMessageModel1];
    [_messageList addObject:realTimeVoiceMessageModel];
    [_messageList addObject:realTimeVoiceMessageModel1];

    [_messageList addObject:privacySendRosesMessageModel];
    [_messageList addObject:privacySendRosesMessageModel1];
    [_messageList addObject:privacySendRosesMessageModel2];
    [_messageList addObject:privacySendRosesMessageModel3];

    [_messageList addObject:coreTextMessageModel];
    [_messageList addObject:coreTextMessageModel1];

    [_messageList addObject:privacyActivityMessageModel];
    [_messageList addObject:privacyActivityMessageModel1];
    [_messageList addObject:privacyActivityMessageModel2];
    [_messageList addObject:privacyActivityMessageModel3];
    [_messageList addObject:privacyActivityMessageModel4];
    [_messageList addObject:privacyActivityMessageModel5];
    [_messageList addObject:privacyActivityMessageModel6];
    [_messageList addObject:privacyActivityMessageModel7];
    [_messageList addObject:privacyActivityMessageModel8];

    [_messageList addObject:impressMessageModel];
    [_messageList addObject:impressMessageModel1];
    [_messageList addObject:impressMessageModel2];

}

#pragma mark - Helper method
+ (NSString *)dict2Json:(NSDictionary *)dict {
    NSString *ret = @"";
    if ([NSJSONSerialization isValidJSONObject:dict]) {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
        ret =[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }

    return ret;
}

- (NSArray<id<SKSMenuItemProtocol>> *)getMenuItemListWithMessage:(SKSChatMessage *)message {
    NSArray<id<SKSMenuItemProtocol>> *menuItemArray;
    SEL deleteMenuItem = NSSelectorFromString(@"deleteMenuItem:");
    SEL copyMenuItem = NSSelectorFromString(@"copyMenuItem:");
    id<SKSMenuItemProtocol> deleteObject = [[SKSMenuItemBaseObject alloc] initWithMenuItemName:@"删除" aSelector:deleteMenuItem];

    switch (message.messageMediaType) {
        case SKSMessageMediaTypeText: {
            id<SKSMenuItemProtocol> copyObject = [[SKSMenuItemBaseObject alloc] initWithMenuItemName:@"复制" aSelector:copyMenuItem];

            menuItemArray = @[deleteObject, copyObject];
            break;
        }
        default: {
            menuItemArray = @[deleteObject];
            break;
        }
    }

    DLog(@"mediaType: %ld menuItemArray.count: %ld", (long)message.messageMediaType, (long)menuItemArray.count);
    return menuItemArray;
}

- (SKSChatMessageModel *)wrapperChatMessageModelWithDateOfferState:(SKSDateOfferState)dateOfferState sourceType:(SKSMessageSourceType)sourceType {
    SKSChatMessage *chatMessage = [[SKSChatMessage alloc] init];
    chatMessage.messageSourceType = sourceType;
    chatMessage.messageMediaType = SKSMessageMediaTypeDateOffer;
    chatMessage.messageDeliveryState = SKSMessageDeliveryStateSent;
    chatMessage.timestampDesc = @"今天 23:34";
    chatMessage.messageId = time(NULL);

    ChatDateOfferMessageObject *messageObject = [[ChatDateOfferMessageObject alloc] init];
    messageObject.title = @"我们一起去吃饭";
    messageObject.dateOfferState = dateOfferState;
    messageObject.message = chatMessage;
    chatMessage.messageAdditionalObject = messageObject;

    SKSChatMessageModel *messageModel = [[SKSChatMessageModel alloc] initWithMessage:chatMessage];
    messageModel.shouldShowTimestamp = YES;
    messageModel.shouldShowAvatar = YES;
    messageModel.sessionConfig = self.sessionConfig;
    messageModel.layoutConfig = [self.sessionConfig layoutConfigWithMessage:chatMessage];

    if (sourceType == SKSMessageSourceTypeSend) {
        messageModel.shouldShowReadControl = YES;
    }

    if (sourceType != SKSMessageSourceTypeReceive) {
        messageModel.shouldShowAvatar = NO;
    }

    return messageModel;
}

- (SKSChatMessageModel *)wrapperChatMessageModelWithTitle:(NSString *)title roseCount:(int32_t)roseCount activtyState:(SKSActivityState)activityState {
    SKSChatMessage *chatMessage = [[SKSChatMessage alloc] init];
    chatMessage.messageSourceType = SKSMessageSourceTypeCenter;
    chatMessage.messageMediaType = SKSMessageMediaTypeDateJoinedPreview;
    chatMessage.messageDeliveryState = SKSMessageDeliveryStateSent;
    chatMessage.timestampDesc = @"今天 24: 50";
    chatMessage.messageId = time(NULL);

    ChatDateJoinedPreviewMessageObject *messageObject = [[ChatDateJoinedPreviewMessageObject alloc] init];
    messageObject.title = title;
    messageObject.roses = roseCount;
    messageObject.state = activityState;

    chatMessage.messageAdditionalObject = messageObject;

    SKSChatMessageModel *chatMessageModel = [[SKSChatMessageModel alloc] initWithMessage:chatMessage];
    chatMessageModel.sessionConfig = self.sessionConfig;
    chatMessageModel.layoutConfig = [self.sessionConfig layoutConfigWithMessage:chatMessage];
    chatMessageModel.shouldShowTimestamp = YES;
    return chatMessageModel;
}

- (SKSChatMessageModel *)wrapperDateCallMessageWithFromUserId:(NSString *)userId toUserId:(NSString *)toUserId activityAuthorId:(NSString *)activityAuthorId callStatus:(SKSMessageCallState)callStatus duration:(int32_t)duration sourceType:(SKSMessageSourceType)sourceType {

    SKSChatMessage *chatMessage = [[SKSChatMessage alloc] init];
    chatMessage.messageSourceType = sourceType;
    chatMessage.messageMediaType = SKSMessageMediaTypeDataCall;
    chatMessage.messageDeliveryState = SKSMessageDeliveryStateSent;
    chatMessage.fromId = userId;
    chatMessage.toId = toUserId;

    SKSDateCallMessageObject *messageObject = [[SKSDateCallMessageObject alloc] initWithSessionId:(int64_t)1000 activityId:@"123" activityAuthorId:activityAuthorId callState:callStatus duration:duration message:chatMessage];

    messageObject.iconImageName = @"chat-room-phone-gray";
    chatMessage.messageAdditionalObject = messageObject;

    SKSChatMessageModel *messageModel = [[SKSChatMessageModel alloc] initWithMessage:chatMessage];
    messageModel.sessionConfig = self.sessionConfig;
    messageModel.layoutConfig = [self.sessionConfig layoutConfigWithMessage:chatMessage];

    if (sourceType == SKSMessageSourceTypeSend) {
        messageModel.shouldShowReadControl = YES;
    }

    switch (sourceType) {
        case SKSMessageSourceTypeReceive: {
            messageModel.shouldShowAvatar = YES;
            break;
        }
        default: {
            messageModel.shouldShowAvatar = NO;
            break;
        }
    }
    return messageModel;
}

- (SKSChatMessageModel *)wrapperConfirmMeetMessageWithActivityTitle:(NSString *)activityTitle dateOfferState:(SKSDateOfferState)dateOfferState nickname:(NSString *)nickname {
    SKSChatMessage *chatMessage = [[SKSChatMessage alloc] init];
    chatMessage.messageSourceType = SKSMessageSourceTypeReceive;
    chatMessage.messageMediaType = SKSMessageMediaTypeConfirmMeet;
    chatMessage.messageDeliveryState = SKSMessageDeliveryStateSent;
    chatMessage.timestampDesc = @"今天 23:34";
    chatMessage.messageId = time(NULL);

    ChatConfirmMeetMessageObject *messageObject = [[ChatConfirmMeetMessageObject alloc] init];
    messageObject.title = @"我们一起去吃饭";
    messageObject.dateOfferState = dateOfferState;
    messageObject.nickname = @"我是帐号哟";
    messageObject.message = chatMessage;
    chatMessage.messageAdditionalObject = messageObject;

    SKSChatMessageModel *messageModel = [[SKSChatMessageModel alloc] initWithMessage:chatMessage];
    messageModel.shouldShowTimestamp = YES;
    messageModel.shouldShowAvatar = YES;
    messageModel.sessionConfig = self.sessionConfig;
    messageModel.layoutConfig = [self.sessionConfig layoutConfigWithMessage:chatMessage];
    messageModel.shouldShowAvatar = NO;
    return messageModel;
}

- (SKSChatMessageModel *)wrapperImpressMessageWithUserId:(NSString *)userId nickname:(NSString *)nickname SKSChatGender:(SKSChatGender)gender impressStatus:(SKSImpressStatus)impressStatus {
    SKSChatMessage *chatMessage = [[SKSChatMessage alloc] init];
    chatMessage.messageSourceType = SKSMessageSourceTypeReceive;
    chatMessage.messageMediaType = SKSMessageMediaTypeImpress;
    chatMessage.messageDeliveryState = SKSMessageDeliveryStateSent;
    chatMessage.timestampDesc = @"今天 23:36";
    chatMessage.messageId = time(NULL);

    ChatImpressMessageObject *messageObject = [[ChatImpressMessageObject alloc] initWithUserId:userId nickname:nickname gender:gender impressStatus:impressStatus message:chatMessage];
    chatMessage.messageAdditionalObject = messageObject;

    SKSChatMessageModel *messageModel = [[SKSChatMessageModel alloc] initWithMessage:chatMessage];
    messageModel.shouldShowTimestamp = YES;
    messageModel.shouldShowAvatar = YES;
    messageModel.sessionConfig = self.sessionConfig;
    messageModel.layoutConfig = [self.sessionConfig layoutConfigWithMessage:chatMessage];
    messageModel.shouldShowAvatar = NO;
    return messageModel;
}

- (SKSChatMessageModel *)wrapperCoreTextMessageWithMsgId:(int64_t)msgID htmlText:(NSString *)htmlText {

    SKSChatMessage *chatMessage = [[SKSChatMessage alloc] init];
    chatMessage.messageSourceType = SKSMessageSourceTypeReceive;
    chatMessage.messageMediaType = SKSMessageMediaTypeCoreText;
    chatMessage.messageDeliveryState = SKSMessageDeliveryStateSent;
    chatMessage.menuItemList = [self getMenuItemListWithMessage:chatMessage];
    chatMessage.messageId = msgID;
    chatMessage.timestampDesc = @"今天 08:50";

    SKSCoreTextMessageObject *messageObject = [[SKSCoreTextMessageObject alloc] initWithHtmlText:htmlText];
    messageObject.message = chatMessage;
    chatMessage.messageAdditionalObject = messageObject;

    SKSChatMessageModel *messageModel = [[SKSChatMessageModel alloc] initWithMessage:chatMessage];
    messageModel.shouldShowAvatar = YES;
    messageModel.sessionConfig = self.sessionConfig;
    messageModel.layoutConfig = [self.sessionConfig layoutConfigWithMessage:chatMessage];

    return messageModel;
}

- (SKSChatMessageModel *)wrapperVoiceMessageWithSourceType:(SKSMessageSourceType)sourceType isShowTimestamp:(BOOL)isShowTimestamp isFirstTimePlay:(BOOL)isFirstTimePlay duration:(int32_t)duration {
    SKSChatMessage *chatMessage = [[SKSChatMessage alloc] init];
    chatMessage.messageSourceType = sourceType;
    chatMessage.messageMediaType = SKSMessageMediaTypeVoice;
    chatMessage.messageDeliveryState = SKSMessageDeliveryStateDelivering;
    chatMessage.menuItemList = [self getMenuItemListWithMessage:chatMessage];
    SKSVoiceMessageObject *voiceAdditionalMessage = [[SKSVoiceMessageObject alloc] initWithVoiceUrl:@"" voiceFormat:SKSVoiceMessageFormat_ISAC duration:duration isFirstTimePlay:isFirstTimePlay];

    chatMessage.messageAdditionalObject = voiceAdditionalMessage;
    SKSChatMessageModel *messageModel = [[SKSChatMessageModel alloc] initWithMessage:chatMessage];
    messageModel.shouldShowTimestamp = isShowTimestamp;
    messageModel.layoutConfig = [self.sessionConfig layoutConfigWithMessage:chatMessage];
    messageModel.sessionConfig = self.sessionConfig;

    if (sourceType == SKSMessageSourceTypeSend) {
        messageModel.shouldShowReadControl = YES;
    }

    if (isShowTimestamp) {
        chatMessage.timestampDesc = @"今天 23:46";
    }

    return messageModel;
}

- (SKSChatMessageModel *)wrapperUnReadMessageWithUnReadCount:(int32_t)unReadCount {
    SKSChatMessage *chatMessage = [[SKSChatMessage alloc] init];
    chatMessage.messageSourceType = SKSMessageSourceTypeCenter;
    chatMessage.messageDeliveryState = SKSMessageDeliveryStateSent;
    chatMessage.messageMediaType = SKSMessageMediaTypeUnReadTip;

    SKSUnReadMessageObject *messageObject = [SKSUnReadMessageObject alloc];
    messageObject.unReadCount = unReadCount;
    chatMessage.messageAdditionalObject = messageObject;

    SKSChatMessageModel *messageModel = [[SKSChatMessageModel alloc] initWithMessage:chatMessage];
    messageModel.layoutConfig = [self.sessionConfig layoutConfigWithMessage:chatMessage];
    messageModel.sessionConfig = self.sessionConfig;
    return messageModel;
}

- (SKSChatMessageModel *)wrapperTextMessageWithContent:(NSString *)content mesageSourceType:(SKSMessageSourceType)messageSourceType timestampDesc:(NSString *)timestampDesc {
    SKSChatMessage *chatMessage = [[SKSChatMessage alloc] init];
    chatMessage.messageSourceType = messageSourceType;
    chatMessage.messageDeliveryState = SKSMessageDeliveryStateFail;
    chatMessage.messageMediaType = SKSMessageMediaTypeText;
    chatMessage.text = content;
    chatMessage.timestampDesc = timestampDesc;
    chatMessage.menuItemList = [self getMenuItemListWithMessage:chatMessage];
    chatMessage.messageId = time(NULL) + random() % 10000;

    SKSChatMessageModel *messageModel = [[SKSChatMessageModel alloc] initWithMessage:chatMessage];
    messageModel.layoutConfig = [self.sessionConfig layoutConfigWithMessage:chatMessage];
    messageModel.sessionConfig = self.sessionConfig;

    if (messageSourceType == SKSMessageSourceTypeSend) {
        messageModel.shouldShowReadControl = YES;
    }

    if (timestampDesc.length > 0) {
        messageModel.shouldShowTimestamp = YES;
    }

    switch (messageSourceType) {
        case SKSMessageSourceTypeReceive: {
            messageModel.shouldShowAvatar = YES;
            break;
        }
        default: {
            break;
        }
    }

    return messageModel;
}

- (SKSChatMessageModel *)wrapperRealTimeVoiceOrVideoWithMessageMediaType:(SKSMessageMediaType)messageMediaType sourceType:(SKSMessageSourceType)sourceType callState:(SKSMessageCallState)callState duration:(int32_t)duration sessionId:(int64_t)sessionId {
    SKSChatMessage *chatMessage = [[SKSChatMessage alloc] init];
    chatMessage.messageSourceType = sourceType;
    chatMessage.messageMediaType = messageMediaType;
    chatMessage.menuItemList = [self getMenuItemListWithMessage:chatMessage];

    SKSRealTimeVideoOrVoiceMessageObject *messageObject = [[SKSRealTimeVideoOrVoiceMessageObject alloc] initWithSessionId:sessionId callState:callState duration:duration];
    messageObject.message = chatMessage;//TODO: 编码的时候可能会忘记
    chatMessage.messageAdditionalObject = messageObject;

    SKSChatMessageModel *messageModel = [[SKSChatMessageModel alloc] initWithMessage:chatMessage];
    messageModel.layoutConfig = [self.sessionConfig layoutConfigWithMessage:chatMessage];
    messageModel.sessionConfig = self.sessionConfig;
    messageModel.shouldShowReadControl = YES;

    return messageModel;
}

- (SKSChatMessageModel *)wrapperPrivacyActivityWithPlace:(NSString *)place detailPlace:(NSString *)detailPlace title:(NSString *)title withCash:(int32_t)withCrash privateDateOfferState:(SKSPrivacyDateOfferState)privacyDateOfferState messageSourceType:(SKSMessageSourceType)messageSourceType {

    SKSChatMessage *chatMessage = [[SKSChatMessage alloc] init];
    chatMessage.messageSourceType = messageSourceType;
    chatMessage.messageMediaType = SKSMessageMediaTypePrivacyActivity;
    chatMessage.menuItemList = [self getMenuItemListWithMessage:chatMessage];

    ChatPrivacyDateOfferMessageObject *messageObject = [[ChatPrivacyDateOfferMessageObject alloc] initWithAid:@"" authorId:@"" title:title coverUrl:@"" startTime:time(NULL) duration:6400 place:place detailPlace:@"" lat:0 lng:0 placeLat:0 placeLng:0 withCash:withCrash privacyDateOfferState:privacyDateOfferState];
    messageObject.roses = 30;
    messageObject.message = chatMessage;
    chatMessage.messageAdditionalObject = messageObject;

    SKSChatMessageModel *messageModel = [[SKSChatMessageModel alloc] initWithMessage:chatMessage];
    messageModel.layoutConfig = [self.sessionConfig layoutConfigWithMessage:chatMessage];
    messageModel.sessionConfig = self.sessionConfig;

    switch (messageSourceType) {
        case SKSMessageSourceTypeReceive: {
            messageModel.shouldShowAvatar = YES;
            break;
        }
        case SKSMessageSourceTypeSend: {
            messageModel.shouldShowReadControl = YES;
            break;
        }
        default: {
            break;
        }
    }

    return messageModel;
}

- (SKSChatMessageModel *)wrapperPrivacySendRosesWithRosesCount:(int32_t)rosesCount state:(SKSPrivacyGiftOfferState)state sourceType:(SKSMessageSourceType)sourceType {
    SKSChatMessage *chatMessage = [[SKSChatMessage alloc] init];
    chatMessage.messageSourceType = sourceType;
    chatMessage.messageMediaType = SKSMessageMediaTypePrivacyGiftOffer;

    ChatPrivacyGiftOfferMessageObject *messageObject = [[ChatPrivacyGiftOfferMessageObject alloc] initWithRoseCount:rosesCount leftBtnTitle:@"接受" rightBtnTitle:@"退回" state:state];
    messageObject.message = chatMessage;
    chatMessage.messageAdditionalObject = messageObject;

    SKSChatMessageModel *messageModel = [[SKSChatMessageModel alloc] initWithMessage:chatMessage];
    messageModel.layoutConfig = [self.sessionConfig layoutConfigWithMessage:chatMessage];
    messageModel.sessionConfig = self.sessionConfig;
    messageModel.shouldShowReadControl = YES;

    return messageModel;
}

@end
