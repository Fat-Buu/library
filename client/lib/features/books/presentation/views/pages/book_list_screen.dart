import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:oneoone_library/core/routes/app_routes.dart';

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
  bool _isSearching = false;
  TextEditingController _searchController = TextEditingController();
  String _token = "";
  final storage = FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    loadToken();
  }

  Future<void> loadToken() async {
    String? token = await storage.read(key: "access_token");
    setState(() {
      if (token == null) {
        context.goNamed(AppRoutes.login);
      } else {
        _token = token;
      }
    });
  }

  Future<void> logout() async {
    await storage.delete(key: "access_token");
    loadToken();
  }

  @override
  Widget build(BuildContext context) {
    final bookState = ref.watch(bookListProvider);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 75,
        title:
            _isSearching
                ? Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 100),
                    child: TextField(
                      controller: _searchController,
                      autofocus: true,
                      decoration: InputDecoration(
                        hintText: "Search...",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                )
                : titleText("Library"),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Container(color: Colors.black, height: 1),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: IconButton(
              onPressed: () {
                setState(() {
                  if (_isSearching) {
                    _searchController.clear();
                  }
                  _isSearching = !_isSearching;
                });
              },
              icon: CircleAvatar(
                child: _isSearching ? Icon(Icons.close) : Icon(Icons.search),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: PopupMenuButton(
              icon: CircleAvatar(child: Icon(Icons.person)),
              onSelected: (value) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(value),
                      duration: Duration(seconds: 2),
                    ),
                  );
                  if (value == "logout") {
                    logout();
                    context.goNamed(AppRoutes.home);
                  }
                }
              },
              itemBuilder:
                  (BuildContext context) => [
                    PopupMenuItem(value: "profile", child: Text("Profile")),
                    PopupMenuItem(value: "setting", child: Text("Settings")),
                    PopupMenuItem(value: "logout", child: Text("Logout")),
                  ],
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
                    Expanded(child: Text("Token: ${_token}")),
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
