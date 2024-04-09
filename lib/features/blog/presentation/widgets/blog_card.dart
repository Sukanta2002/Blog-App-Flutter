import 'package:blog_app/core/router/app_router_config.dart';
import 'package:blog_app/core/utils/reading_time_calc.dart';
import 'package:blog_app/core/entities/blog_entity.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BlogCard extends StatelessWidget {
  final BlogEntity blog;
  final Color color;
  const BlogCard({
    super.key,
    required this.blog,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(RouterConstants.blogReadingPage, extra: blog),
      child: Container(
        margin: const EdgeInsets.all(16).copyWith(bottom: 4),
        padding: const EdgeInsets.all(16),
        height: 200,
        width: double.infinity,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: blog.topics
                        .map(
                          (e) => Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Chip(
                              label: Text(e),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
                Text(
                  blog.title,
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Text('${readingTimeCalc(blog.content)} min'),
          ],
        ),
      ),
    );
  }
}
