import 'package:flutter/material.dart';

class BookCard extends StatelessWidget {
  final String title;
  final String author;
  final String category;
  final String image;

  const BookCard({
    super.key,
    required this.title,
    required this.author,
    required this.category,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 150,
            color: Colors.black12,
            child: Center(
              child: Image.asset(
                  image,
                  width: 50,
                  height: 50,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                        'assets/icons/alaskan-malamute.png');
                  }
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.menu_book),
            title: Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [Text("author: $author"), Text("category: $category")],
            ),
            isThreeLine: true,
          ),
        ],
      ),
    );
  }
}
