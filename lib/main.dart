import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:nokat/providers/jokes_provider.dart';
import 'package:nokat/screens/home_screen.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => JokesProvider(), ),
      ],
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ضحكني',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: Locale('ar'),
      supportedLocales: [Locale('ar')],
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryTextTheme: TextTheme(
          headline6: TextStyle(color: Colors.black87)
        ),
        brightness: Brightness.light,
        appBarTheme: AppBarTheme(
          color: Colors.white,
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      darkTheme: ThemeData.dark().copyWith(
        primaryColor: Colors.blue,
        appBarTheme: AppBarTheme(
          color: Colors.black26
        )
      ),
      themeMode: ThemeMode.system,
      initialRoute: HomeScreen.id,
      routes: {
        HomeScreen.id : (context) => HomeScreen()
      },
    );
  }
}

