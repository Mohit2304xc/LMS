//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dummy1/Model/Usermodel.dart';

class AddressPostModel {
  String id;
  final String userId;
  final String name;
  final String phoneNumber;
  final String street;
  final String city;
  final String state;
  final String postalCode;
  final String country;
  final DateTime? dateTime;

  AddressPostModel({
    required this.userId,
    required this.name,
    required this.id,
    required this.state,
    required this.street,
    required this.phoneNumber,
    required this.postalCode,
    required this.country,
    required this.city,
    this.dateTime,
  });

  String get formattedPhoneNo => formatter.formatPhoneNumber(phoneNumber);

  static AddressPostModel empty() => AddressPostModel(
      name: '',
      id: '',
      state: '',
      street: '',
      phoneNumber: '',
      postalCode: '',
      country: '',
      city: '',
      userId: '');

  Map<String, dynamic> toJson() {
    return {
      'id': id.toString(),
      'user_id': userId.toString(),
      'name': name,
      'street': street,
      'phoneNumber': phoneNumber,
      'postalCode': postalCode,
      'state': state,
      'city': city,
      'country': country,
      'dateTime': dateTime,
    };
  }

  factory AddressPostModel.fromJson(Map<String, dynamic> document) {
    return AddressPostModel(
      userId: document["user_id"].toString(),
      name: document["name"],
      id: document["id"].toString(),
      state: document["state"],
      street: document["street"],
      phoneNumber: document['phoneNumber'],
      postalCode: document['postalCode'],
      country: document['country'],
      city: document["city"],
      dateTime: DateTime.parse(document["dateTime"]),
    );
  }

  /*factory AddressPostModel.fromMap(Map<String, dynamic> data) {
    return AddressPostModel(
      name: data['Name'] as String,
      id: data['Id'] as String,
      state: data['State'] as String,
      street: data['Street'] as String,
      phoneNumber: data['Phone Number'] as String,
      postalCode: data['Postal Code'] as String,
      country: data['Country'] as String,
      city: data['City'] as String,
      selectedAddress: data['Selected Address'] as bool,
      dateTime: (data['Date Time'] as Timestamp).toDate(),
    );
  }*/

  /*factory AddressPostModel.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return AddressPostModel(
      name: data['Name'] ?? '',
      id: snapshot.id,
      state: data['State'] ?? '',
      street: data['Street'] ?? '',
      phoneNumber: data['Phone Number'] ?? '',
      postalCode: data['Postal Code'] ?? '',
      country: data['Country'] ?? '',
      city: data['City'] ?? '',
      selectedAddress: data['Selected Address'] as bool,
      dateTime: (data['Date Time'] as Timestamp).toDate(),
    );
  }*/

  @override
  String toString() {
    return '$street,$city,$state,$postalCode,$country';
  }
}
