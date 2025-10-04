import 'dart:convert';
import '../blog.dart';

class AllBlogsResponse {
  final bool ok;
  final List<Blog> blogs;
  final int total;
  final int? totalPages;
  final int? currentPage;

  AllBlogsResponse({
    required this.ok,
    required this.blogs,
    required this.total,
    this.totalPages,
    this.currentPage,
  });

  factory AllBlogsResponse.fromRawJson(String str) => AllBlogsResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AllBlogsResponse.fromJson(Map<String, dynamic> json) => AllBlogsResponse(
        ok: true, // Asumimos true si llegó la respuesta
        blogs: json["blogs"] != null 
            ? List<Blog>.from(json["blogs"].map((x) => Blog.fromJson(x)))
            : [],
        total: json["total"] ?? 0,
        totalPages: json["totalPages"],
        currentPage: json["currentPage"],
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "blogs": List<dynamic>.from(blogs.map((x) => x.toJson())),
        "total": total,
      };
}

class BlogResponse {
  final bool ok;
  final Blog blog;
  final String? msg;

  BlogResponse({
    required this.ok,
    required this.blog,
    this.msg,
  });

  factory BlogResponse.fromRawJson(String str) => BlogResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BlogResponse.fromJson(Map<String, dynamic> json) => BlogResponse(
        ok: json["ok"] ?? false,
        blog: json["blog"] != null 
            ? Blog.fromJson(json["blog"])
            : Blog.empty(),
        msg: json["msg"],
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "blog": blog.toJson(),
        "msg": msg,
      };
}




