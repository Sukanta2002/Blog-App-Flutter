class BlogEntity {
  final String id;
  final String posterId;
  final String title;
  final String content;
  final DateTime updatedAt;
  final String imageUrl;
  final List<String> topics;

  BlogEntity({
    required this.id,
    required this.posterId,
    required this.title,
    required this.content,
    required this.updatedAt,
    required this.imageUrl,
    required this.topics,
  });
}
