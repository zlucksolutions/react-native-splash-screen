/**
 * SplashScreen
 * 启动屏
 * from：http://www.devio.org
 * Author:CrazyCodeBoy
 * GitHub:https://github.com/crazycodeboy
 * Email:crazycodeboy@gmail.com
 */

#import "RNSplashScreen.h"
#import <React/RCTBridge.h>

static bool waiting = true;
static bool addedJsLoadErrorObserver = false;
static UIView* loadingView = nil;

@implementation RNSplashScreen
- (dispatch_queue_t)methodQueue{
    return dispatch_get_main_queue();
}
RCT_EXPORT_MODULE(SplashScreen)

+ (void)show {
    if (!addedJsLoadErrorObserver) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(jsLoadError:) name:RCTJavaScriptDidFailToLoadNotification object:nil];
        addedJsLoadErrorObserver = true;
    }

    while (waiting) {
        NSDate* later = [NSDate dateWithTimeIntervalSinceNow:0.1];
        [[NSRunLoop mainRunLoop] runUntilDate:later];
    }
}

+ (void)showSplash:(NSString*)splashScreen inRootView:(UIView*)rootView {
    if (!loadingView) {
        loadingView = [[[NSBundle mainBundle] loadNibNamed:splashScreen owner:self options:nil] objectAtIndex:0];
        CGRect frame = rootView.frame;
        frame.origin = CGPointMake(0, 0);
        loadingView.frame = frame;
    }
    //Create image reference for the images
    UIImage *imageOne = [UIImage imageNamed:@"splash_image1.png"];
    UIImage *imageTwo = [UIImage imageNamed:@"splash_image2.png"];
    UIImage *imageThree = [UIImage imageNamed:@"splash_image3.png"];
    UIImage *imageFour = [UIImage imageNamed:@"splash_image4.png"];
    UIImage *imageFive = [UIImage imageNamed:@"splash_image5.png"];
    //Save in array
    NSArray* imagesArray = [NSArray arrayWithObjects:imageOne,imageTwo,imageThree,imageFour,imageFive, nil];
    //Select random image from array
    NSInteger *rIndex = arc4random() % (NSUInteger)(imagesArray.count);
    UIImage *randomImg = [imagesArray objectAtIndex:rIndex];
    //Create image view with selected image
    UIImageView *imgView = [[UIImageView alloc] initWithImage:randomImg];
    imgView.frame = CGRectMake(-10, 50, 415, 215);
    imgView.contentMode = UIViewContentModeScaleAspectFit;
    //Add the image view to the view
    [loadingView addSubview:imgView];
    [loadingView bringSubviewToFront:imgView];

    waiting = false;
    
    [rootView addSubview:loadingView];
}

+ (void)hide {
    if (waiting) {
        dispatch_async(dispatch_get_main_queue(), ^{
            waiting = false;
        });
    } else {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [loadingView removeFromSuperview];
        });
    }
}

+ (void) jsLoadError:(NSNotification*)notification
{
    // If there was an error loading javascript, hide the splash screen so it can be shown.  Otherwise the splash screen will remain forever, which is a hassle to debug.
    [RNSplashScreen hide];
}

RCT_EXPORT_METHOD(hide) {
    [RNSplashScreen hide];
}

RCT_EXPORT_METHOD(show) {
    [RNSplashScreen show];
}

@end
