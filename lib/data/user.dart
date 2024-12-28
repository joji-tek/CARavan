class User {
  final String name;
  final String contactNumber;

  User({
    required this.name,
    required this.contactNumber,
  });

  // Factory method to create a User object from a map
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      name: map['name'],
      contactNumber: map['contactNumber'],
    );
  }

  // Convert the User object into a map (for saving or transferring data)
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'contactNumber': contactNumber,
    };
  }
}

// Sample user data with initial details
final List<User> users = [
  User(
    name: 'Mitchell Smith',
    contactNumber: '09123456789',
  ),
];
