# pending-screen-alert-ios
An obj-category that can be added to any UIViewController to show a "pending activity" screen and standard message alerts.

DESCRIPTION

This Obj-Category encapsulates a few useful functions that are found in pretty much every iOS project, and can be easily added and modified as needed. To use the Category all you have to do is to add the files to your project, and add an import to the classes you want to call them from. Categories work by "extending" the original class, withour subclassing, so the imported methods can be called from [self], as shown in the example:

// MyViewController.m

...

- (void)viewDidLoad 
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self removeKeyboardFromBackground];
}

...

The functions are:

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

showPendingScreen works by adding a full screen view, that covers any active view and animates alpha, before adding and animating an activityindicator. 

See code comments for the specifics of the other functions.

Questions/Comments: sergio@saft.industries
http://saft.industries

MIT License. Use as you see fit, no warranties of any kind.

