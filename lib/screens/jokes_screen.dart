import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nokat/enums/app_state.dart';
import 'package:nokat/enums/load_more_state.dart';
import 'package:nokat/providers/base_provider.dart';
import 'package:nokat/providers/jokes_provider.dart';
import 'package:nokat/widgets/joke_list_item.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

class JokesScreen extends StatefulWidget {
  @override
  _JokesScreenState createState() => _JokesScreenState();
}

class _JokesScreenState extends State<JokesScreen> {

  ScrollController scrollController;

  @override
  void initState() {
    scrollController = ScrollController();
    scrollController.addListener(_scrollListener);
    super.initState();

  }
  _scrollListener() {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
     context.read<JokesProvider>().loadMoreJokes();
    }
  }
  JokesProvider jokesProvider;
  @override
  Widget build(BuildContext context) {
    jokesProvider= context.watch<JokesProvider>();
    switch (jokesProvider.state) {
      case AppState.idle:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: RefreshIndicator(
                onRefresh: () {
                  return jokesProvider.fetchJokes();
                },
                child: ListView.builder(
                    controller: scrollController,

                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                    itemCount: jokesProvider.jokes.length,
                    itemBuilder: (context, position) {
                      return JokeListItem(
                          text: jokesProvider.jokes[position].text,
                          onShare: () {
                            Share.share(
                              jokesProvider.jokes[position].text,
                            );
                          },
                          onCopy: () {
                            Clipboard.setData(
                                ClipboardData(text: jokesProvider.jokes[position].text));
                          });
                    }),
              ),
            ),
            jokesProvider.loadMoreState == LoadMoreState.Loading ? Center(child: CircularProgressIndicator(),) : SizedBox()
          ],
        );
      case AppState.processing:
        return Center(
          child: CircularProgressIndicator(),
        );
      case AppState.error:
        return Center(
          child: Text("Can't fetch jokes at the moment"),
        );
      default:
        return Container();
    }
  }
}
