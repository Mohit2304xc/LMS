//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class UserModel {
  final String id;
  String firstname;
  String lastname;
  final String username;
  final String email;
  String phonenumber;
  String? profilePicture;
  String password;

  UserModel({
    required this.password,
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.username,
    required this.email,
    required this.phonenumber,
    this.profilePicture,
  });

  String get fullName => '$firstname $lastname';

  String get formattedPhoneNo => formatter.formatPhoneNumber(phonenumber);

  static List<String> nameParts(fullName) => fullName.split(" ");

  static String generateUserName(fullName) {
    List<String> nameParts = fullName.split(" ");
    String firstName = nameParts[0].toLowerCase();
    String lastName = nameParts.length > 1 ? nameParts[1].toLowerCase() : "";

    String camelCaseUsername = "$firstName$lastName";
    String usernameWithPrefix = "cwt_$camelCaseUsername";
    return usernameWithPrefix;
  }

  static UserModel empty() => UserModel(
      id: '',
      firstname: '',
      lastname: '',
      username: '',
      email: '',
      phonenumber: '',
      profilePicture: '',
      password: '');

  Map<String, dynamic> toJson() => {
        'firstname': firstname,
        'lastname': lastname,
        'username': username,
        'email': email,
        'phonenumber': phonenumber,
        'password': password,
      };

  factory UserModel.fromJson(Map<String, dynamic> document) {
    return UserModel(
      id: int.parse(document["user_id"]).toString(),
      firstname: document["firstname"],
      lastname: document["lastname"],
      password: document["password"],
      username: document["username"],
      email: document["email"],
      phonenumber: document["phonenumber"], profilePicture: '',
    );
  }

  /*factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return UserModel(
        id: document.id,
        firstName: data['FirstName'] ?? '',
        lastName: data['LastName'] ?? '',
        username: data['Username'] ?? '',
        email: data['Email'] ?? '',
        phoneNumber: data['PhoneNumber'] ?? '',
        profilePicture: data['ProfilePicture'] ?? '',
        password: '',
      );
    } else {
      return UserModel.empty();
    }
  }*/
}

class formatter {
  static String formatDate(DateTime? date) {
    date ??= DateTime.now();
    return DateFormat('dd-MM-yyyy').format(date);
  }

  static String formatCurrency(double amount) {
    return NumberFormat.currency(locale: 'en_US', symbol: '£').format(amount);
  }

  static String formatPhoneNumber(String phoneNumber) {
    if (phoneNumber.length == 10) {
      return '(${phoneNumber.substring(0, 3)}) ${phoneNumber.substring(3, 6)} ${phoneNumber.substring(6)}';
    } else if (phoneNumber.length == 11) {
      return '(${phoneNumber.substring(0, 4)}) ${phoneNumber.substring(4, 7)} ${phoneNumber.substring(7)}';
    }
    return phoneNumber;
  }
}
