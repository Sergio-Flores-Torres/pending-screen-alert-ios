//
//  UIViewController+ActivityInProgress.m
//  Pending Screen + Alert iOS
//
//  Created by Sergio Flores on 11/28/17.
//  Copyright © 2017 SAFT.Industries. All rights reserved.
//

#import "UIViewController+UxUtils.h"

@implementation UIViewController (UxUtils)

#define TAG_INDICATOR_OVERLAY 1000
#define APP_TITLE @"Title"
#define LBL_OK @"Ok"
#define LBL_INPROGRESS @"In progress..."

/*
 Shows a standard UIAlertController, with one default action, which currently does nothing, and returns to the calling UIViewController. If on iPad, it aligns the Alert to the calling View.
 
 Params:
 
 text - The message to show to the user.
 sender - The view to align the alert with.
 */
- (void) showStandardMessageAlertWithText: (NSString*) text withSender:(id) sender
{
    UIAlertController* alert = [UIAlertController
                                alertControllerWithTitle: APP_TITLE
                                message: text
                                preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction
                                    actionWithTitle:LBL_OK
                                    style:UIAlertActionStyleDefault
                                    handler:nil];
    
    [alert addAction:defaultAction];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        alert.popoverPresentationController.sourceView = (UIView*) sender;
        alert.popoverPresentationController.sourceRect = ((UIView*) sender).frame;
    }

    [self presentViewController:alert animated:YES completion:nil];
}

/*
 Shows a standard UIAlertController, with one default action, which pops the calling UIViewController. Useful to automatically close a screen after giving some info to the user.  If on iPad, it aligns the Alert to the calling View.
 
 Params:
 
 text - The message to show to the user.
 sender - The view to align the alert with.
 */
- (void) showPopVCMessageAlertWithText: (NSString*) text withSender:(id) sender
{
    UIAlertController* alert = [UIAlertController
                                alertControllerWithTitle: APP_TITLE
                                message: text
                                preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction
                                    actionWithTitle:LBL_OK
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction *action)
                                    {
                                        [self.navigationController popViewControllerAnimated:YES];
                                    }];
    
    [alert addAction:defaultAction];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        alert.popoverPresentationController.sourceView = (UIView*) sender;
        alert.popoverPresentationController.sourceRect = ((UIView*) sender).frame;
    }

    [self presentViewController:alert animated:YES completion:nil];
}


- (void) showPendingScreen
{
    UIView* areaView = [[UIApplication sharedApplication] keyWindow];
    UIView* overlayView = [[UIView alloc] initWithFrame:
                           CGRectMake(areaView.frame.origin.x,
                                      areaView.frame.origin.y,
                                      areaView.frame.size.width,
                                      areaView.frame.size.height)];
    overlayView.center = areaView.center;
    overlayView.alpha = 0;
    overlayView.backgroundColor = [UIColor blackColor];
    overlayView.tag = TAG_INDICATOR_OVERLAY;
    
    [areaView addSubview:overlayView];
    [areaView bringSubviewToFront:overlayView];
    
    
    [UIViewPropertyAnimator
          runningPropertyAnimatorWithDuration:0.5
                                        delay:0
                                      options: UIViewAnimationOptionCurveLinear
                                     animations:
                                     ^{
                                         overlayView.alpha = 0;
                                         overlayView.alpha = 0.5;
                                      }
                                     completion:nil];
    
    
    UIActivityIndicatorView* indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    indicatorView.center = overlayView.center;
    [indicatorView startAnimating];
    
    [overlayView addSubview:indicatorView];
    
    UILabel *indicatorLabel = [[UILabel alloc] init];
    
    [indicatorLabel setText: LBL_INPROGRESS];
    [indicatorLabel setTextAlignment:NSTextAlignmentCenter];
    [indicatorLabel setNumberOfLines:0];
    [indicatorLabel setFont: [UIFont systemFontOfSize:15]];
    [indicatorLabel setTextColor:[UIColor whiteColor]];
    [indicatorLabel sizeToFit];
    
    indicatorLabel.center  = CGPointMake(indicatorView.center.x, indicatorView.center.y + 30);
    
    [overlayView addSubview:indicatorLabel];
}

/*
 Locates the overlay view, identified by the TAG and destroys it.
 */
- (void) hidePendingScreen
{
    UIView* areaView = [[UIApplication sharedApplication] keyWindow];

    for (UIView *currentView in areaView.subviews)
    {
        if (currentView.tag == TAG_INDICATOR_OVERLAY)
            [currentView removeFromSuperview];
    }
}

// Call it from a given element in use, like a textField to make the keyboard go away.
- (IBAction) dismisKBFromField:(id)sender
{
    [sender resignFirstResponder];
}

// Call it from a ViewController to remove the keyboard, regardless of what screen element is in use.
-(void) dismisKBFromView:(id)sender
{
    [self.view endEditing:YES];
}

// Call it from viewDidLoad to let the user dismiss the keyboard by tapping in any empty space on the screen.
- (void) removeKeyboardFromBackground
{
    UITapGestureRecognizer* tapBackground = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismisKBFromView:)];
    [tapBackground setNumberOfTapsRequired:1];
    [self.view addGestureRecognizer:tapBackground];
}


@end
