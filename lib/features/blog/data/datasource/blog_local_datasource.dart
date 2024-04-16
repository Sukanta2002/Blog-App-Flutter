import 'package:blog_app/features/blog/data/models/blog_models.dart';
import 'package:hive/hive.dart';

abstract interface class BlogLoaclDatasouece {
  void uploadBlogs(List<BlogModel> blogs);
  List<BlogModel> getBlogs();
}

class BlogLoaclDatasoueceImpl implements BlogLoaclDatasouece {
  final Box box;
  BlogLoaclDatasoueceImpl(this.box);
  @override
  List<BlogModel> getBlogs() {
    try {
      List<BlogModel> blogs = [];
      box.read(() {
        for (var i = 0; i < box.length; i++) {
          blogs.add(BlogModel.fromJson(box.get(i.toString())));
        }
      });
      return blogs;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  void uploadBlogs(List<BlogModel> blogs) {
    try {
      box.clear();
      box.write(() {
        for (var i = 0; i < blogs.length; i++) {
          box.put(i.toString(), blogs[i].toJson());
        }
      });
    } catch (e) {
      throw e.toString();
    }
  }
}
