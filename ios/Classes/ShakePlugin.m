#import "ShakePlugin.h"
#if __has_include(<shake_flutter/shake_flutter-Swift.h>)
#import <shake_flutter/shake_flutter-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "shake_flutter-Swift.h"
#endif

static FlutterMethodChannel *channel = nil;

@implementation ShakePlugin

- (instancetype)initWithMessenger:(nonnull NSObject<FlutterBinaryMessenger> *)messenger {
    self = [super init];
    return self;
}

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    id<FlutterBinaryMessenger> messenger = [registrar messenger];
    channel = [FlutterMethodChannel methodChannelWithName:@"shake" binaryMessenger:messenger];
    ShakePlugin *instance = [[ShakePlugin alloc] initWithMessenger:messenger];
    [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall *)call result:(FlutterResult)result {

    if([@"start" isEqualToString:call.method]) {
        [self start:call result:result];
    } else if([@"show" isEqualToString:call.method]) {
        [self show:call result:result];
    } else if([@"setEnabled" isEqualToString:call.method]) {
        [self setEnabled:call result:result];
    } else if([@"setEnableActivityHistory" isEqualToString:call.method]) {
        [self setEnableActivityHistory:call result:result];
    } else if([@"isEnableActivityHistory" isEqualToString:call.method]) {
        [self isEnableActivityHistory:call result:result];
    } else if([@"setEnableInspectScreen" isEqualToString:call.method]) {
        [self setEnableInspectScreen:call result:result];
    } else if([@"isEnableInspectScreen" isEqualToString:call.method]) {
        [self isEnableInspectScreen:call result:result];
     } else if([@"setEnableBlackBox" isEqualToString:call.method]) {
        [self setEnableBlackBox:call result:result];
    } else if([@"isEnableBlackBox" isEqualToString:call.method]) {
        [self isEnableBlackBox:call result:result];
    } else if([@"setShowFloatingReportButton" isEqualToString:call.method]) {
        [self setShowFloatingReportButton:call result:result];
    } else if([@"isShowFloatingReportButton" isEqualToString:call.method]) {
        [self isShowFloatingReportButton:call result:result];
    } else if([@"setInvokeShakeOnShakeDeviceEvent" isEqualToString:call.method]) {
        [self setInvokeShakeOnShakeDeviceEvent:call result:result];
    } else if([@"isInvokeShakeOnShakeDeviceEvent" isEqualToString:call.method]) {
        [self isInvokeShakeOnShakeDeviceEvent:call result:result];
    } else if([@"setShakingThreshold" isEqualToString:call.method]){
        [self setShakingThreshold:call result:result];
    } else if([@"getShakingThreshold" isEqualToString:call.method]){
        [self getShakingThreshold:call result:result];
    } else if([@"setInvokeShakeOnScreenshot" isEqualToString:call.method]) {
        [self setInvokeShakeOnScreenshot:call result:result];
    } else if([@"isInvokeShakeOnScreenshot" isEqualToString:call.method]) {
        [self isInvokeShakeOnScreenshot:call result:result];
    } else if([@"setScreenshotIncluded" isEqualToString:call.method]){
        [self setScreenshotIncluded:call result:result];
    } else if([@"isScreenshotIncluded" isEqualToString:call.method]){
        [self isScreenshotIncluded:call result:result];
    } else if ([@"setShakeReportData" isEqualToString:call.method]) {
        [self setShakeReportData:call result:result];
    } else if ([@"silentReport" isEqualToString:call.method]) {
        [self silentReport:call result:result];
    } else if ([@"insertNetworkRequest" isEqualToString:call.method]) {
        [self insertNetworkRequest:call result:result];
    } else if ([@"insertNotificationEvent" isEqualToString:call.method]) {
        [self insertNotificationEvent:call result:result];
    } else if ([@"setMetadata" isEqualToString:call.method]) {
        [self setMetadata:call result:result];
    } else if ([@"log" isEqualToString:call.method]) {
        [self log:call result:result];
    } else if([@"setShowIntroMessage" isEqualToString:call.method]) {
        [self setShowIntroMessage:call result:result];
    } else if([@"isShowIntroMessage" isEqualToString:call.method]) {
        [self isShowIntroMessage:call result:result];
    } else if([@"setEnableEmailField" isEqualToString:call.method]) {
        [self setEnableEmailField:call result:result];
    } else if([@"isEnableEmailField" isEqualToString:call.method]) {
        [self isEnableEmailField:call result:result];
    } else if([@"setEmailField" isEqualToString:call.method]) {
        [self setEmailField:call result:result];
    } else if([@"getEmailField" isEqualToString:call.method]) {
        [self getEmailField:call result:result];
    } else if([@"setAutoVideoRecording" isEqualToString:call.method]) {
        [self setAutoVideoRecording:call result:result];
    } else if([@"isAutoVideoRecording" isEqualToString:call.method]) {
        [self isAutoVideoRecording:call result:result];
    } else if([@"setFeedbackTypeEnabled" isEqualToString:call.method]) {
        [self setFeedbackTypeEnabled:call result:result];
    }  else if([@"isFeedbackTypeEnabled" isEqualToString:call.method]) {
        [self isFeedbackTypeEnabled:call result:result];
    } else if([@"setFeedbackTypes" isEqualToString:call.method]) {
        [self setFeedbackTypes:call result:result];
    } else if([@"getFeedbackTypes" isEqualToString:call.method]) {
        [self getFeedbackTypes:call result:result];
    } else if([@"setConsoleLogsEnabled" isEqualToString:call.method]) {
        [self setConsoleLogsEnabled:call result:result];
    } else if([@"isConsoleLogsEnabled" isEqualToString:call.method]) {
        [self isConsoleLogsEnabled:call result:result];
    } else if([@"setSensitiveDataRedactionEnabled" isEqualToString:call.method]) {
        [self setSensitiveDataRedactionEnabled:call result:result];
    } else if([@"isSensitiveDataRedactionEnabled" isEqualToString:call.method]) {
        [self isSensitiveDataRedactionEnabled:call result:result];
    } else if([@"registerUser" isEqualToString:call.method]) {
        [self registerUser:call result:result];
    } else if([@"updateUserId" isEqualToString:call.method]) {
        [self updateUserId:call result:result];
    } else if([@"updateUserMetadata" isEqualToString:call.method]) {
        [self updateUserMetadata:call result:result];
    } else if([@"unregisterUser" isEqualToString:call.method]) {
        [self unregisterUser:result];
    } else if([@"showNotificationsSettings" isEqualToString:call.method]) {
        [self showNotificationsSettings:result];
    } else {
        result(FlutterMethodNotImplemented);
    }
}

