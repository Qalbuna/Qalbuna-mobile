class ProphetStory {
  final String id;
  final String title;
  final String description;
  final String youtubeId;
  final String? thumbnailUrl;
  final bool isActive;

  ProphetStory({
    required this.id,
    required this.title,
    required this.description,
    required this.youtubeId,
    this.thumbnailUrl,
    this.isActive = true,
  });

  factory ProphetStory.fromJson(Map<String, dynamic> json) {
    return ProphetStory(
      id: json['id'],
      title: json['title'],
      description: json['description'] ?? '',
      youtubeId: json['youtube_id'],
      thumbnailUrl: json['thumbnail_url'] ?? 
          'https://img.youtube.com/vi/${json['youtube_id']}/maxresdefault.jpg',
      isActive: json['is_active'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'youtube_id': youtubeId,
      'thumbnail_url': thumbnailUrl,
      'is_active': isActive,
    };
  }
}