class BookRemoteDataSource {
  Future<List<Map<String, dynamic>>> fetchBooks() async {
    await Future.delayed(Duration(milliseconds: 500));
    return [
      {
        'id': '1',
        'title': 'Clean Architecture',
        'author': 'Robert C. Martin',
        'category': 'Programming',
      },
      {
        'id': '2',
        'title': 'Flutter in Action',
        'author': 'Eric Windmill',
        'category': 'Mobile Development',
      },
    ];
  }
}