- (void)start:(FlutterMethodCall*) call result:(FlutterResult)result {
    NSString *clientId = call.arguments[@"clientId"];
    NSString *clientSecret = call.arguments[@"clientSecret"];

    [self setPlatformInfo];

    [SHKShake startWithClientId:clientId clientSecret:clientSecret];
    [self startNotificationsEmitter];

    result(nil);
}

- (void)show:(FlutterMethodCall*) call result:(FlutterResult)result {
    NSString *shakeScreenArg = call.arguments[@"shakeScreen"];
    
    SHKShowOption showOption = [self mapToShowOption:shakeScreenArg];
    [SHKShake show:showOption];
    
    result(nil);
}

- (void)setEnabled:(FlutterMethodCall*) call result:(FlutterResult)result {
    BOOL shakeEnabled = [call.arguments[@"enabled"] boolValue];
    SHKShake.isPaused = !shakeEnabled;
    
    result(nil);
}

- (void)setEnableActivityHistory:(FlutterMethodCall*) call result:(FlutterResult)result {
    BOOL enableActivityHistory = [call.arguments[@"enabled"] boolValue];
    SHKShake.configuration.isActivityHistoryEnabled = enableActivityHistory;
    
    result(nil);
}

- (void)isEnableActivityHistory:(FlutterMethodCall*) call result:(FlutterResult)result {
    BOOL isEnableActivityHistory = SHKShake.configuration.isActivityHistoryEnabled;
    NSNumber *isActivityHistoryEnabledObj = [NSNumber numberWithBool:isEnableActivityHistory];
    
    result(isActivityHistoryEnabledObj);
}

