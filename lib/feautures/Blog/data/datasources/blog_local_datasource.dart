import 'package:blog_app/feautures/Blog/data/models/blog_model.dart';
import 'package:hive/hive.dart';

abstract interface class BlogLocalDatasource {


void uploadLocalBlogs({required List<BlogModel> blogs});
  List<BlogModel> loadBlogs();

  
}

class BlogLocalDatasourceImpl implements BlogLocalDatasource {
  final Box box;

  BlogLocalDatasourceImpl(this.box); //this is how we use hive

  @override
  List<BlogModel> loadBlogs() {
    List<BlogModel>blogs=[];
    for(int i=0;i<box.length;i++){
    // blogs.add(BlogModel.fromJson(box.get(i.toString())));
    blogs.add(
  BlogModel.fromMap(
    Map<String, dynamic>.from(box.get(i.toString())),
  ),
);
    //box.get gives json
    //to get data from the box
    }
    return blogs;

  
  }

  @override
  void uploadLocalBlogs({required List<BlogModel> blogs}) {
    box.clear();//no duplication


    box.write(() {
      for (int i = 0; i < blogs.length; i++) {
        box.put(i.toString(), blogs[i].toJson());
      }
    });
    //we will use write to upload buch of data to loal storage
  }
}
