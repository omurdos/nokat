import 'package:nokat/providers/base_provider.dart';
import 'package:nokat/screens/jokes_screen.dart';
import 'package:nokat/screens/settings_screen.dart';

class HomeProvider extends BaseProvider {
  int _selectedIndex;

  int get selectedIndex => _selectedIndex;

  set selectedIndex(int value) {
    _selectedIndex = value;
    notifyListeners();
  }
  HomeProvider() {
    selectedIndex = 0;
  }
  final screens = [JokesScreen(), SettingsScreen()];
}
