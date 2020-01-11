class Article {
  String title;
  String image;
  String date;
  String author;
  String imageAuthor;
  String body;

  Article({
    this.title,
    this.image,
    this.date,
    this.author,
    this.body,
    this.imageAuthor,
  });

  Article fromJson(Map<String, dynamic> json) {
    return Article(
        title: json['title'],
        image: json['image'],
        date: json['date'],
        author: json['author'],
        body: json['body'],
        imageAuthor: json['imageAuthor']);
  }
}