- (void)setEnableInspectScreen:(FlutterMethodCall*) call result:(FlutterResult)result {
    BOOL enableInspectScreen = [call.arguments[@"enabled"] boolValue];
    SHKShake.configuration.isInspectScreenEnabled = enableInspectScreen;
    
    result(nil);
}

- (void)isEnableInspectScreen:(FlutterMethodCall*) call result:(FlutterResult)result {
    BOOL isEnableInspectScreen = SHKShake.configuration.isInspectScreenEnabled;
    NSNumber *isEnableInspectScreenObj = [NSNumber numberWithBool:isEnableInspectScreen];
    
    result(isEnableInspectScreenObj);
}

- (void)setEnableBlackBox:(FlutterMethodCall*) call result:(FlutterResult)result {
    BOOL enableBlackBox = [call.arguments[@"enabled"] boolValue];
    SHKShake.configuration.isBlackBoxEnabled = enableBlackBox;
    
    result(nil);
}

- (void)isEnableBlackBox:(FlutterMethodCall*) call result:(FlutterResult)result {
    BOOL isEnableBlackBox = SHKShake.configuration.isBlackBoxEnabled;
    NSNumber *isEnableBlackBoxObj = [NSNumber numberWithBool:isEnableBlackBox];
    
    result(isEnableBlackBoxObj);
}

- (void)setShowFloatingReportButton:(FlutterMethodCall*) call result:(FlutterResult)result {
    BOOL showFloatingReportButton = [call.arguments[@"enabled"] boolValue];
    SHKShake.configuration.isFloatingReportButtonShown = showFloatingReportButton;
    
    result(nil);
}

- (void)isShowFloatingReportButton:(FlutterMethodCall*) call result:(FlutterResult)result {
    BOOL isShowFloatingReportButton = SHKShake.configuration.isFloatingReportButtonShown;
    NSNumber *isShowFloatingReportButtonObj = [NSNumber numberWithBool:isShowFloatingReportButton];
    
    result(isShowFloatingReportButtonObj);
}

-(void)setInvokeShakeOnShakeDeviceEvent:(FlutterMethodCall*) call result:(FlutterResult)result {
    BOOL invokeShakeOnShakeDeviceEvent = [call.arguments[@"enabled"] boolValue];
    SHKShake.configuration.isInvokedByShakeDeviceEvent = invokeShakeOnShakeDeviceEvent;
   
    result(nil);
}

- (void)isInvokeShakeOnShakeDeviceEvent:(FlutterMethodCall*) call result:(FlutterResult)result {
    BOOL isInvokeShakeOnShakeDeviceEvent = SHKShake.configuration.isInvokedByShakeDeviceEvent;
    NSNumber *isInvokeShakeOnShakeDeviceEventObj = [NSNumber numberWithBool:isInvokeShakeOnShakeDeviceEvent];
   
    result(isInvokeShakeOnShakeDeviceEventObj);
}

-(void)getShakingThreshold:(FlutterMethodCall*) call result: (FlutterResult) result {
    int shakingThreshold = (int)(SHKShake.configuration.shakingThreshold);
    NSNumber *shakingThresholdObj = [NSNumber numberWithInt:shakingThreshold];
    
    result(shakingThresholdObj);
}

-(void)setShakingThreshold:(FlutterMethodCall*) call result: (FlutterResult) result {
    int shakingThreshold = [call.arguments[@"shakingThreshold"] intValue];
    SHKShake.configuration.shakingThreshold = shakingThreshold;

    result(nil);
}

-(void)setInvokeShakeOnScreenshot:(FlutterMethodCall*) call result:(FlutterResult) result {
    BOOL invokeShakeOnScreenshot = [call.arguments[@"enabled"] boolValue];
    SHKShake.configuration.isInvokedByScreenshot = invokeShakeOnScreenshot;
   
    result(nil);
}

- (void)isInvokeShakeOnScreenshot:(FlutterMethodCall*) call result:(FlutterResult)result {
    BOOL isInvokeShakeOnScreenshot = SHKShake.configuration.isInvokedByScreenshot;
    NSNumber *isInvokeShakeOnScreenshotObj = [NSNumber numberWithBool:isInvokeShakeOnScreenshot];
   
    result(isInvokeShakeOnScreenshotObj);
}

