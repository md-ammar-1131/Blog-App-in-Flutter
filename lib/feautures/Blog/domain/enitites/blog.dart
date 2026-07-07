// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
// /this is full definition and containings of blog table in supabase dbms
class Blog {
  final String id;
  final String imageUrl;
  final String posterId;
  final String content;
  final String title;
  final List<String> topics;
  final DateTime updatedAt;
final String ? posterName;

  Blog({
    required this.id,
    required this.imageUrl,
    required this.posterId,
    required this.content,
    required this.title,
    required this.topics,
    required this.updatedAt,
     this.posterName,
  });

  
  
}
