import 'package:dummy1/Controller/PaymentController.dart';
import 'package:dummy1/Widgets/snackbar/Snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';

import '../Widgets/BottomNavigation/BottomNavigationBar.dart';
import 'SuccessScreen.dart';

/*class paymentAddressScreen extends StatefulWidget {
  const paymentAddressScreen({super.key});

  @override
  State<paymentAddressScreen> createState() => _paymentAddressScreenState();
}

class _paymentAddressScreenState extends State<paymentAddressScreen> {
  TextEditingController amountController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();

  final formkey = GlobalKey<FormState>();
  final formkey1 = GlobalKey<FormState>();
  final formkey2 = GlobalKey<FormState>();
  final formkey3 = GlobalKey<FormState>();
  final formkey4 = GlobalKey<FormState>();
  final formkey5 = GlobalKey<FormState>();
  final formkey6 = GlobalKey<FormState>();

  List<String> currencyList = <String>[
    'USD',
    'INR',
    'EUR',
    'JPY',
    'GBP',
    'AED'
  ];
  String selectedCurrency = 'USD';
  final controller = Get.put(PaymentController());

  bool hasDonated = false;
  Future<void> initPaymentSheet() async {
    try {
      // 1. create payment intent on the server
      final data = await controller.createPaymentIntent(
        // convert string to double
          amount: (int.parse(amountController.text) * 100).toString(),
          currency: selectedCurrency,
          name: nameController.text,
          address: addressController.text,
          pin: pincodeController.text,
          city: cityController.text,
          state: stateController.text,
          country: countryController.text);
      // 2. initialize the payment sheet
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          // Set to true for custom flow
          customFlow: false,
          // Main params
          merchantDisplayName: 'Flutter Stripe Store Demo',
          paymentIntentClientSecret: data['client_secret'],
          // Customer keys
          customerEphemeralKeySecret: data['ephemeralKey'],
          customerId: data['id'],
          style: ThemeMode.light,
        ),
      );
    } catch (e) {
        SnackBars.ErrorSnackBar(title:"Oh",message: e.toString());
      rethrow;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Billing Details",
                      style:
                          TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 5,
                          child: Form(
                            key: formkey,
                            child: TextFormField(
                              keyboardType: TextInputType.text,
                              decoration: const InputDecoration(
                                  label: Text("Amount"), hintText: "Amount"),
                              validator: (value) =>
                                  value!.isEmpty ? "Cannot be empty" : null,
                              controller: amountController,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        DropdownMenu<String>(
                          inputDecorationTheme: InputDecorationTheme(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 0),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ),
                          initialSelection: currencyList.first,
                          onSelected: (String? value) {
                            // This is called when the user selects an item.
                            setState(() {
                              selectedCurrency = value!;
                            });
                          },
                          dropdownMenuEntries: currencyList
                              .map<DropdownMenuEntry<String>>((String value) {
                            return DropdownMenuEntry<String>(
                                value: value, label: value);
                          }).toList(),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Form(
                      key: formkey1,
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                            label: Text("Name"), hintText: "Name"),
                        validator: (value) =>
                            value!.isEmpty ? "Cannot be empty" : null,
                        controller: nameController,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Form(
                      key: formkey2,
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                            label: Text("Address Line"), hintText: "Address"),
                        validator: (value) =>
                            value!.isEmpty ? "Cannot be empty" : null,
                        controller: addressController,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 5,
                          child: Form(
                            key: formkey3,
                            child: TextFormField(
                              keyboardType: TextInputType.text,
                              decoration: const InputDecoration(
                                  label: Text("City"), hintText: "City"),
                              validator: (value) =>
                                  value!.isEmpty ? "Cannot be empty" : null,
                              controller: cityController,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          flex: 5,
                          child: Form(
                            key: formkey4,
                            child: TextFormField(
                              keyboardType: TextInputType.text,
                              decoration: const InputDecoration(
                                  label: Text("State"), hintText: "State"),
                              validator: (value) =>
                                  value!.isEmpty ? "Cannot be empty" : null,
                              controller: stateController,
                            ),
                          ),
                        ),
                      ],),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 5,
                          child: Form(
                            key: formkey5,
                            child: TextFormField(
                              keyboardType: TextInputType.text,
                              decoration: const InputDecoration(
                                  label: Text("Country"), hintText: "Country"),
                              validator: (value) =>
                                  value!.isEmpty ? "Cannot be empty" : null,
                              controller: countryController,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          flex: 5,
                          child: Form(
                            key: formkey6,
                            child: TextFormField(
                              keyboardType: TextInputType.text,
                              decoration: const InputDecoration(
                                  label: Text("Pincode"), hintText: "Pincode"),
                              validator: (value) =>
                                  value!.isEmpty ? "Cannot be empty" : null,
                              controller: pincodeController,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent.shade400),
                        child: const Text(
                          "Proceed to Pay",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        onPressed: () async {
                          if (formkey.currentState!.validate() &&
                              formkey1.currentState!.validate() &&
                              formkey2.currentState!.validate() &&
                              formkey3.currentState!.validate() &&
                              formkey4.currentState!.validate() &&
                              formkey5.currentState!.validate() &&
                              formkey6.currentState!.validate()) {
                            await initPaymentSheet();

                            try {
                              await Stripe.instance.presentPaymentSheet();

                              Get.off(() => SuccessScreen(
                                  title: "Payment Success!",
                                  subTitle: "Your Payment has been done",
                                  image: "assets/images/success/download.png",
                                  onPressed: () => Get.to(() => const NavigationMenu())));

                              /*setState(() {
                                hasDonated = true;
                              });
                              nameController.clear();
                              addressController.clear();
                              cityController.clear();
                              stateController.clear();
                              countryController.clear();
                              pincodeController.clear();*/
                            } catch (e) {
                              print("payment sheet failed");
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    "Payment Failed",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  backgroundColor: Colors.redAccent,
                                ),
                              );
                            }
                          }
                        },
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}*/
