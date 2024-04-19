// Defines a User model class to manage user data within the app.
class User {
  // User properties
  final String firstName;
  final String lastName;
  final String pin;
  final int userType; // Represents the type of user (e.g., admin=1, regular=0)
  final int completedTrainings; // Number of trainings the user has completed
  bool quiz1Completed; // Status of completion for quiz 1
  bool quiz2Completed; // Status of completion for quiz 2

  // Constructor for the User class with optional parameters for flexibility
  User({
    required this.firstName,
    required this.lastName,
    required this.pin,
    this.userType = 0, // Default to regular user if not specified
    this.completedTrainings = 0, // Default to no trainings completed
    this.quiz1Completed = false, // Default to quiz 1 not completed
    this.quiz2Completed = false, // Default to quiz 2 not completed
  });

  // Converts a User object into a map to facilitate database operations
  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'pin': pin,
      'userType': userType,
      'completedTrainings': completedTrainings,
      'quiz1Completed': quiz1Completed ? 1 : 0, // Store boolean as integer
      'quiz2Completed': quiz2Completed ? 1 : 0, // Store boolean as integer
    };
  }

  // Constructs a User object from a map, typically used when retrieving data from a database
  static User fromMap(Map<String, dynamic> map) {
    return User(
      firstName: map['firstName'],
      lastName: map['lastName'],
      pin: map['pin'],
      userType: map['userType'],
      completedTrainings: map['completedTrainings'],
      quiz1Completed: map['quiz1Completed'] == 1, // Convert integer back to boolean
      quiz2Completed: map['quiz2Completed'] == 1, // Convert integer back to boolean
    );
  }
}
