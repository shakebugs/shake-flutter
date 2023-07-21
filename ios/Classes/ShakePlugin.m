#import "ShakePlugin.h"
#if __has_include(<shake_flutter/shake_flutter-Swift.h>)
#import <shake_flutter/shake_flutter-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "shake_flutter-Swift.h"
#endif

#import <CoreText/CoreText.h>

static FlutterMethodChannel *channel = nil;
static NSObject<FlutterPluginRegistrar> *pluginRegistrar = nil;

@implementation ShakePlugin

- (instancetype)initWithMessenger:(nonnull NSObject<FlutterBinaryMessenger> *)messenger {
    self = [super init];
    return self;
}

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    id<FlutterBinaryMessenger> messenger = [registrar messenger];
    channel = [FlutterMethodChannel methodChannelWithName:@"shake" binaryMessenger:messenger];
    pluginRegistrar = registrar;
    ShakePlugin *instance = [[ShakePlugin alloc] initWithMessenger:messenger];
    [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall *)call result:(FlutterResult)result {

    if([@"start" isEqualToString:call.method]) {
        [self start:call result:result];
    } else if([@"show" isEqualToString:call.method]) {
        [self show:call result:result];
    } else if([@"setShakeForm" isEqualToString:call.method]) {
        [self setShakeForm:call result:result];
    } else if([@"getShakeForm" isEqualToString:call.method]) {
        [self getShakeForm:call result:result];
    } else if([@"setShakeTheme" isEqualToString:call.method]) {
        [self setShakeTheme:call result:result];
    } else if([@"setHomeSubtitle" isEqualToString:call.method]) {
        [self setHomeSubtitle:call result:result];
    } else if([@"setUserFeedbackEnabled" isEqualToString:call.method]) {
        [self setUserFeedbackEnabled:call result:result];
    } else if([@"isUserFeedbackEnabled" isEqualToString:call.method]) {
        [self isUserFeedbackEnabled:call result:result];
    } else if([@"setEnableActivityHistory" isEqualToString:call.method]) {
        [self setEnableActivityHistory:call result:result];
    } else if([@"isEnableActivityHistory" isEqualToString:call.method]) {
        [self isEnableActivityHistory:call result:result];
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
    } else if([@"getDefaultScreen" isEqualToString:call.method]) {
        [self getDefaultScreen:call result:result];
    } else if([@"setDefaultScreen" isEqualToString:call.method]) {
        [self setDefaultScreen:call result:result];
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
    } else if([@"clearMetadata" isEqualToString:call.method]) {
        [self clearMetadata:result];
    } else if ([@"log" isEqualToString:call.method]) {
        [self log:call result:result];
    } else if([@"setShowIntroMessage" isEqualToString:call.method]) {
        [self setShowIntroMessage:call result:result];
    } else if([@"isShowIntroMessage" isEqualToString:call.method]) {
        [self isShowIntroMessage:call result:result];
    } else if([@"setAutoVideoRecording" isEqualToString:call.method]) {
        [self setAutoVideoRecording:call result:result];
    } else if([@"isAutoVideoRecording" isEqualToString:call.method]) {
        [self isAutoVideoRecording:call result:result];
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
    } else if([@"startUnreadMessagesEmitter" isEqualToString:call.method]) {
        [self startUnreadMessagesEmitter:result];
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

- (void)setShakeForm:(FlutterMethodCall*) call result:(FlutterResult) result {
    NSDictionary* shakeFormDict = call.arguments[@"shakeForm"];
    
    SHKForm* shakeForm = [self mapDicToShakeForm:shakeFormDict];
    SHKShake.configuration.form = shakeForm;
    
    result(nil);
}

- (void)getShakeForm:(FlutterMethodCall*) call result:(FlutterResult)result {
    SHKForm *shakeForm = SHKShake.configuration.form;
    NSDictionary *shakeFormDict = [self mapShakeFormToDict:shakeForm];
    
    result(shakeFormDict);
}

- (void)setShakeTheme:(FlutterMethodCall*) call result:(FlutterResult) result {
    NSDictionary *shakeThemeDict = call.arguments[@"shakeTheme"];
    
    SHKTheme *shakeTheme = [self mapDictToShakeTheme:shakeThemeDict];
    SHKShake.configuration.theme = shakeTheme;
    
    result(nil);
}

- (void)setHomeSubtitle:(FlutterMethodCall*) call result:(FlutterResult) result {
    NSString *subtitle = call.arguments[@"subtitle"];
    SHKShake.configuration.homeSubtitle = subtitle;
    
    result(nil);
}


- (void)show:(FlutterMethodCall*) call result:(FlutterResult)result {
    NSString* shakeScreenArg = call.arguments[@"shakeScreen"];
    
    SHKShowOption showOption = [self mapToShowOption:shakeScreenArg];
    [SHKShake show:showOption];
    
    result(nil);
}

- (void)setUserFeedbackEnabled:(FlutterMethodCall*) call result:(FlutterResult)result {
    BOOL enabled = [call.arguments[@"enabled"] boolValue];
    SHKShake.configuration.isUserFeedbackEnabled = enabled;

    result(nil);
}

- (void)isUserFeedbackEnabled:(FlutterMethodCall*) call result:(FlutterResult)result {
    BOOL isEnabled = SHKShake.configuration.isUserFeedbackEnabled;
    NSNumber *isEnabledObj = [NSNumber numberWithBool:isEnabled];

    result(isEnabledObj);
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

- (void)getDefaultScreen:(FlutterMethodCall*) call result:(FlutterResult)result {
    SHKShowOption showOption = SHKShake.configuration.defaultShowOption;
    NSString* showOptionStr = [self showOptionToString:showOption];
   
    result(showOptionStr);
}

-(void)setDefaultScreen:(FlutterMethodCall*) call result:(FlutterResult) result {
    NSString* showOptionsStr = call.arguments[@"shakeScreen"];
    SHKShowOption showOption = [self mapToShowOption:showOptionsStr];
    SHKShake.configuration.defaultShowOption = showOption;
   
    result(nil);
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

- (void)clearMetadata:(FlutterResult)result {
    [SHKShake clearMetadata];

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

- (void)startUnreadMessagesEmitter:(FlutterResult)result {
    SHKShake.unreadMessagesListener = ^(NSUInteger count) {
        [channel invokeMethod:@"onUnreadMessagesReceived" arguments:[NSNumber numberWithInt:(int)count]];
    };

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

- (NSString*)showOptionToString:(SHKShowOption)showOption
{
    if (showOption == SHKShowOptionHome)
        return @"home";
    if (showOption == SHKShowOptionNew)
        return @"newTicket";

    return @"newTicket";
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

- (SHKShakeReportConfiguration*)mapToConfiguration:(nonnull NSDictionary*)configurationDic {
    BOOL includesBlackBoxData = [[configurationDic objectForKey:@"blackBoxData"] boolValue];
    BOOL includesActivityHistoryData = [[configurationDic objectForKey:@"activityHistoryData"] boolValue];
    BOOL includesScreenshot = [[configurationDic objectForKey:@"screenshot"] boolValue];
    BOOL includesVideo = [[configurationDic objectForKey:@"video"] boolValue];
    BOOL showsToastMessageOnSend = [[configurationDic objectForKey:@"showReportSentMessage"] boolValue];

    SHKShakeReportConfiguration *reportConfiguration = [[SHKShakeReportConfiguration alloc] init];
    reportConfiguration.includesBlackBoxData = includesBlackBoxData;
    reportConfiguration.includesActivityHistoryData = includesActivityHistoryData;
    reportConfiguration.includesScreenshotImage = includesScreenshot;
    reportConfiguration.includesVideo = includesVideo;
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

- (SHKForm *)mapDicToShakeForm:(NSDictionary *)shakeFormDic
{
    if (shakeFormDic == nil) return nil;
    
    NSMutableArray *dictComponents = [shakeFormDic objectForKey:@"components"];
    if (dictComponents == nil) dictComponents = [NSMutableArray array];

    NSMutableArray<id<SHKFormItemProtocol>>* formComponents = [NSMutableArray array];
    
    for(int i = 0; i < [dictComponents count]; i++) {
        NSDictionary *component = [dictComponents objectAtIndex:i];

        NSString *type = [component objectForKey:@"type"];
        if ([type isEqualToString:@"title"]) {
            NSString *key = [component objectForKey:@"key"];
            NSString *label = [component objectForKey:@"label"];
            NSString *initialValue = [component objectForKey:@"initialValue"];
            BOOL required = [[component objectForKey:@"required"] boolValue];
            
            // NSNull causes crash
            if (key && [key isEqual:[NSNull null]]) key=nil;
            if (label && [label isEqual:[NSNull null]]) label=nil;
            if (initialValue && [initialValue isEqual:[NSNull null]]) initialValue=nil;
            
            [formComponents addObject:[[SHKTitle alloc] initWithKey:key label:label required:required initialValue:initialValue]];
        }
        if ([type isEqualToString:@"text_input"]) {
            NSString *key = [component objectForKey:@"key"];
            NSString *label = [component objectForKey:@"label"];
            NSString *initialValue = [component objectForKey:@"initialValue"];
            BOOL required = [[component objectForKey:@"required"] boolValue];
            
            // NSNull causes crash
            if (key && [key isEqual:[NSNull null]]) key=nil;
            if (label && [label isEqual:[NSNull null]]) label=nil;
            if (initialValue && [initialValue isEqual:[NSNull null]]) initialValue=nil;
            
            [formComponents addObject:[[SHKTextInput alloc] initWithKey:key label:label required:required initialValue:initialValue]];
        }
        if ([type isEqualToString:@"email"]) {
            NSString *key = [component objectForKey:@"key"];
            NSString *label = [component objectForKey:@"label"];
            NSString *initialValue = [component objectForKey:@"initialValue"];
            BOOL required = [[component objectForKey:@"required"] boolValue];
            
            // NSNull causes crash
            if (key && [key isEqual:[NSNull null]]) key=nil;
            if (label && [label isEqual:[NSNull null]]) label=nil;
            if (initialValue && [initialValue isEqual:[NSNull null]]) initialValue=nil;
            
            [formComponents addObject:[[SHKEmail alloc] initWithKey:key label:label required:required initialValue:initialValue]];
        }
        if ([type isEqualToString:@"picker"]) {
            NSString *key = [component objectForKey:@"key"];
            NSString *label = [component objectForKey:@"label"];
            NSArray *itemsArray = [component objectForKey:@"items"];
            
            // NSNull causes crash
            if (key && [key isEqual:[NSNull null]]) key=nil;
            if (label && [label isEqual:[NSNull null]]) label=nil;

            NSMutableArray<SHKPickerItem*>* items = [NSMutableArray array];
            for(int j = 0; j < [itemsArray count]; j++) {
                NSDictionary *arrayItem = [itemsArray objectAtIndex:j];
                
                NSString *key = [arrayItem objectForKey:@"key"];
                NSString *text = [arrayItem objectForKey:@"text"];
                NSString *icon = [arrayItem objectForKey:@"icon"];
                NSString *tag = [arrayItem objectForKey:@"tag"];
                
                // NSNull causes
                if (key && [key isEqual:[NSNull null]]) key=@"";
                if (text && [text isEqual:[NSNull null]]) text=@"";
                if (icon && [icon isEqual:[NSNull null]]) icon=nil;
                if (tag && [tag isEqual:[NSNull null]]) tag=nil;
                
                SHKPickerItem* item = [[SHKPickerItem alloc] initWithKey:key text:text icon:[self base64ToUIImage:icon] tag:tag];
                [items addObject:item];
            }
            
            [formComponents addObject:[[SHKPicker alloc] initWithKey:key label:label items:items]];
        }
        if ([type isEqualToString:@"attachments"]) {
            [formComponents addObject:SHKAttachments.new];
        }
        
        if ([type isEqualToString:@"inspect"]) {
            [formComponents addObject:SHKInspectButton.new];
        
        }
    }
    return [[SHKForm alloc] initWithItems:formComponents];
}

- (NSDictionary*)mapShakeFormToDict:(SHKForm*)shakeForm
{
    if (shakeForm == nil) return nil;

    NSMutableArray<NSDictionary*>* componentsArray = [NSMutableArray array];
    
    for(int i = 0; i < [shakeForm.items count]; i++) {
        id<SHKFormItemProtocol> item = [shakeForm.items objectAtIndex:i];
        
        if ([item isKindOfClass:[SHKTitle class]]) {
            SHKTitle *component = item;
            
            NSDictionary *dict = [[NSDictionary alloc] init];
            dict = @{
                @"type": @"title",
                @"key": component.key,
                @"label": component.label,
                @"initialValue": component.initialValue ?: @"",
                @"required": [NSNumber numberWithBool:component.required]
            };
            
            [componentsArray addObject:dict];
        }
        if ([item isKindOfClass:[SHKTextInput class]]) {
            SHKTextInput *component = item;
            
            NSDictionary *dict = [[NSDictionary alloc] init];
            dict = @{
                @"type": @"text_input",
                @"key": component.key,
                @"label": component.label,
                @"initialValue": component.initialValue ?: @"",
                @"required": [NSNumber numberWithBool:component.required]
            };
            
            [componentsArray addObject:dict];
        }

        if ([item isKindOfClass:[SHKEmail class]]) {
            SHKEmail *component = item;
            
            NSDictionary *dict = [[NSDictionary alloc] init];
            dict = @{
                @"type": @"email",
                @"key": component.key,
                @"label": component.label,
                @"initialValue": component.initialValue ?: @"",
                @"required": [NSNumber numberWithBool:component.required]
            };
            
            [componentsArray addObject:dict];
        }

        if ([item isKindOfClass:[SHKPicker class]]) {
            SHKPicker *component = item;
            
            NSMutableArray<NSDictionary*>* pickerItemsArray = [NSMutableArray array];
            for(int j = 0; j < [component.items count]; j++) {
                SHKPickerItem *pickerItem = [component.items objectAtIndex:j];
                
                NSDictionary *pickerItemDict = [[NSDictionary alloc] init];
                pickerItemDict = @{
                    @"key": component.key,
                    @"text": pickerItem.text,
                    @"icon": [self UIImageToBase64:pickerItem.icon] ?: [NSNull null],
                    @"tag": pickerItem.tag ?: [NSNull null],
                };
                
                [pickerItemsArray addObject:pickerItemDict];
            }
            

            NSDictionary *componentDict = [[NSDictionary alloc] init];
            componentDict = @{
                @"type": @"picker",
                @"key": component.key,
                @"label": component.label,
                @"items": pickerItemsArray
            };
            
            [componentsArray addObject:componentDict];
        }

        if ([item isKindOfClass:[SHKAttachments class]]) {
            NSDictionary *dict = [[NSDictionary alloc] init];
            dict = @{
                @"type": @"attachments",
            };
            
            [componentsArray addObject:dict];
        }
        if ([item isKindOfClass:[SHKInspectButton class]]) {
            NSDictionary *dict = [[NSDictionary alloc] init];
            dict = @{
                @"type": @"inspect",
            };
            
            [componentsArray addObject:dict];
        }
    }
    
    NSDictionary *shakeFormDict = [[NSDictionary alloc] init];
    shakeFormDict = @{@"components": componentsArray};
    
    return shakeFormDict;
}

- (SHKTheme*)mapDictToShakeTheme:(NSDictionary*)themeDict
{
    if (themeDict == nil) return nil;

    NSString *fontFamilyBold = [themeDict objectForKey:@"fontFamilyBold"];
    NSString *fontFamilyMedium = [themeDict objectForKey:@"fontFamilyMedium"];
    NSString *backgroundColor = [themeDict objectForKey:@"backgroundColor"];
    NSString *secondaryBackgroundColor = [themeDict objectForKey:@"secondaryBackgroundColor"];
    NSString *textColor = [themeDict objectForKey:@"textColor"];
    NSString *secondaryTextColor = [themeDict objectForKey:@"secondaryTextColor"];
    NSString *accentColor = [themeDict objectForKey:@"accentColor"];
    NSString *accentTextColor = [themeDict objectForKey:@"accentTextColor"];
    NSString *outlineColor = [themeDict objectForKey:@"outlineColor"];
    NSNumber *borderRadius = [themeDict objectForKey:@"borderRadius"];
    NSNumber *shadowRadius = [themeDict objectForKey:@"shadowRadius"];
    NSNumber *shadowOpacity = [themeDict objectForKey:@"shadowOpacity"];
    NSNumber *shadowOffsetWidth = [themeDict objectForKey:@"shadowOffsetWidth"];
    NSNumber *shadowOffsetHeight = [themeDict objectForKey:@"shadowOffsetHeight"];
    
    NSString *fontFamilyBoldValue = [fontFamilyBold isKindOfClass:[NSNull class]] ? nil : [self registerFontFromFlutterAssets:fontFamilyBold];
    NSString *fontFamilyMediumValue = [fontFamilyMedium isKindOfClass:[NSNull class]] ? nil : [self registerFontFromFlutterAssets:fontFamilyMedium];
    UIColor *backgroundColorValue = [backgroundColor isKindOfClass:[NSNull class]] ? nil : [self colorFromHexString:backgroundColor];
    UIColor *secondaryBackgroundColorValue = [secondaryBackgroundColor isKindOfClass:[NSNull class]] ? nil : [self colorFromHexString:secondaryBackgroundColor];
    UIColor *textColorValue = [textColor isKindOfClass:[NSNull class]] ? nil : [self colorFromHexString:textColor];
    UIColor *secondaryTextColorValue = [secondaryTextColor isKindOfClass:[NSNull class]] ? nil : [self colorFromHexString:secondaryTextColor];
    UIColor *accentColorValue = [accentColor isKindOfClass:[NSNull class]] ? nil : [self colorFromHexString:accentColor];
    UIColor *accentTextColorValue = [accentTextColor isKindOfClass:[NSNull class]] ? nil : [self colorFromHexString:accentTextColor];
    UIColor *outlineColorValue = [outlineColor isKindOfClass:[NSNull class]] ? nil : [self colorFromHexString:outlineColor];
    CGFloat borderRadiusValue = [borderRadius isKindOfClass:[NSNull class]] ? 11 : [borderRadius floatValue];
    CGFloat shadowRadiusValue = [shadowRadius isKindOfClass:[NSNull class]] ? 0 : [shadowRadius floatValue];
    CGFloat shadowOpacityValue = [shadowOpacity isKindOfClass:[NSNull class]] ? 0 : [shadowOpacity floatValue];
    CGFloat shadowOffsetWidthValue = [shadowOffsetWidth isKindOfClass:[NSNull class]] ? 0 : [shadowOffsetWidth floatValue];
    CGFloat shadowOffsetHeightValue = [shadowOffsetHeight isKindOfClass:[NSNull class]] ? 0 : [shadowOffsetHeight floatValue];
    
    return [[SHKTheme alloc] initWithFontFamilyMedium:fontFamilyMediumValue
                      fontFamilyBold:fontFamilyBoldValue
                      background:backgroundColorValue
                      secondaryBackground:secondaryBackgroundColorValue
                      textColor:textColorValue
                      secondaryTextColor:secondaryTextColorValue
                      brandAccentColor:accentColorValue
                      brandTextColor:accentTextColorValue
                      borderRadius:borderRadiusValue
                      outlineColor:outlineColorValue
                      shadowInfo:[[SHKShadowInfo alloc]initWithOffset:CGSizeMake(shadowOffsetWidthValue, shadowOffsetHeightValue)
                      opacity:shadowOpacityValue
                      radius:shadowRadiusValue
                      color:UIColor.blackColor]];
}

- (UIColor *)colorFromHexString:(NSString *)hexString {
    if (hexString == nil) return nil;
    
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}

- (NSString*)registerFontFromFlutterAssets:(NSString *)fontFilename {
    if (fontFilename == nil) return nil;
    
    NSString* fontName = [[fontFilename lastPathComponent] stringByDeletingPathExtension];
    NSString *fontKey = [pluginRegistrar lookupKeyForAsset:fontFilename];
    NSString *path = [[NSBundle mainBundle] pathForResource:fontKey ofType:nil];
    NSData *fontData = [NSData dataWithContentsOfFile:path];
    CGDataProviderRef dataProvider = CGDataProviderCreateWithCFData((CFDataRef)fontData);
    CGFontRef fontRef = CGFontCreateWithDataProvider(dataProvider);
    CFErrorRef errorRef = NULL;

    if (fontRef != NULL) {
        if (!CTFontManagerRegisterGraphicsFont(fontRef, &errorRef)) {
            CFStringRef errorDescription = CFErrorCopyDescription(errorRef);
            NSLog(@"Failed to register font: %@", errorDescription);
            CFRelease(errorDescription);
        }
        CGFontRelease(fontRef);
    }
    CGDataProviderRelease(dataProvider);

    return fontName;
}

- (UIImage*)base64ToUIImage:(NSString *)base64 {
    if (base64 == nil) return nil;

    NSUInteger paddedLength = base64.length + (4 - (base64.length % 4));
    NSString* correctBase64String = [base64 stringByPaddingToLength:paddedLength withString:@"=" startingAtIndex:0];
    NSData* data = [[NSData alloc]initWithBase64EncodedString:correctBase64String options:NSDataBase64DecodingIgnoreUnknownCharacters];
    return [UIImage imageWithData:data];
}

- (NSString *)UIImageToBase64:(UIImage *)image {
    if (image == nil) return nil;

    NSData *data = UIImagePNGRepresentation(image);
    NSString *base64String = [data base64EncodedStringWithOptions:0];
    return base64String;
}

// Private
- (void)setPlatformInfo {
    NSDictionary *shakeInfo = @{ @"platform": @"Flutter", @"sdkVersion": @"16.1.0" };
    [SHKShake performSelector:sel_getUid(@"_setPlatformAndSDKVersion:".UTF8String) withObject:shakeInfo];
}

- (void)insertRNNotificationEvent:(nonnull NSDictionary*)notificationEvent {
    [SHKShake performSelector:sel_getUid(@"_reportNotification:".UTF8String) withObject:notificationEvent];
}

- (void)insertRNNetworkRequest:(nonnull NSDictionary*)networkRequest{
    [SHKShake performSelector:sel_getUid(@"_reportRequestCompleted:".UTF8String) withObject:networkRequest];
}
@end
