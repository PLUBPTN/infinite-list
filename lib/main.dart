import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_list/bloc/post_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (context) => PostBloc()..add(PostFetch()),
        child: MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          return ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: state.posts.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  height: 50,
                  child: Center(child: Text(state.posts[index].title)),
                );
              });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => BlocProvider.of<PostBloc>(context).add(PostFetch()),
        tooltip: 'Load More Post',
        child: Icon(Icons.add),
      ),
    );
  }
}
