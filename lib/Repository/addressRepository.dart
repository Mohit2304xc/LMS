//import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';

import 'package:dummy1/Controller/UserController.dart';
import 'package:dummy1/Widgets/API_Connection/API_connection.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../Model/AddressModel.dart';
import '../Widgets/snackbar/Snackbar.dart';
import 'AuthenticationRepository.dart';

class AddressRepository extends GetxController {
  static AddressRepository get instance => Get.find();

  //final _db = FirebaseFirestore.instance;

  Future<List<AddressModel>> fetchUserAddresses() async {
    try {
      final userId = UserController.instance.user.value.id;
      if (userId.isEmpty) {
        throw 'Unable to find User information. Try again later.';
      }

      final res = await http.post(
        Uri.parse(API.userAddress),
        body: {'user_id': userId},
      );

      if (res.statusCode == 200) {
        final response = json.decode(res.body);
        print(response);
        if (response["success"] == true) {
          final List<dynamic> addressDataList = response["addresses"];
          List<AddressModel> addresses = addressDataList.map((data) {
            return AddressModel.fromJson(data);
          }).toList();
          print(addresses);
          return addresses;
        } else {
          throw "No Address Found Associated with this Account!";
        }
      } else {
        throw Exception('Failed to load addresses: ${res.statusCode}');
      }

      /*final result = await _db.collection('Users').doc(userId).collection(
          'Addresses').get();
      return result.docs.map((documentSnapshot) =>
          AddressModel.fromDocumentSnapshot(documentSnapshot)).toList();*/
    } catch (e) {
      SnackBars.ErrorSnackBar(
          title: 'Failed to load addresses', message: e.toString());
      return [];
    }
  }

  Future<void> updateSelectedField(String addressId, bool selected) async {
    try {
      Map<String, dynamic> body = {
        'id': addressId,
        'selectedAddress': selected ? '1' : '0'
      };

      final response = await http.post(
        Uri.parse(API.updateSelectedAddress),
        body: body,
      );
      print(response);

      if (response.statusCode == 200) {
        final res = jsonDecode(response.body);
        if (res["success"] == true) {
          SnackBars.SuccessSnackBar(title: "success");
        }
        else {
          SnackBars.ErrorSnackBar(title: "Error");
        }
      } else {
        throw 'Failed to update address selection: ${response.statusCode}';
      }
    } catch (e) {
      SnackBars.ErrorSnackBar(title: "title",message: e.toString());
    }
  }

  Future<String> addAddress(AddressModel address) async {
    try {
      final userId = UserController.instance.user.value.id;
      final body = {
        'user_id': userId,
        'name': address.name,
        'phoneNumber': address.phoneNumber,
        'street': address.street,
        'city': address.city,
        'state': address.state,
        'postalCode': address.postalCode,
        'country': address.country,
        'selectedAddress': address.selectedAddress ? '1' : '0',
        'dateTime': DateTime.now().toString(),
      };
      print(body);
      final response = await http.post(
          Uri.parse(API.addnewaddress),
          body: body
      );
      if (response.statusCode == 200) {
        if (response.body.isNotEmpty) {
          final responseData = json.decode(response.body);
          print(responseData);
          if (responseData['success'] == true) {
            SnackBars.SuccessSnackBar(
                message: 'Address added successfully',
                title: "Congratulations");
            return responseData['id'].toString();
          } else {
            throw 'Failed to add address: ${responseData['success']}';
          }
        } else {
          throw 'Empty response body';
        }
      } else {
        throw 'Failed to add addres: ${response.reasonPhrase}';
      }
    } catch (e) {
      print(e);
      throw 'Unable to add your address. Try again later ${e.toString()}';
    }
  }
}
