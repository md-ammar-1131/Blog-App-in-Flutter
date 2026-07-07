import 'dart:convert';

import 'package:blog_app/feautures/Blog/domain/enitites/blog.dart';

class BlogModel extends Blog {
  BlogModel({
    required super.id,
    required super.imageUrl,
    required super.posterId,
    required super.content,
    required super.title,
    required super.topics,
    required super.updatedAt,
    super.posterName,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'image_url': imageUrl,
      'poster_id': posterId,
      'content': content,
      'title': title,
      'topics': topics,
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  // Supabase insert/update uses this.
  Map<String, dynamic> toJson() {
    return toMap();
  }

  BlogModel copyWith({
    String? id,
    String? imageUrl,
    String? posterId,
    String? content,
    String? title,
    List<String>? topics,
    DateTime? updatedAt,
    String? posterName,
  }) {
    return BlogModel(
      id: id ?? this.id,
      imageUrl: imageUrl ?? this.imageUrl,
      posterId: posterId ?? this.posterId,
      content: content ?? this.content,
      title: title ?? this.title,
      topics: topics ?? this.topics,
      updatedAt: updatedAt ?? this.updatedAt,
      posterName:posterName?? this.posterName,
    );
  }

  factory BlogModel.fromMap(Map<String, dynamic> map) {
    return BlogModel(
      id: map['id'] as String,
      imageUrl: map['image_url'] as String,
      posterId: map['poster_id'] as String,
      content: map['content'] as String,
      title: map['title'] as String,
      topics: List<String>.from(map['topics']),
      updatedAt: map['updated_at'] == null
          ? DateTime.now()
          : DateTime.parse(map['updated_at']),
    );
  }

  // Only used when decoding a raw JSON string.
  factory BlogModel.fromJson(String source) {
    return BlogModel.fromMap(
      json.decode(source) as Map<String, dynamic>,
    );
  }
}