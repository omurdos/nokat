import 'package:flutter/material.dart';
import 'package:nokat/providers/home_provider.dart';
import 'package:nokat/screens/jokes_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'home_screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  BuildContext builderContext;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeProvider>(
      create: (_) => HomeProvider(),
      child: Consumer<HomeProvider>(
        builder: (context, model, child) {
          builderContext = context;
          return Scaffold(
            appBar: AppBar(
              title: Text('النكات'),
            ),
            body: SafeArea(
              child: JokesScreen(),
            ),

          );
        },
      ),
    );
  }

  void _onItemTapped(int index) {
    builderContext.read<HomeProvider>().selectedIndex =
        index;
  }
}
