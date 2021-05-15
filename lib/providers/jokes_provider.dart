import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nokat/enums/app_state.dart';
import 'package:nokat/enums/load_more_state.dart';
import 'package:nokat/models/joke_model.dart';
import 'package:nokat/providers/base_provider.dart';

class JokesProvider extends BaseProvider {
  LoadMoreState _loadMoreState = LoadMoreState.Idle;

  LoadMoreState get loadMoreState => _loadMoreState;

  set loadMoreState(LoadMoreState value) {
    _loadMoreState = value;
    notifyListeners();
  }

  List<JokeModel> _jokes = [];
  QueryDocumentSnapshot _lastValue;
  final limit = 10;

  QueryDocumentSnapshot get lastValue => _lastValue;

  set lastValue(QueryDocumentSnapshot value) {
    _lastValue = value;
    notifyListeners();
  }

  List<JokeModel> get jokes => _jokes;

  set jokes(List<JokeModel> value) {
    _jokes = value;
    notifyListeners();
  }

  addJokes(List<JokeModel> value) {
    _jokes.addAll(value);
    notifyListeners();
  }

  JokesProvider() {
    if (jokes.isEmpty) fetchJokes();
  }

  Future<void> fetchJokes() async {
    try {
      state = AppState.processing;
      final query = FirebaseFirestore.instance
          .collection('jokes')
          .orderBy('text')
          .limit(limit);
      final result = await query.get();
      lastValue = result.docs.last;
      final tempJokes =
          result.docs.map((e) => JokeModel.fromJson(e.data())).toList();
      addJokes(tempJokes);
      state = AppState.idle;
    } catch (e, stackTrace) {
      print("$e: $stackTrace");
      state = AppState.error;
    }
  }

  Future<void> loadMoreJokes() async {
    try {
      loadMoreState = LoadMoreState.Loading;
      final query = FirebaseFirestore.instance
          .collection('jokes')
          .orderBy('text')
          .startAfterDocument(lastValue)
          .limit(limit);
      final result = await query.get();
      if (result.docs.isNotEmpty) {
        lastValue = result.docs.last;
        final tempJokes =
            result.docs.map((e) => JokeModel.fromJson(e.data())).toList();
        addJokes(tempJokes);
      } else {
        print("That's the end of it buddy");
      }
      loadMoreState = LoadMoreState.Idle;
    } catch (e, stackTrace) {
      print("$e: $stackTrace");
    }
  }
}
