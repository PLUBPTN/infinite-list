import 'package:flutter/material.dart';

@immutable
class Post {

  Post({this.id, this.title, this.body});

  final int id;
  final String title;
  final String body;
}