-(void)isScreenshotIncluded:(FlutterMethodCall*) call result:(FlutterResult) result {
    BOOL isScreenshotIncluded = SHKShake.configuration.isScreenshotIncluded;
    NSNumber *isScreenshotIncludedObj = [NSNumber numberWithBool:isScreenshotIncluded];

    result(isScreenshotIncludedObj);
}

- (void)setScreenshotIncluded:(FlutterMethodCall*) call result:(FlutterResult) result {
    BOOL screenshotIncluded = [call.arguments[@"enabled"] boolValue];
    SHKShake.configuration.isScreenshotIncluded = screenshotIncluded;

    result(nil);
}

- (void)setShakeReportData:(FlutterMethodCall*) call result:(FlutterResult) result {
    NSArray* files = call.arguments[@"shakeFiles"];

    SHKShake.onPrepareReportData = ^NSArray<SHKShakeFile *> * _Nonnull {
        NSMutableArray<SHKShakeFile*> *shakeFiles = [self mapToShakeFiles:files];
        return shakeFiles;
    };

    result(nil);
}

- (void)silentReport:(FlutterMethodCall*) call result:(FlutterResult) result {
    NSString *description = call.arguments[@"description"];
    NSArray *files = call.arguments[@"shakeFiles"];
    NSDictionary *configurationMap = call.arguments[@"configuration"];
    
    NSArray<SHKShakeFile *> * (^fileAttachBlock)(void) = ^NSArray<SHKShakeFile *> *(void) {
        NSMutableArray <SHKShakeFile*> *shakeFiles = [self mapToShakeFiles:files];
        return shakeFiles;
    };

    SHKShakeReportConfiguration* conf = [self mapToConfiguration:configurationMap];

    [SHKShake silentReportWithDescription:description fileAttachBlock:fileAttachBlock reportConfiguration:conf];
    
    result(nil);
}

- (void)insertNetworkRequest:(FlutterMethodCall*) call result:(FlutterResult) result {
    NSDictionary *requestDict = call.arguments[@"networkRequest"];

    NSDictionary* networkRequest = [self mapToNetworkRequest:requestDict];
    [self insertRNNetworkRequest:networkRequest];

    result(nil);
}

- (void)insertNotificationEvent:(FlutterMethodCall*) call result:(FlutterResult) result {
    NSDictionary *notificationDict = call.arguments[@"notificationEvent"];

    NSDictionary* notificationEvent = [self mapToNotificationEvent:notificationDict];
    [self insertRNNotificationEvent:notificationEvent];

    result(nil);
}

- (void)setMetadata:(FlutterMethodCall*) call result:(FlutterResult) result {
    NSString* key = call.arguments[@"key"];
    NSString* value = call.arguments[@"value"];

    [SHKShake setMetadataWithKey: key value: value];

    result(nil);
}

- (void)log:(FlutterMethodCall*) call result:(FlutterResult) result {
    NSString* logLevelStr = call.arguments[@"level"];
    NSString* message = call.arguments[@"message"];

    LogLevel logLevel = [self mapToLogLevel:logLevelStr];
    [SHKShake logWithLevel: logLevel message: message];

    result(nil);
}

- (void)setShowIntroMessage:(FlutterMethodCall*) call result:(FlutterResult) result {
    BOOL showIntroMessage = [call.arguments[@"enabled"] boolValue];
    SHKShake.configuration.setShowIntroMessage = showIntroMessage;
    result(nil);
}

-(void)isShowIntroMessage:(FlutterMethodCall*) call result:(FlutterResult)result {
    BOOL isShowIntroMessage = SHKShake.configuration.setShowIntroMessage;
    NSNumber *isShowIntroMessageObj = [NSNumber numberWithBool:isShowIntroMessage];
    result(isShowIntroMessageObj);
}

- (void)setEnableEmailField:(FlutterMethodCall*) call result:(FlutterResult) result {
    BOOL enableEmailField = [call.arguments[@"enabled"] boolValue];
    SHKShake.configuration.isEmailFieldEnabled = enableEmailField;
    result(nil);
}

- (void)isEnableEmailField:(FlutterMethodCall*) call result:(FlutterResult)result {
    BOOL isEnableEmailField = SHKShake.configuration.isEmailFieldEnabled;
    NSNumber *isEnableEmailFieldObj = [NSNumber numberWithBool:isEnableEmailField];
    result(isEnableEmailFieldObj);
}

