class NewsModel {
  String? status;
  int? total;
  List<Articles>? posts;

  NewsModel({this.status, this.total, this.posts});

  NewsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    total = json['totalResults'];
    if (json['articles'] != null) {
      posts = <Articles>[];
      json['articles'].forEach((v) {
        posts!.add(Articles.fromJson(v));
      });
    }
  }
}

class Articles {
  Source? source;
  String? author;
  String? title;
  String? description;
  String? url;
  String? urlToImage;
  String? publishedAt;
  String? content;

  Articles(
      {this.source,
      this.author,
      this.title,
      this.description,
      this.url,
      this.urlToImage,
      this.publishedAt,
      this.content});

  Articles.fromJson(Map<String, dynamic> json) {
    source = json['source'] != null ? Source.fromJson(json['source']) : null;
    author = json['author'];
    title = json['title'];
    description = json['description'];
    url = json['url'];
    urlToImage = json['urlToImage'];
    publishedAt = json['publishedAt'];
    content = json['content'];
  }
}

class Source {
  String? id;
  String? name;

  Source({this.id, this.name});

  Source.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
}
