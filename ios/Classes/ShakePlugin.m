#import "ShakePlugin.h"
#if __has_include(<shake_flutter/shake_flutter-Swift.h>)
#import <shake_flutter/shake_flutter-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "shake_flutter-Swift.h"
#endif

@implementation ShakePlugin

+(void) initialize {
    if(self == [ShakePlugin class]) {
        NSDictionary *platformAndSdkVersionDict = @{
            @"platform": @"Flutter",
            @"sdkVersion": @"10.0.0"
        };
        NSNumber *disableDueToRN = @YES;
        [SHKShake performSelector:sel_getUid(@"_setNetworkRequestReporterDisabledDueToRN:".UTF8String) withObject:disableDueToRN];
        [SHKShake performSelector:sel_getUid(@"_setPlatformAndSDKVersion:".UTF8String) withObject:platformAndSdkVersionDict];
    }

}
-(instancetype)initWithMessenger:(nonnull NSObject<FlutterBinaryMessenger> *)messenger {
    self = [super init];
    return self;
}
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    id<FlutterBinaryMessenger> messenger = [registrar messenger];
    FlutterMethodChannel *channel = [FlutterMethodChannel methodChannelWithName:@"shake" binaryMessenger:messenger];
    ShakePlugin *instance = [[ShakePlugin alloc] initWithMessenger:messenger];
    [registrar addMethodCallDelegate:instance channel:channel];
}
-(void)handleMethodCall:(FlutterMethodCall *)call result:(FlutterResult)result {
    
    if([@"start" isEqualToString:call.method]) {
        [self start:result];
    } else if([@"show" isEqualToString:call.method]) {
        [self show:result];
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
    } else if([@"setInvokeShakeOnScreenshot" isEqualToString:call.method]) {
        [self setInvokeShakeOnScreenshot:call result:result];
    } else if([@"isInvokeShakeOnScreenshot" isEqualToString:call.method]) {
        [self isInvokeShakeOnScreenshot:call result:result];
    } else if ([@"setShakeReportData" isEqualToString:call.method]) {
        [self setShakeReportData:call result:result];
    } else if ([@"silentReport" isEqualToString:call.method]) {
        [self silentReport:call result:result];
    } else if ([@"insertNetworkRequest" isEqualToString:call.method]) {
        [self insertNetworkRequest:call result:result];
    } else {
        result(FlutterMethodNotImplemented);
    }
}
- (void)start:(FlutterResult)result {
    [SHKShake start];
    result(nil);
}
- (void)show:(FlutterResult)result {
    [SHKShake show];
    result(nil);
}
-(void)setEnabled:(FlutterMethodCall*) call result:(FlutterResult)result {
    BOOL shakeEnabled = [call.arguments[@"enabled"] boolValue];
    SHKShake.isPaused = !shakeEnabled;
    result(nil);
}
-(void)setEnableActivityHistory:(FlutterMethodCall*) call result:(FlutterResult)result {
    BOOL enableActivityHistory = [call.arguments[@"enabled"] boolValue];
    SHKShake.configuration.isActivityHistoryEnabled = enableActivityHistory;
    result(nil);
}
-(void)isEnableActivityHistory:(FlutterMethodCall*) call result:(FlutterResult)result {
    BOOL isEnableActivityHistory = SHKShake.configuration.isActivityHistoryEnabled;
    NSNumber *isActivityHistoryEnabledObj = [NSNumber numberWithBool:isEnableActivityHistory];
    result(isActivityHistoryEnabledObj);
}
-(void)setEnableInspectScreen:(FlutterMethodCall*) call result:(FlutterResult)result {
    BOOL enableInspectScreen = [call.arguments[@"enabled"] boolValue];
    SHKShake.configuration.isInspectScreenEnabled = enableInspectScreen;
    result(nil);
}
-(void)isEnableInspectScreen:(FlutterMethodCall*) call result:(FlutterResult)result {
    BOOL isEnableInspectScreen = SHKShake.configuration.isInspectScreenEnabled;
    NSNumber *isEnableInspectScreenObj = [NSNumber numberWithBool:isEnableInspectScreen];
    result(isEnableInspectScreenObj);
}
-(void)setEnableBlackBox:(FlutterMethodCall*) call result:(FlutterResult)result {
    BOOL enableBlackBox = [call.arguments[@"enabled"] boolValue];
    SHKShake.configuration.isBlackBoxEnabled = enableBlackBox;
    result(nil);
}
-(void)isEnableBlackBox:(FlutterMethodCall*) call result:(FlutterResult)result {
    BOOL isEnableBlackBox = SHKShake.configuration.isBlackBoxEnabled;
    NSNumber *isEnableBlackBoxObj = [NSNumber numberWithBool:isEnableBlackBox];
    result(isEnableBlackBoxObj);
}
-(void)setShowFloatingReportButton:(FlutterMethodCall*) call result:(FlutterResult)result {
    BOOL showFloatingReportButton = [call.arguments[@"enabled"] boolValue];
    SHKShake.configuration.isFloatingReportButtonShown = showFloatingReportButton;
    result(nil);
}
-(void)isShowFloatingReportButton:(FlutterMethodCall*) call result:(FlutterResult)result {
    BOOL isShowFloatingReportButton = SHKShake.configuration.isFloatingReportButtonShown;
    NSNumber *isShowFloatingReportButtonObj = [NSNumber numberWithBool:isShowFloatingReportButton];
    result(isShowFloatingReportButtonObj);
}
-(void)setInvokeShakeOnShakeDeviceEvent:(FlutterMethodCall*) call result:(FlutterResult)result {
    BOOL invokeShakeOnShakeDeviceEvent = [call.arguments[@"enabled"] boolValue];
    SHKShake.configuration.isInvokedByShakeDeviceEvent = invokeShakeOnShakeDeviceEvent;
    result(nil);
}
-(void)isInvokeShakeOnShakeDeviceEvent:(FlutterMethodCall*) call result:(FlutterResult)result {
    BOOL isInvokeShakeOnShakeDeviceEvent = SHKShake.configuration.isInvokedByShakeDeviceEvent;
    NSNumber *isInvokeShakeOnShakeDeviceEventObj = [NSNumber numberWithBool:isInvokeShakeOnShakeDeviceEvent];
    result(isInvokeShakeOnShakeDeviceEventObj);
}
-(void)setInvokeShakeOnScreenshot:(FlutterMethodCall*) call result:(FlutterResult) result {
    BOOL invokeShakeOnScreenshot = [call.arguments[@"enabled"] boolValue];
    SHKShake.configuration.isInvokedByScreenshot = invokeShakeOnScreenshot;
    result(nil);
}
-(void)isInvokeShakeOnScreenshot:(FlutterMethodCall*) call result:(FlutterResult)result {
    BOOL isInvokeShakeOnScreenshot = SHKShake.configuration.isInvokedByScreenshot;
    NSNumber *isInvokeShakeOnScreenshotObj = [NSNumber numberWithBool:isInvokeShakeOnScreenshot];
    result(isInvokeShakeOnScreenshotObj);
}
-(void)setShakeReportData:(FlutterMethodCall*) call result:(FlutterResult) result {
    NSArray* files = call.arguments[@"shakeFiles"];
    NSString* quickFacts = call.arguments[@"quickFacts"];

    NSMutableArray <SHKShakeFile *> *shakeFiles = [NSMutableArray array];
    for(int i = 0; i < [files count]; i++) {
        NSDictionary *file = [files objectAtIndex:i];
        NSString *path = [file objectForKey:@"path"];
        NSArray *name = [file objectForKey:@"name"];

        NSURL *url = [[NSURL alloc] initFileURLWithPath: path];
        SHKShakeFile *attachedFile = [[SHKShakeFile alloc] initWithName:name andFileURL:url];

        [shakeFiles addObject:attachedFile];
    }

    SHKShake.onPrepareReportData = ^SHKShakeReportData *_Nonnull(SHKShakeReportData *_Nonnull reportData) {
      reportData.quickFacts = quickFacts;
      reportData.attachedFiles = [NSArray arrayWithArray:shakeFiles];
      return reportData;
    };

    result(nil);
}
-(void)silentReport:(FlutterMethodCall*) call result:(FlutterResult) result {
    NSString * description = call.arguments[@"description"];
    NSArray * files = call.arguments[@"shakeFiles"];
    NSString * quickFacts = call.arguments[@"quickFacts"];
    NSDictionary * configurationMap = call.arguments[@"configuration"];

    BOOL includesBlackBoxData = [[configurationMap objectForKey:@"blackBoxData"] boolValue];
    BOOL includesActivityHistoryData = [[configurationMap objectForKey:@"activityHistoryData"] boolValue];
    BOOL includesScreenshotImage = [[configurationMap objectForKey:@"screenshot"] boolValue];
    BOOL showsToastMessageOnSend = [[configurationMap objectForKey:@"showReportSentMessage"] boolValue];

    SHKShakeReportConfiguration *reportConfiguration = [[SHKShakeReportConfiguration alloc] init];
    reportConfiguration.includesBlackBoxData = includesBlackBoxData;
    reportConfiguration.includesActivityHistoryData = includesActivityHistoryData;
    reportConfiguration.includesScreenshotImage = includesScreenshotImage;
    reportConfiguration.showsToastMessageOnSend = showsToastMessageOnSend;

    NSMutableArray <SHKShakeFile *> *shakeFiles = [NSMutableArray array];
    for(int i = 0; i < [files count]; i++) {
        NSDictionary *file = [files objectAtIndex:i];
        NSString *path = [file objectForKey:@"path"];
        NSArray *name = [file objectForKey:@"name"];

        NSURL *url = [[NSURL alloc] initFileURLWithPath: path];
        SHKShakeFile *attachedFile = [[SHKShakeFile alloc] initWithName:name andFileURL:url];

        [shakeFiles addObject:attachedFile];
      }

    SHKShakeReportData *reportData = [[SHKShakeReportData alloc] init];
    reportData.bugDescription = description;
    reportData.quickFacts = quickFacts;
    reportData.attachedFiles = [NSArray arrayWithArray:shakeFiles];

    [SHKShake silentReportWithReportData:reportData reportConfiguration:reportConfiguration];

    result(nil);
}
-(void)insertNetworkRequest:(FlutterMethodCall*) call result:(FlutterResult) result {
    NSDictionary *dict = [[NSDictionary alloc] init];
    NSData *data = [request[@"requestBody"] dataUsingEncoding:NSUTF8StringEncoding];
    dict = @{
        @"url": call.arguments[@"url"],
        @"method": call.arguments[@"method"],
        @"responseBody": call.arguments[@"description"],
        @"statusCode": call.arguments[@"description"],
        @"start": call.arguments[@"description"],
        @"contentType": call.arguments[@"description"],
        @"requestBody": data,
        @"requestHeaders": call.arguments[@"description"],
        @"duration": call.arguments[@"description"],
        @"responseHeaders": call.arguments[@"description"],
        @"timestamp": call.arguments[@"description"]
    };
    [SHKShake performSelector:sel_getUid(@"_reportRequestCompleted:".UTF8String) withObject:dict];

    result(nil);
}
@end
