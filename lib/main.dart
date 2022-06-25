//region imports
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
//import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:prokit_flutter/fullApps/cloudStorage/model/CSDataModel.dart';
import 'package:prokit_flutter/locale/AppLocalizations.dart';
import 'package:prokit_flutter/main/screens/AppSplashScreen.dart';
import 'package:prokit_flutter/main/store/AppStore.dart';
import 'package:prokit_flutter/main/utils/AppTheme.dart';
import 'package:prokit_flutter/routes.dart';

import 'locale/Languages.dart';
import 'main/utils/AppConstant.dart';
import 'main/utils/AppDataProvider.dart';
//endregion

/// This variable is used to get dynamic colors when theme mode is changed
AppStore appStore = AppStore();

List<CSDataModel> getCloudboxList = getCloudboxData();
List<CSDrawerModel> getCSDrawerList = getCSDrawer();
int currentIndex = 0;
BaseLanguage? language;

void main() async {
  //region Entry Point
  WidgetsFlutterBinding.ensureInitialized();

  await initialize(aLocaleLanguageList: languageList());

 // Stripe.publishableKey = STRIPE_PAYMENT_PUBLISH_KEY;

  appStore.toggleDarkMode(value: getBoolAsync(isDarkModeOnPref));
  await appStore.setLanguage(getStringAsync(SELECTED_LANGUAGE_CODE, defaultValue: defaultLanguage));

  defaultRadius = 10;
  defaultToastGravityGlobal = ToastGravity.BOTTOM;

  if (isMobile || isWeb) {
    Firebase.initializeApp().then((value) {
      MobileAds.instance.initialize();

      //FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
    });

    if (isMobile) {
      try {
        await OneSignal.shared.setAppId(OneSignalId);
      } catch (e) {
        print('${e.toString()}');
      }

      OneSignal.shared.setNotificationWillShowInForegroundHandler((OSNotificationReceivedEvent? event) {
        return event?.complete(event.notification);
      });

      OneSignal.shared.disablePush(false);
      OneSignal.shared.consentGranted(true);
      OneSignal.shared.requiresUserPrivacyConsent();
    }
  }

  runApp(MyApp());
  //endregion
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: '$mainAppName${!isMobile ? ' ${platformName()}' : ''}',
        home: AppSplashScreen(),
        theme: !appStore.isDarkModeOn ? AppThemeData.lightTheme : AppThemeData.darkTheme,
        routes: routes(),
        navigatorKey: navigatorKey,
        scrollBehavior: SBehavior(),
        supportedLocales: LanguageDataModel.languageLocales(),
        localizationsDelegates: [AppLocalizations(), GlobalMaterialLocalizations.delegate, GlobalWidgetsLocalizations.delegate],
        localeResolutionCallback: (locale, supportedLocales) => locale,
        locale: Locale(appStore.selectedLanguageCode),
      ),
    );
  }
}