- (void)setEmailField:(FlutterMethodCall*) call result:(FlutterResult) result {
    NSString* email = call.arguments[@"email"];
    if (email == (id)[NSNull null]) email = nil;
    SHKShake.configuration.emailField = email;
    result(nil);
}

- (void)getEmailField:(FlutterMethodCall*) call result:(FlutterResult)result {
    NSString* email = SHKShake.configuration.emailField;
    result(email);
}

- (void)setAutoVideoRecording:(FlutterMethodCall*) call result:(FlutterResult) result {
    BOOL autoVideoRecording = [call.arguments[@"enabled"] boolValue];
    SHKShake.configuration.isAutoVideoRecordingEnabled = autoVideoRecording;
    result(nil);
}

- (void)isAutoVideoRecording:(FlutterMethodCall*) call result:(FlutterResult)result {
    BOOL isAutoVideoRecording = SHKShake.configuration.isAutoVideoRecordingEnabled;
    NSNumber *isAutoVideoRecordingObj = [NSNumber numberWithBool:isAutoVideoRecording];
    result(isAutoVideoRecordingObj);
}

- (void)setFeedbackTypeEnabled:(FlutterMethodCall*) call result:(FlutterResult) result {
    BOOL isFeedbackTypeEnabled = [call.arguments[@"enabled"] boolValue];
    SHKShake.configuration.isFeedbackTypeEnabled = isFeedbackTypeEnabled;

    result(nil);
}

- (void)isFeedbackTypeEnabled:(FlutterMethodCall*) call result:(FlutterResult)result {
    BOOL isFeedbackTypeEnabled = SHKShake.configuration.isFeedbackTypeEnabled;
    NSNumber *isFeedbackTypeEnabledObj = [NSNumber numberWithBool:isFeedbackTypeEnabled];

    result(isFeedbackTypeEnabledObj);
}

- (void)setFeedbackTypes:(FlutterMethodCall*) call result:(FlutterResult) result {
    NSArray *feedbackTypesArray = call.arguments[@"feedbackTypes"];
    
    NSMutableArray<SHKFeedbackEntry *> *feedbackTypes = [self mapArrayToFeedbackTypes:feedbackTypesArray];
    [SHKShake setFeedbackTypes:feedbackTypes];
    
    result(nil);
}

- (void)getFeedbackTypes:(FlutterMethodCall*) call result:(FlutterResult)result {
    NSArray<SHKFeedbackEntry *> *feedbackTypes = [SHKShake getFeedbackTypes];
    NSArray<NSDictionary *> *feedbackTypesArray = [self mapFeedbackTypesToArray:feedbackTypes];

    result(feedbackTypesArray);
}

- (void)setConsoleLogsEnabled:(FlutterMethodCall*) call result:(FlutterResult) result {
    BOOL isConsoleLogsEnabled = [call.arguments[@"enabled"] boolValue];
    SHKShake.configuration.isConsoleLogsEnabled = isConsoleLogsEnabled;

    result(nil);
}

- (void)isConsoleLogsEnabled:(FlutterMethodCall*) call result:(FlutterResult)result {
    BOOL isConsoleLogsEnabled = SHKShake.configuration.isConsoleLogsEnabled;
    NSNumber *isConsoleLogsEnabledObj = [NSNumber numberWithBool:isConsoleLogsEnabled];

    result(isConsoleLogsEnabledObj);
}

- (void)setSensitiveDataRedactionEnabled:(FlutterMethodCall*) call result:(FlutterResult) result {
    BOOL isSensitiveDataRedactionEnabled = [call.arguments[@"enabled"] boolValue];
    SHKShake.configuration.isSensitiveDataRedactionEnabled = isSensitiveDataRedactionEnabled;

    result(nil);
}

- (void)isSensitiveDataRedactionEnabled:(FlutterMethodCall*) call result:(FlutterResult)result {
    BOOL isSensitiveDataRedactionEnabled = SHKShake.configuration.isSensitiveDataRedactionEnabled;
    NSNumber *isSensitiveDataRedactionEnabledObj = [NSNumber numberWithBool:isSensitiveDataRedactionEnabled];

    result(isSensitiveDataRedactionEnabledObj);
}

