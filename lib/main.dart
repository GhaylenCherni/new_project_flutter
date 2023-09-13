import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:udemy_flutter/layout/news_app/cubit/cubit.dart';
import 'package:udemy_flutter/layout/news_app/news_layout.dart';
import 'package:udemy_flutter/layout/shop_app/cubit/cubit.dart';
import 'package:udemy_flutter/layout/shop_app/shop_layout.dart';
import 'package:udemy_flutter/layout/social_app/cubit/cubit.dart';
import 'package:udemy_flutter/layout/social_app/social_layout.dart';
import 'package:udemy_flutter/layout/todo_app/todo_layout.dart';
import 'package:udemy_flutter/modules/bmi_app/bmi_result/bmi_result_screen.dart';
import 'package:udemy_flutter/modules/basics_app/home/home_screen.dart';
import 'package:udemy_flutter/modules/basics_app//login/login_screen.dart';
import 'package:udemy_flutter/modules/basics_app/messenger/messenger_screen.dart';
import 'package:udemy_flutter/modules/basics_app/users/users_screen.dart';
import 'package:udemy_flutter/modules/shop_app/login/shop_login_screen.dart';
import 'package:udemy_flutter/modules/shop_app/on_boarding/on_boarding_screen.dart';
import 'package:udemy_flutter/modules/social_app/social_login/social_login_screen.dart';
import 'package:udemy_flutter/shared/components/components.dart';
import 'package:udemy_flutter/shared/components/constants.dart';
import 'package:udemy_flutter/shared/cubit/cubit.dart';
import 'package:udemy_flutter/shared/cubit/states.dart';
import 'package:udemy_flutter/shared/network/local/cache_helper.dart';
import 'package:udemy_flutter/shared/network/remote/dio_helper.dart';
import 'package:udemy_flutter/shared/styles/themes.dart';

// import 'layout/todo_layout.dart';
import 'modules/bmi_app/bmi/bmi_screen.dart';
import 'modules/counter_app/counter/counter_screen.dart';
import 'shared/bloc_observer.dart';

Future<void>firebaseMessagingBackgroundHandler(RemoteMessage message) async
{
  print('on background message');
  print(message.data.toString());
  showToast(
    text: 'on background message',
    state: ToastStates.SUCCESS,
  );
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  var token = await FirebaseMessaging.instance.getToken();

  print(token);

  // foreground fcm (firebase cloud messaging)
  FirebaseMessaging.onMessage.listen((event) {
    print('on message');
    print(event.data.toString());
    showToast(
      text: 'on message',
      state: ToastStates.SUCCESS,
    );
  });

  // when click on notification to open app
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print('on message opened app');
    print(event.data.toString());
    showToast(
      text: 'on message opened app',
      state: ToastStates.SUCCESS,
    );
  });

  //background fcm
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  bool? isDark = CacheHelper.getData(key: 'isDark');
  Widget widget;

  // bool? onBoarding = CacheHelper.getData(key: 'onBoarding');

  // String? token = CacheHelper.getData(key: 'token');
  // print(token);

  uId = CacheHelper.getData(key: 'uId');

  if (uId != null) {
    print(uId);
    widget = SocialLayout();
  } else {
    widget = SocialLoginScreen();
  }

  // if(onBoarding !=null) {
  //   if(token!=null) widget = ShopLayout();
  //   else widget = ShopLoginScreen();
  // }else{
  //   widget = OnBoardingScreen();
  // }

  // print(onBoarding);

  runApp(MyApp(
    isDark: isDark ?? false,
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final bool isDark;
  final Widget startWidget;

  MyApp({
    required this.isDark,
    required this.startWidget,
  });
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => NewsCubit()
            ..getBusiness()
            ..getSports()
            ..getScience(),
        ),
        BlocProvider(
          create: (BuildContext context) => AppCubit()
            ..changeAppMode(
              fromShared: isDark,
            ),
        ),
        BlocProvider(
          create: (BuildContext context) => ShopCubit()
            ..getHomeData()
            ..getCategories()
            ..getFavorites()
            ..getUserData(),
        ),
        BlocProvider(
          create: (BuildContext context) => SocialCubit()
            ..getUserData()
            ..getPosts(),
        ),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode:
                AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            debugShowCheckedModeBanner: false,
            home: startWidget,
            //startWidget,
          );
        },
      ),
    );
  }
}
