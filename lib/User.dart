class User {
  final String firstName;
  final String lastName;
  final String pin;
  final int userType;
  final int completedTrainings;
  final int quiz1Completed;
  final int quiz2Completed;

  User({
    required this.firstName,
    required this.lastName,
    required this.pin,
    required this.userType,
    required this.completedTrainings,
    required this.quiz1Completed,
    required this.quiz2Completed,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      firstName: map['firstName'],
      lastName: map['lastName'],
      pin: map['pin'],
      userType: map['userType'],
      completedTrainings: map['completedTrainings'],
      quiz1Completed: map['quiz1Completed'],
      quiz2Completed: map['quiz2Completed'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'pin': pin,
      'userType': userType,
      'completedTrainings': completedTrainings,
      'quiz1Completed': quiz1Completed,
      'quiz2Completed': quiz2Completed,
    };
  }
}