- (void)registerUser:(FlutterMethodCall*) call result:(FlutterResult) result {
    NSString *userId = call.arguments[@"userId"];
    [SHKShake registerUserWithUserId:userId];
    
    result(nil);
}

- (void)updateUserId:(FlutterMethodCall*) call result:(FlutterResult) result {
    NSString *userId = call.arguments[@"userId"];
    [SHKShake updateUserId:userId];
    
    result(nil);
}

- (void)updateUserMetadata:(FlutterMethodCall*) call result:(FlutterResult) result {
    NSDictionary *metadata = call.arguments[@"metadata"];
    [SHKShake updateUserMetadata:metadata];
   
    result(nil);
}

- (void)unregisterUser:(FlutterResult) result {
    [SHKShake unregisterUser];

    result(nil);
}

- (void)startNotificationsEmitter {
    SHKShake.notificationEventsFilter = ^SHKNotificationEventEditor *(SHKNotificationEventEditor * notificationEvent) {
        NSDictionary* notificationDict = [self notificationToMap:notificationEvent];
        [channel invokeMethod:@"onNotificationReceived" arguments:notificationDict];

        return nil;
    };
}

- (void)showNotificationsSettings:(FlutterResult)result {
    // Method used just on Android

    result(nil);
}

// Mappers
- (LogLevel)mapToLogLevel:(NSString*)logLevelStr {
    LogLevel logLevel = LogLevelInfo;

    if ([logLevelStr isEqualToString:@"verbose"])
        logLevel = LogLevelVerbose;
    if ([logLevelStr isEqualToString:@"debug"])
        logLevel = LogLevelDebug;
    if ([logLevelStr isEqualToString:@"info"])
        logLevel = LogLevelInfo;
    if ([logLevelStr isEqualToString:@"warn"])
        logLevel = LogLevelWarn;
    if ([logLevelStr isEqualToString:@"error"])
        logLevel = LogLevelError;

    return logLevel;
}

- (SHKShowOption)mapToShowOption:(NSString*)showOptionStr
{
    SHKShowOption showOption = SHKShowOptionHome;

    if ([showOptionStr isEqualToString:@"home"])
        showOption = SHKShowOptionHome;
    if ([showOptionStr isEqualToString:@"newTicket"])
        showOption = SHKShowOptionNew;

    return showOption;
}

- (NSMutableArray<SHKShakeFile*>*)mapToShakeFiles:(nonnull NSArray*)files {
    NSMutableArray<SHKShakeFile*>* shakeFiles = [NSMutableArray array];
    for(int i = 0; i < [files count]; i++) {
        NSDictionary* file = [files objectAtIndex:i];
        NSString* path = [file objectForKey:@"path"];
        NSString* name = [file objectForKey:@"name"];

        NSURL* url = [[NSURL alloc] initFileURLWithPath: path];
        SHKShakeFile* attachedFile = [[SHKShakeFile alloc] initWithName:name andFileURL:url];

        if (attachedFile != nil) {
            [shakeFiles addObject:attachedFile];
        }
    }
    return shakeFiles;
}

- (NSMutableArray<SHKFeedbackEntry*>*)mapArrayToFeedbackTypes:(NSArray *)feedbackTypesArray
{
    if (feedbackTypesArray == nil) return nil;

    NSMutableArray<SHKFeedbackEntry*>* feedbackTypes = [NSMutableArray array];
    for(int i = 0; i < [feedbackTypesArray count]; i++) {
        NSDictionary *feedbackTypeDic = [feedbackTypesArray objectAtIndex:i];
        NSString *title = [feedbackTypeDic objectForKey:@"title"];
        NSString *tag = [feedbackTypeDic objectForKey:@"tag"];
        NSString *icon = [feedbackTypeDic objectForKey:@"icon"];

        UIImage *image = [UIImage imageNamed:icon];
        SHKFeedbackEntry *feedbackType = [SHKFeedbackEntry entryWithTitle:title andTag:tag icon:image];

        if (feedbackType != nil) {
            [feedbackTypes addObject:feedbackType];
        }
    }
    return feedbackTypes;
}

