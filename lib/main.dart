import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:myminicloset/provider/boardpovider.dart';
import 'package:myminicloset/provider/userprovider.dart';
import 'package:provider/provider.dart';
import 'screens/login_screen.dart' as login;
import 'screens/home_screen.dart' as home;
import 'screens/recommendation_screen.dart';
import 'screens/personal_color_screen.dart';
import 'firebase_options.dart';
import 'imagerepository.dart'; // image.dart 파일을 import 합니다.

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  KakaoSdk.init(nativeAppKey: '291ad7d498687655690b94b3dc6433e2'); //카카오개발자 사이트에 등록한 내 앱 네이티브 키
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
        providers: [
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => BoardProvider()),
        ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fashion App',
      initialRoute: '/',
      routes: {
        '/': (context) => login.LoginScreen(),
        '/home': (context) => home.HomeScreen(),
        '/recommendation': (context) => RecommendationScreen(),
        '/personal_color': (context) => PersonalColorScreen(), 
      },
    );
  }
}

