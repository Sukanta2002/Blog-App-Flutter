import 'package:blog_app/core/utils/reading_time_calc.dart';
import 'package:blog_app/core/entities/blog_entity.dart';
import 'package:flutter/material.dart';

class BlogReadingPage extends StatelessWidget {
  final BlogEntity blog;
  const BlogReadingPage({super.key, required this.blog});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                blog.title,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'By ${blog.posterName}',
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),
              Text(
                '${blog.updatedAt}. ${readingTimeCalc(blog.content)}',
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 25),
              SizedBox(
                height: 250,
                width: double.infinity,
                child: ClipRRect(
                  child: Image.network(
                    blog.imageUrl,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                blog.content,
                style: const TextStyle(fontSize: 16, height: 1.5),
              )
            ],
          ),
        ),
      ),
    );
  }
}
