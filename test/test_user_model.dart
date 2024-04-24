import 'package:test/test.dart';
import 'package:mockito/mockito.dart';
import 'package:training_app/User_Stuff/user_model.dart';  // Adjust the path to where the User class is located

void main() {
  group('User Model Tests', () {
    test('User constructor assigns values correctly', () {
      var user = User(
          firstName: 'John',
          lastName: 'Doe',
          pin: '1234',
          userType: 1,
          completedTrainings: 5,
          quiz1Completed: true,
          quiz2Completed: false
      );
      expect(user.firstName, equals('John'));
      expect(user.lastName, equals('Doe'));
      expect(user.pin, equals('1234'));
      expect(user.userType, equals(1));
      expect(user.completedTrainings, equals(5));
      expect(user.quiz1Completed, true);
      expect(user.quiz2Completed, false);
    });

    test('Default values are set correctly', () {
      var user = User(firstName: 'Jane', lastName: 'Smith', pin: '4321');
      expect(user.userType, equals(0));
      expect(user.completedTrainings, equals(0));
      expect(user.quiz1Completed, isFalse);
      expect(user.quiz2Completed, isFalse);
    });

    test('toMap method outputs correct map', () {
      var user = User(
          firstName: 'Alice',
          lastName: 'Johnson',
          pin: '5678',
          userType: 0,
          completedTrainings: 3,
          quiz1Completed: false,
          quiz2Completed: true
      );
      var userMap = user.toMap();
      expect(userMap, equals({
        'firstName': 'Alice',
        'lastName': 'Johnson',
        'pin': '5678',
        'userType': 0,
        'completedTrainings': 3,
        'quiz1Completed': 0,
        'quiz2Completed': 1
      }));
    });
  });
}
