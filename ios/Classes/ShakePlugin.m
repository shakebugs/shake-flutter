#import "ShakePlugin.h"
#if __has_include(<shake/shake-Swift.h>)
#import <shake/shake-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "shake-Swift.h"
#endif

@implementation ShakePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftShakePlugin registerWithRegistrar:registrar];
}
@end
