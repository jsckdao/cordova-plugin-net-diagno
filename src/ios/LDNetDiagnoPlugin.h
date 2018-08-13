#import <UIKit/UIKit.h>
#import <Cordova/CDVPlugin.h>
#import "LDNetDiagnoService.h"

@interface LDNetDiagnoPlugin :CDVPlugin <LDNetDiagnoServiceDelegate>
{
    CDVInvokedUrlCommand *currentCommand;
    LDNetDiagnoService *netDiagnoService;
}

- (void)execRouteCheck:(CDVInvokedUrlCommand*)command;

@end