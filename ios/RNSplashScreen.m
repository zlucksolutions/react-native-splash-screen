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

- (dispatch_queue_t)methodQueue {
    return dispatch_get_main_queue();
}

RCT_EXPORT_MODULE(SplashScreen)

+ (void)showSplashImage:(NSString *)splashScreen inRootView:(UIView *)rootView withData:(NSArray *)dataArray verticalOffset:(CGFloat)verticalOffset isFirstInstallSetIndex:(BOOL)isFirstInstallSetIndex isTextData:(BOOL)isTextData{

   if (!loadingView) {
        loadingView = [[[NSBundle mainBundle] loadNibNamed:splashScreen owner:self options:nil] objectAtIndex:0];
        CGRect frame = rootView.frame;
        frame.origin = CGPointMake(0, 0);
        loadingView.frame = frame;
    }
    // Check if it's the first install
    // BOOL isFirstInstall = [[NSUserDefaults standardUserDefaults] boolForKey:@"FirstInstall"];
    BOOL isFirstInstall = [RNSplashScreen isFirstTime];
    if (isFirstInstall && isFirstInstallSetIndex) {
        if(isTextData){
            // Display the first text from the array
            NSString *firstText = [dataArray objectAtIndex:0];
            [self displaySplashText:firstText inRootView:rootView verticalOffset:verticalOffset];
        }else{ 
            // Display the first Image from the array
            UIImage *imageImg = [dataArray objectAtIndex:1];
            [self displaySplashImage:imageImg inRootView:rootView verticalOffset:verticalOffset];
        }
    } else {
        if (isTextData) {
            // Display a random text from the array
            NSInteger rIndex = arc4random() % [dataArray count];
            NSString *randomText = [dataArray objectAtIndex:rIndex];
            [self displaySplashText:randomText inRootView:rootView verticalOffset:verticalOffset];
           
        } else {
           // Display a random image from the array
            NSInteger rIndex = arc4random() % [dataArray count];
            UIImage *randomImg = [dataArray objectAtIndex:rIndex];
            [self displaySplashImage:randomImg inRootView:rootView verticalOffset:verticalOffset];
        }
    }
}
+ (BOOL)isFirstTime{
    static BOOL flag=NO;
    static BOOL result;

    if(!flag){
        if ([[NSUserDefaults standardUserDefaults] boolForKey:@"hasLaunchedOnce"]){
            result=NO;
        }else{
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"hasLaunchedOnce"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            result=YES;
        }

        flag=YES;
    }
    return result;
}
+ (void)displaySplashImage:(UIImage *)image inRootView:(UIView *)rootView verticalOffset:(CGFloat)verticalOffset{
   
    // Create image view with selected image
    UIImageView *imgView = [[UIImageView alloc] initWithImage:image];
    CGFloat centerY = (loadingView.frame.size.height / 2) - (215 / 2) + verticalOffset;
    imgView.frame = CGRectMake((loadingView.frame.size.width / 2) - (415 / 2), centerY, 415, 215);
    imgView.contentMode = UIViewContentModeScaleAspectFit;
    
    // Add the image view to the view
    [loadingView addSubview:imgView];
    [loadingView bringSubviewToFront:imgView];
}
+ (void)displaySplashText:(NSString *)text inRootView:(UIView *)rootView verticalOffset:(CGFloat)verticalOffset {
    // Create label with the provided text
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, loadingView.frame.size.width, 30)];
    label.text = text;
    label.font =  [UIFont fontWithName:@"Sofia Pro" size:18];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.center = CGPointMake(loadingView.frame.size.width / 2, (loadingView.frame.size.height / 2) + verticalOffset);
    
    // Add the label to the view
    [loadingView addSubview:label];
}


+ (void)showSplash:(NSString*)splashScreen inRootView:(UIView*)rootView {
     // First array of images
    //Create image reference for the images
    UIImage *imageOne = [UIImage imageNamed:@"splash_image1.png"];
    UIImage *imageTwo = [UIImage imageNamed:@"splash_image2.png"];
    UIImage *imageThree = [UIImage imageNamed:@"splash_image3.png"];
    UIImage *imageFour = [UIImage imageNamed:@"splash_image4.png"];
    UIImage *imageFive = [UIImage imageNamed:@"splash_image5.png"];
    UIImage *imageSix = [UIImage imageNamed:@"splash_image6.png"];
    UIImage *imageSeven = [UIImage imageNamed:@"splash_image7.png"];
    UIImage *imageEight = [UIImage imageNamed:@"splash_image8.png"];
    UIImage *imageNine = [UIImage imageNamed:@"splash_image9.png"];
    UIImage *imageTen = [UIImage imageNamed:@"splash_image10.png"];
    //Save in array
    NSArray* imagesArray1 = [NSArray arrayWithObjects:imageOne,imageTwo,imageThree,imageFour,imageFive,imageSix,imageSeven,imageEight,imageNine,imageTen, nil];

    // // Second array of Text
    // //Create image reference for the Text

    NSString *textDefault = @"Be inspired. Be empowered. Be love.";
    NSString *textOne = @"Rest and self-care are so important.";
    NSString *textTwo = @"Loving yourself is life-changing.";
    NSString *textThree = @"You are a very special person.";
    NSString *textFour = @"You were born to be a champion.";
    NSString *textFive = @"Embrace your self-care.";
    NSString *textSix = @"You have success born in you.";
    NSString *textSeven = @"You can change your world.";
    NSString *textEight = @"You can do it if you believe you can.";
    NSString *textNine = @"Self-care is empowerment.";
    NSString *textTen = @"Treat yourself with love, everyday.";
    NSString *textEleven = @"You are your priority.";
    NSString *textTwelve = @"You are loved!";
    NSString *textThirteen = @"Self-care is looking after yourself.";
    NSString *textFourteen = @"Make your happiness a priority.";
    NSString *textFifteen = @"Self-respect, self-worth & self-love.";
    NSString *textSixteen = @"Be you, love you. All ways, always.";
    NSString *textSeventeen = @"Never give up!";
    NSString *textEighteen = @"Self-care is never a selfish act.";
    NSString *textNineteen = @"Take the time to love yourself.";
    NSString *textTwenty = @"Self-care equals success.";
    
    NSArray* textsArray2 = @[textDefault,textOne,textTwo,textThree,textFour,textFive,textSix,textSeven,textEight,textNine,textTen,textEleven,textTwelve,textThirteen,textFourteen,textFifteen,textSixteen,textSeventeen,textEighteen,textNineteen,textTwenty];
    // Show splash screen with images from the first array
    [RNSplashScreen showSplashImage:splashScreen inRootView:rootView withData:imagesArray1 verticalOffset:-160 isFirstInstallSetIndex:true isTextData:false];

    // Show splash screen with images from the second array
    [RNSplashScreen showSplashImage:splashScreen inRootView:rootView withData:textsArray2 verticalOffset:32 isFirstInstallSetIndex:true isTextData:true];

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

+ (void) jsLoadError:(NSNotification*)notification {
    // If there was an error loading javascript, hide the splash screen so it can be shown.  Otherwise the splash screen will remain forever, which is a hassle to debug.
    [RNSplashScreen hide];
}

RCT_EXPORT_METHOD(hide) {
    [RNSplashScreen hide];
}

RCT_EXPORT_METHOD(show) {
    [RNSplashScreen showSplash:@"SplashScreen" inRootView:[[[UIApplication sharedApplication] delegate] window]];
}

@end