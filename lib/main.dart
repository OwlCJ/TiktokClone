import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/router.dart';
import 'package:tiktok_clone/theme.dart';

void main() async {
  // 모든 위젯들이 앱 시작전에 확실히 바인딩 되었는지 확인
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

  runApp(const TikTokApp());
}

class TikTokApp extends StatelessWidget {
  const TikTokApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: darkMode,
      builder: (context, child) => MaterialApp.router(
        routerConfig: router,
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        // themeMode: ThemeMode.system,
        themeMode: darkMode.value ? ThemeMode.dark : ThemeMode.light,
        theme: ThemeData(
          brightness: Brightness.light,
          bottomAppBarTheme: BottomAppBarTheme(color: Colors.grey.shade50),
          textTheme: Typography.blackMountainView,
          textSelectionTheme: const TextSelectionThemeData(
            cursorColor: Color(0xFFE9435A),
          ),
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          scaffoldBackgroundColor: Colors.white,
          primaryColor: const Color(0xFFE9435A),
          appBarTheme: const AppBarTheme(
            foregroundColor: Colors.black,
            backgroundColor: Colors.white,
            elevation: 0,
            titleTextStyle: TextStyle(
                color: Colors.black,
                fontSize: Sizes.size16 + Sizes.size2,
                fontWeight: FontWeight.w600),
          ),
          tabBarTheme: TabBarTheme(
            unselectedLabelColor: Colors.grey.shade500,
            labelColor: Colors.black,
            indicatorColor: Colors.black,
          ),
          listTileTheme: const ListTileThemeData(
            iconColor: Colors.black,
          ),
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          textTheme: Typography.whiteMountainView,
          textSelectionTheme: const TextSelectionThemeData(
            cursorColor: Color(0xFFE9435A),
          ),
          appBarTheme: AppBarTheme(backgroundColor: Colors.grey.shade900),
          scaffoldBackgroundColor: Colors.black,
          bottomAppBarTheme: BottomAppBarTheme(color: Colors.grey.shade900),
          primaryColor: const Color(0xFFE9435A),
          tabBarTheme: const TabBarTheme(
            indicatorColor: Colors.white,
          ),
        ),
      ),
    );
  }
}
