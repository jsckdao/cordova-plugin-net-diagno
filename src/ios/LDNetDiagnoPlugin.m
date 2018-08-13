#import "LDNetDiagnoPlugin.h"
#import <Cordova/CDVPlugin.h>


@implementation LDNetDiagnoPlugin

- (void)execRouteCheck:(CDVInvokedUrlCommand*)command
{
    [self.commandDelegate runInBackground:^{
        NSString* targetDormain = [command.arguments objectAtIndex:0];
        netDiagnoService = [[LDNetDiagnoService alloc] initWithAppCode:@"test"
                                                                appName:@"网络诊断应用"
                                                            appVersion:@"1.0.0"
                                                                userID:@"test@test.com"
                                                            deviceID:nil
                                                                dormain: targetDormain
                                                            carrierName:nil
                                                        ISOCountryCode:nil
                                                    MobileCountryCode:nil
                                                        MobileNetCode:nil];

        currentCommand = command;
        netDiagnoService.delegate = self;
        [netDiagnoService startNetDiagnosis];
    }];
}

- (void)netDiagnosisDidEnd:(NSString *)logInfo {
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:logInfo];
    [netDiagnoService stopNetDialogsis];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:currentCommand.callbackId];
}


- (void)netDiagnosisDidStarted {

}


- (void)netDiagnosisStepInfo:(NSString *)stepInfo {
    
}

@end