//
//  UIViewController+ActivityInProgress.h
//  Pending Screen + Alert iOS
//
//  Created by Sergio Flores on 11/28/17.
//  Copyright © 2017 SAFT.Industries. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (UxUtils)

// Adding and removing the activityindicator
- (void) showPendingScreen;
- (void) hidePendingScreen;

// Showing UIActionAlerts
- (void) showStandardMessageAlertWithText: (NSString*) text withSender:(id) sender;
- (void) showPopVCMessageAlertWithText: (NSString*) text withSender:(id) sender;

// Common methods to dismiss the keyboard, to choose from, depending on circumstances.
- (IBAction) dismisKBFromField:(id)sender;
- (void) dismisKBFromView:(id)sender;
- (void) removeKeyboardFromBackground;

@end
