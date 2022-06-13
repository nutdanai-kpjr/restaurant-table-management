class Member {
  final String id;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String email;

  Member(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.phoneNumber,
      required this.email});
  Member.fromJson(parsedJson)
      : id = parsedJson['memberID'],
        firstName = parsedJson['firstName'],
        lastName = parsedJson['lastName'],
        phoneNumber = parsedJson['phoneNumber'],
        email = parsedJson['email'];

  String get fullName => '$firstName $lastName';
}
