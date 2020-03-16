class Post {
  final int id;
  final String body;

  Post({this.body, this.id});
}

class Comment {
  final String body;

  Comment({this.body});
}

class User {
  final String name;
  final String phoneNumber;

  User({
    this.name,
    this.phoneNumber,
  });
}

class LoginResponse {
  final bool success;
  final int userId;
  final String message;

  LoginResponse({
    this.success = true,
    this.userId,
    this.message,
  });
}
