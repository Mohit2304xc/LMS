//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dummy1/Model/Usermodel.dart';

class AddressModel {
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
  bool selectedAddress;

  AddressModel({
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
    this.selectedAddress = true,
  });

  String get formattedPhoneNo => formatter.formatPhoneNumber(phoneNumber);

  static AddressModel empty() => AddressModel(
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
      'selectedAddress': selectedAddress,
      'city': city,
      'country': country,
      'dateTime': dateTime,
    };
  }

  factory AddressModel.fromJson(Map<String, dynamic> document) {
    return AddressModel(
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
      selectedAddress: document['selectedAddress'] == '1',
    );
  }

  /*factory AddressModel.fromMap(Map<String, dynamic> data) {
    return AddressModel(
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

  /*factory AddressModel.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return AddressModel(
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
