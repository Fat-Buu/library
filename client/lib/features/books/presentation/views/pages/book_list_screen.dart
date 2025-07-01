import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/widgets/title_text.dart';
import '../../../domain/entities/book.dart';
import '../../viewmodels/book_list_viewmodel.dart';
import '../widgets/book_card.dart';

class BookListScreen extends ConsumerStatefulWidget {
  const BookListScreen({super.key});

  @override
  ConsumerState<BookListScreen> createState() => BookListScreenState();
}

class BookListScreenState extends ConsumerState<BookListScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bookState = ref.watch(bookListProvider);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 75,
        title: titleText("Library"),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Container(color: Colors.black, height: 1),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: IconButton(
              onPressed: () {},
              icon: CircleAvatar(child: Icon(Icons.search)),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: IconButton(
              onPressed: () {},
              icon: CircleAvatar(child: Icon(Icons.person)),
            ),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: bookState.when(
              data: (books) {
                if (books.isEmpty) {
                  return Center(child: Text("No book"));
                }
                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: books.isEmpty ? 1 : books.length + 1,
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            return colHeader();
                          }
                          index -= 1;
                          Book book = books[index];
                          return BookCard(
                            title: book.title,
                            author: book.author,
                            category: book.category,
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
              error: (e, _) => Center(child: Text("Something error!!")),
              loading: () => Center(child: CircularProgressIndicator()),
            ),
          ),
        ],
      ),
    );
  }

  Widget colHeader() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          height: 200,
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(width: 1, color: Colors.black12)),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(15),
          child: Text(
            "Recommended stories",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
          ),
        ),
      ],
    );
  }
}
