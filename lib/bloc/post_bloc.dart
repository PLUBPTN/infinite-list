import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:infinite_list/model/post.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc() : super(PostState(posts: []));

  @override
  Stream<Transition<PostEvent, PostState>> transformEvents(events, transitionFn) {
    return super.transformEvents(
      events.debounceTime(const Duration(milliseconds: 500)),
      transitionFn,
    );
  }

  @override
  Stream<PostState> mapEventToState(
    PostEvent event,
  ) async* {
    if (event is PostFetch) {
      var posts = await _fetch(state.posts.length);
      yield PostState(posts: List.of(state.posts)..addAll(posts));
    }
  }

  Future<List<Post>> _fetch(int startIndex) async {
    final response = await http.get(
        'https://jsonplaceholder.typicode.com/posts?_start=$startIndex&_limit=2');
    final posts = jsonDecode(response.body) as List;
    return posts.map((item) {
      return Post(
        id: item['id'] as int,
        title: item['title'] as String,
        body: item['body'] as String,
      );
    }).toList();
  }
}
