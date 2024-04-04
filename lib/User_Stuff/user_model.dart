/*class User {
  final String firstName;
  final String lastName;
  final String pin;

  User({required this.firstName, required this.lastName, required this.pin});
}
*/

class User {
  final String firstName;
  final String lastName;
  final String pin;
  final int userType; // New field
  final int completedTrainings; // New field

  User({
    required this.firstName,
    required this.lastName,
    required this.pin,
    this.userType = 0, // Default value, adjust as needed
    this.completedTrainings = 0, // Default value
  });

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'pin': pin,
      'userType': userType,
      'completedTrainings': completedTrainings,
    };
  }

  // Add a method to create a User from a Map
  static User fromMap(Map<String, dynamic> map) {
    return User(
      firstName: map['firstName'],
      lastName: map['lastName'],
      pin: map['pin'],
      userType: map['userType'],
      completedTrainings: map['completedTrainings'],
    );
  }
}
