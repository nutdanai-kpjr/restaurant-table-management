import 'dart:convert';

class Member {
  final String? id;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String email;
  final String? tier;

  Member(
      {this.id,
      required this.firstName,
      required this.lastName,
      required this.phoneNumber,
      required this.email,
      this.tier});
  Member.fromJson(parsedJson)
      : id = parsedJson['memberID'],
        firstName = parsedJson['firstName'],
        lastName = parsedJson['lastName'],
        phoneNumber = parsedJson['phoneNumber'],
        email = parsedJson['email'],
        tier = parsedJson['tier'];

  Map<String, dynamic> toJson() => {
        'phoneNumber': phoneNumber,
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
      };

  String get fullName => '$firstName $lastName';
}
