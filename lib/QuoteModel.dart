// To parse this JSON data, do
//
//     final quote = quoteFromJson(jsonString);

import 'dart:convert';

List<Quote> quoteFromJson(String str) => List<Quote>.from(json.decode(str).map((x) => Quote.fromJson(x)));

String quoteToJson(List<Quote> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Quote {
  Quote({
    this.text,
    this.author,
  });

  final String text;
  final String author;

  factory Quote.fromJson(Map<String, dynamic> json) => Quote(
    text: json["text"],
    author: json["author"] == null ? null : json["author"],
  );

  Map<String, dynamic> toJson() => {
    "text": text,
    "author": author == null ? null : author,
  };
}
