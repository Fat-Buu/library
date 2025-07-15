class BookRemoteDataSource {
  Future<List<Map<String, dynamic>>> fetchBooks() async {
    await Future.delayed(Duration(milliseconds: 5000));
    return [
      {
        "id": "1",
        "title": "Clean Architecture",
        "author": "Robert C. Martin",
        "category": "Programming",
        "image": "assets/icons/alaskan-malamute.png"
      },
      {
        "id": "2",
        "title": "Flutter in Action",
        "author": "Eric Windmill",
        "category": "Mobile Development",
        "image": "assets/icons/bull-terrier.png"
      },
      {
        "id": "3",
        "title": "Effective Java",
        "author": "Joshua Bloch",
        "category": "Programming",
      },
      {
        "id": "4",
        "title": "Design Patterns",
        "author": "Erich Gamma",
        "category": "Software Engineering",
      },
      {
        "id": "5",
        "title": "The Pragmatic Programmer",
        "author": "Andrew Hunt",
        "category": "Programming",
      },
      {
        "id": "6",
        "title": "JavaScript: The Good Parts",
        "author": "Douglas Crockford",
        "category": "Programming",
      },
      {
        "id": "7",
        "title": "You Don't Know JS",
        "author": "Kyle Simpson",
        "category": "Programming",
      },
      {
        "id": "8",
        "title": "Introduction to Algorithms",
        "author": "Thomas H. Cormen",
        "category": "Algorithms",
      },
      {
        "id": "9",
        "title": "Cracking the Coding Interview",
        "author": "Gayle Laakmann McDowell",
        "category": "Interview Preparation",
      },
      {
        "id": "10",
        "title": "Refactoring",
        "author": "Martin Fowler",
        "category": "Software Engineering",
      },
      {
        "id": "11",
        "title": "Head First Design Patterns",
        "author": "Eric Freeman",
        "category": "Software Engineering",
      },
      {
        "id": "12",
        "title": "The Clean Coder",
        "author": "Robert C. Martin",
        "category": "Programming",
      },
      {
        "id": "13",
        "title": "Programming Rust",
        "author": "Jim Blandy",
        "category": "Programming",
      },
      {
        "id": "14",
        "title": "Python Crash Course",
        "author": "Eric Matthes",
        "category": "Programming",
      },
      {
        "id": "15",
        "title": "Learning React",
        "author": "Alex Banks",
        "category": "Web Development",
      },
      {
        "id": "16",
        "title": "Eloquent JavaScript",
        "author": "Marijn Haverbeke",
        "category": "Programming",
      },
      {
        "id": "17",
        "title": "Effective Python",
        "author": "Brett Slatkin",
        "category": "Programming",
      },
      {
        "id": "18",
        "title": "Grokking Algorithms",
        "author": "Aditya Bhargava",
        "category": "Algorithms",
      },
      {
        "id": "19",
        "title": "Domain-Driven Design",
        "author": "Eric Evans",
        "category": "Software Engineering",
      },
      {
        "id": "20",
        "title": "The Mythical Man-Month",
        "author": "Frederick P. Brooks Jr.",
        "category": "Software Engineering",
      },
    ];
  }
}
