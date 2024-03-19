package org.devio.rn.splashscreen;

import android.app.Activity;
import android.app.Dialog;
import android.os.Build;
import android.view.WindowManager;
import android.widget.ImageView;
import android.widget.TextView;
import android.content.Context;
import android.content.SharedPreferences;
import java.lang.ref.WeakReference;
import java.util.Random;
/**
 * SplashScreen
 * 启动屏
 * from：http://www.devio.org
 * Author:CrazyCodeBoy
 * GitHub:https://github.com/crazycodeboy
 * Email:crazycodeboy@gmail.com
 */
public class SplashScreen {
    private static Dialog mSplashDialog;
    private static WeakReference<Activity> mActivity;
    private static final String PREFS_NAME = "MyPrefsFile";
    private static final String KEY_FIRST_INSTALL = "firstInstall";
    /**
     * 打开启动屏
     */
    public static void show(final Activity activity, final int themeResId, final boolean fullScreen) {
        if (activity == null) return;
        mActivity = new WeakReference<Activity>(activity);
        activity.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                if (!activity.isFinishing()) {
                    mSplashDialog = new Dialog(activity, themeResId);
                    mSplashDialog.setContentView(R.layout.launch_screen);
                    mSplashDialog.setCancelable(false);

                    // For Random Image
                    //Get doll image view holder by id
                    ImageView img = (ImageView) mSplashDialog.findViewById(R.id.splash_screen_image);
                    //Array of doll images
                    int[] ids = new int[]{R.drawable.splash_image1,R.drawable.splash_image2,R.drawable.splash_image3, R.drawable.splash_image4, R.drawable.splash_image5, R.drawable.splash_image6, R.drawable.splash_image7, R.drawable.splash_image8, R.drawable.splash_image9,R.drawable.splash_image10};
                    // //Select random image
                    Random randomGenerator = new Random();
                    int r= randomGenerator.nextInt(ids.length);
                    // //Set image to the view holder
                    // img.setImageResource(ids[r]);

                    // For Random Quote
                    // Get TextView view holder by id
                    TextView txt = (TextView) mSplashDialog.findViewById(R.id.quote_text);

                    // Array of text options
                    String[] texts = new String[]{
                        "Be inspired. Be empowered. Be love.",
                        "Rest and self-care are so important.",
                        "Loving yourself is life-changing.",
                        "You are a very special person.",
                        "You were born to be a champion.",
                        "Embrace your self-care.",
                        "You have success born in you.",
                        "You can change your world.",
                        "You can do it if you believe you can.",
                        "Self-care is empowerment.",
                        "Treat yourself with love, everyday.",
                        "You are your priority.",
                        "You are loved!",
                        "Self-care is looking after yourself.",
                        "Make your happiness a priority.",
                        "Self-respect, self-worth & self-love.",
                        "Be you, love you. All ways, always.",
                        "Never give up!",
                        "Self-care is never a selfish act.",
                        "Take the time to love yourself.",
                        "Self-care equals success."
                    };
                    //Select random text
                    Random randomGeneratorTextNumber = new Random();
                    int rText= randomGeneratorTextNumber.nextInt(texts.length);
                    //Set text to the view holder
                    if (isFirstInstall(activity)) {
                         txt.setText(texts[0]);
                         img.setImageResource(ids[1]);
                        // Perform actions for the first install
                        setFirstInstallFlag(activity, false); // Update flag to indicate subsequent launches
                    } else {
                        txt.setText(texts[rText]);
                        img.setImageResource(ids[r]);
                    }

                    if (fullScreen) {
                        setActivityAndroidP(mSplashDialog);
                    }
                    if (!mSplashDialog.isShowing()) {
                        mSplashDialog.show();
                    }
                }
            }
        });
    }

    /**
     * 打开启动屏
     */
    public static void show(final Activity activity, final boolean fullScreen) {
        int resourceId = fullScreen ? R.style.SplashScreen_Fullscreen : R.style.SplashScreen_SplashTheme;

        show(activity, resourceId, fullScreen);
    }

    /**
     * 打开启动屏
     */
    public static void show(final Activity activity) {
        show(activity, false);
    }

    /**
     * 关闭启动屏
     */
    public static void hide(Activity activity) {
        if (activity == null) {
            if (mActivity == null) {
                return;
            }
            activity = mActivity.get();
        }

        if (activity == null) return;

        final Activity _activity = activity;

        _activity.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                if (mSplashDialog != null && mSplashDialog.isShowing()) {
                    boolean isDestroyed = false;

                    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.JELLY_BEAN_MR1) {
                        isDestroyed = _activity.isDestroyed();
                    }

                    if (!_activity.isFinishing() && !isDestroyed) {
                        mSplashDialog.dismiss();
                    }
                    mSplashDialog = null;
                }
            }
        });
    }

    private static void setActivityAndroidP(Dialog dialog) {
        //设置全屏展示
        if (Build.VERSION.SDK_INT >= 28) {
            if (dialog != null && dialog.getWindow() != null) {
                dialog.getWindow().addFlags(WindowManager.LayoutParams.FLAG_LAYOUT_NO_LIMITS);//全屏显示
                WindowManager.LayoutParams lp = dialog.getWindow().getAttributes();
                lp.layoutInDisplayCutoutMode = WindowManager.LayoutParams.LAYOUT_IN_DISPLAY_CUTOUT_MODE_SHORT_EDGES;
                dialog.getWindow().setAttributes(lp);
            }
        }
    }
    private static boolean isFirstInstall(Context context) {
        SharedPreferences prefs = context.getSharedPreferences(PREFS_NAME, Context.MODE_PRIVATE);
        return prefs.getBoolean(KEY_FIRST_INSTALL, true);
    }

    private static void setFirstInstallFlag(Context context, boolean isFirstInstall) {
        SharedPreferences prefs = context.getSharedPreferences(PREFS_NAME, Context.MODE_PRIVATE);
        SharedPreferences.Editor editor = prefs.edit();
        editor.putBoolean(KEY_FIRST_INSTALL, isFirstInstall);
        editor.apply();
    }
}
