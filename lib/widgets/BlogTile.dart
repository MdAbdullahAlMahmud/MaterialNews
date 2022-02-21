import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/screen/ArticleWebView.dart';

class BlogTile extends StatelessWidget {
  String title, description, url, blogUrl;
  BlogTile(
      @required this.title, this.description, this.url, @required this.blogUrl);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ArticleWebView(blogUrl),
        ));
      },
      child: Container(
        margin: EdgeInsets.all(12),
        child: Column(
          children: [
            ClipRRect(
              child: CachedNetworkImage(
                imageUrl: url,
                placeholder: (context, url) => new CircularProgressIndicator(),
                errorWidget: (context, url, error) => new Icon(Icons.error),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(6),
            ),
            blogText(title, 18, Colors.black, FontWeight.w500),
            SizedBox(
              height: 8,
            ),
            blogText(description, 16, Colors.black54, FontWeight.w400)
          ],
        ),
      ),
    );
  }

  Widget blogText(
      String body, double size, Color color, FontWeight fontWeight) {
    return Text(
      body,
      style: TextStyle(fontSize: size, fontWeight: fontWeight, color: color),
    );
  }
}
