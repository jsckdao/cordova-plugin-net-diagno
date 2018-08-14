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
    NSDictionary *dict = @{ @"type":@"finished",@"out": logInfo };
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:dict];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:currentCommand.callbackId];
    [netDiagnoService stopNetDialogsis];
}


- (void)netDiagnosisDidStarted {
    NSDictionary *dict = @{ @"type":@"start" };
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:dict];
    pluginResult.keepCallback = [NSNumber numberWithInt:1];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:currentCommand.callbackId];
}


- (void)netDiagnosisStepInfo:(NSString *)stepInfo {
    NSDictionary *dict = @{ @"type":@"step",@"out": stepInfo };
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:dict];
    pluginResult.keepCallback = [NSNumber numberWithInt:1];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:currentCommand.callbackId];
}

@end