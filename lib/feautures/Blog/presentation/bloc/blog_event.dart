
import 'dart:io';

import 'package:flutter/material.dart';

@immutable
sealed class BlogEvent {}

final class blogUpload extends BlogEvent {
  final String posterId;
  final String title;
  final String content;
  final File image;
  final List<String> topics;

  blogUpload({
    required this.posterId,
    required this.title,
    required this.content,
    required this.image,
    required this.topics,
  });
}
final class BlogFetchAllblogs extends BlogEvent{}