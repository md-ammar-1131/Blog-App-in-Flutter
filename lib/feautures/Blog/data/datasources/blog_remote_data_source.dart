import 'dart:developer';
import 'dart:io';

import 'package:blog_app/core/errors/exceptions.dart';
import 'package:blog_app/feautures/Blog/data/models/blog_model.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class BlogRemoteDataSource {
  Future<BlogModel> uploadBlog(BlogModel blog);

  Future<String> uploadBlogImage({
    required File image,
    required BlogModel blog,
  });
  Future<List<BlogModel>>getAllBlogs();
  
}

class BlogRemoteDataSourceImplmn implements BlogRemoteDataSource {
  final SupabaseClient supabaseClient;

  BlogRemoteDataSourceImplmn(this.supabaseClient);

  @override
  Future<BlogModel> uploadBlog(BlogModel blog) async {
    try {
      final blogData = await supabaseClient
          .from('blogs')
          .insert(blog.toJson())
          .select();

      // return BlogModel.fromJson(blogData.first as String);
      return BlogModel.fromMap(blogData.first);
    } on PostgrestException catch (e, stackTrace) {
      debugPrint("========== POSTGREST EXCEPTION ==========");
      debugPrint("Message : ${e.message}");
      debugPrint("Code    : ${e.code}");
      debugPrint("Details : ${e.details}");
      debugPrintStack(stackTrace: stackTrace);

      throw ServerExceptions(e.message);
    } catch (e, stackTrace) {
      debugPrint("========== UNKNOWN EXCEPTION ==========");
      debugPrint(e.toString());
      debugPrintStack(stackTrace: stackTrace);

      log(
        e.toString(),
        name: "BLOG_REMOTE_DATASOURCE",
        error: e,
        stackTrace: stackTrace,
      );

      throw ServerExceptions(e.toString());
    }
  }

  @override
  Future<String> uploadBlogImage({
    required File image,
    required BlogModel blog,
  }) async {
    try {
      await supabaseClient.storage
          .from('blog_images')
          .upload(blog.id, image, fileOptions: const FileOptions(upsert: true));
      return supabaseClient.storage.from('blog_images').getPublicUrl(blog.id);
    } on StorageException catch (e, stackTrace) {
      debugPrint("========== STORAGE EXCEPTION ==========");
      debugPrint("Message : ${e.message}");
      debugPrint("Status  : ${e.statusCode}");
      debugPrintStack(stackTrace: stackTrace);

      throw ServerExceptions(e.message);
    } catch (e, stackTrace) {
      debugPrint("========== UNKNOWN EXCEPTION ==========");
      debugPrint(e.toString());
      debugPrintStack(stackTrace: stackTrace);

      log(
        e.toString(),
        name: "BLOG_REMOTE_DATASOURCE",
        error: e,
        stackTrace: stackTrace,
      );

      throw ServerExceptions(e.toString());
    }
  }
  
  @override
  Future<List<BlogModel>> getAllBlogs() async {

try{
  //the below is joint opetaion
  final blogs=await supabaseClient.from('blogs').select('*,profiles(name)');
  //getting all data of blog from blog table of supbase we want
  // user data from supbase also like firstly the image data when
  // what who and then fro mthis who we will go to supabse profile
  // table to get user name email ..user data
  //the above thing will be done by posterId;


return blogs.map((blog)=>BlogModel.fromMap(blog).copyWith(posterName: blog['profiles']['name'])). toList();//////////////////////////////////////////

//we will use copywith here as we ant a extra thing named postername
// which is nto reqruied anywhere till now so provetnt any error wewill 
//use copywith and will get new blogmedl with postername also 


}
catch (e){
  throw ServerExceptions(e.toString());

}

  }
}