- (NSArray<NSDictionary*>*)mapFeedbackTypesToArray:(NSArray<SHKFeedbackEntry *> *)feedbackTypes
{
    if (feedbackTypes == nil) return nil;

    NSMutableArray<NSDictionary*>* feedbackTypesArray = [NSMutableArray array];
    for(int i = 0; i < [feedbackTypes count]; i++) {
        SHKFeedbackEntry *feedbackType = [feedbackTypes objectAtIndex:i];

        NSDictionary *feedbackTypeDic = [[NSDictionary alloc] init];
        feedbackTypeDic = @{
            @"title": feedbackType.title,
            @"tag": feedbackType.tag,
            @"icon": @""
        };

        if (feedbackTypeDic != nil) {
            [feedbackTypesArray addObject:feedbackTypeDic];
        }
    }
    return feedbackTypesArray;
}

- (SHKShakeReportConfiguration*)mapToConfiguration:(nonnull NSDictionary*)configurationDic {
    BOOL includesBlackBoxData = [[configurationDic objectForKey:@"blackBoxData"] boolValue];
    BOOL includesActivityHistoryData = [[configurationDic objectForKey:@"activityHistoryData"] boolValue];
    BOOL includesScreenshotImage = [[configurationDic objectForKey:@"screenshot"] boolValue];
    BOOL showsToastMessageOnSend = [[configurationDic objectForKey:@"showReportSentMessage"] boolValue];

    SHKShakeReportConfiguration *reportConfiguration = [[SHKShakeReportConfiguration alloc] init];
    reportConfiguration.includesBlackBoxData = includesBlackBoxData;
    reportConfiguration.includesActivityHistoryData = includesActivityHistoryData;
    reportConfiguration.includesScreenshotImage = includesScreenshotImage;
    reportConfiguration.showsToastMessageOnSend = showsToastMessageOnSend;

    return reportConfiguration;
}

- (NSDictionary*)mapToNetworkRequest:(nonnull NSDictionary*)requestDict {
    NSDictionary *networkRequest = [[NSDictionary alloc] init];
    NSData *data = [requestDict[@"requestBody"] dataUsingEncoding:NSUTF8StringEncoding];
    networkRequest = @{
        @"url": requestDict[@"url"],
        @"method": requestDict[@"method"],
        @"responseBody": requestDict[@"responseBody"],
        @"statusCode": requestDict[@"status"],
        @"requestBody": data,
        @"requestHeaders": requestDict[@"requestHeaders"],
        @"duration": requestDict[@"duration"],
        @"responseHeaders": requestDict[@"responseHeaders"],
        @"timestamp": requestDict[@"timestamp"]
    };
    return networkRequest;
}

- (NSDictionary*)mapToNotificationEvent:(nonnull NSDictionary*)notificationDict {
    NSDictionary *notificationEvent = [[NSDictionary alloc] init];
    notificationEvent = @{
        @"id": (notificationDict[@"id"] ?: @""),
        @"title": (notificationDict[@"title"] ?: @""),
        @"description": (notificationDict[@"description"] ?: @"")
    };
    return notificationEvent;
}

- (NSDictionary*)notificationToMap:(nonnull SHKNotificationEventEditor*)notification {
    NSDictionary *notificationDict = [[NSDictionary alloc] init];
    notificationDict = @{
        @"id": (notification.identifier ?: @""),
        @"title": (notification.title ?: @""),
        @"description": (notification.description ?: @"")
    };
    return notificationDict;
}

// Private
- (void)setPlatformInfo {
    NSDictionary *shakeInfo = @{ @"platform": @"Flutter", @"sdkVersion": @"15.0.0" };
    [SHKShake performSelector:sel_getUid(@"_setPlatformAndSDKVersion:".UTF8String) withObject:shakeInfo];
}

- (void)insertRNNotificationEvent:(nonnull NSDictionary*)notificationEvent {
    [SHKShake performSelector:sel_getUid(@"_reportNotification:".UTF8String) withObject:notificationEvent];
}

- (void)insertRNNetworkRequest:(nonnull NSDictionary*)networkRequest{
    [SHKShake performSelector:sel_getUid(@"_reportRequestCompleted:".UTF8String) withObject:networkRequest];
}
@end
