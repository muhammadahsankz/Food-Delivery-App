import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/services/firestore_database.dart';
import 'package:food_delivery_app/styles/custom_colors.dart';
import 'package:food_delivery_app/styles/text_styles.dart';
import 'package:food_delivery_app/widgets/custom_snackbar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';

class AdminAddItemScreen extends StatefulWidget {
  const AdminAddItemScreen({super.key});

  @override
  State<AdminAddItemScreen> createState() => _AdminAddItemScreenState();
}

class _AdminAddItemScreenState extends State<AdminAddItemScreen> {
  final itemNameController = TextEditingController();
  final itemPriceController = TextEditingController();
  final itemDescriptionController = TextEditingController();
  final itemTypeController = TextEditingController();
  final itemDeliveryTimeController = TextEditingController();
  List<String> dropdownItems = ['Burger', 'Pizza', 'Ice-Cream', 'Salad'];
  String? dropdownValues;
  final _formKey = GlobalKey<FormState>();
  final _imagePicker = ImagePicker();
  File? selectedImage;

  // Pick Image Function
  Future getImage() async {
    var image = await _imagePicker.pickImage(source: ImageSource.gallery);
    selectedImage = File(image!.path);
    setState(() {});
  }

  // Upload Item on Firebase
  uploadItem() async {
    if (selectedImage != null &&
        itemNameController.text != '' &&
        itemPriceController.text != '' &&
        itemDescriptionController.text != '' &&
        itemTypeController.text != '' &&
        itemDeliveryTimeController.text != '') {
      String addId = randomAlphaNumeric(10);
      Reference firebaseStorageRef = FirebaseStorage.instanceFor(
              bucket: 'gs://food-delivery-app-fd20e.appspot.com')
          .ref()
          .child('itemImages')
          .child(addId);
      final UploadTask task = firebaseStorageRef.putFile(selectedImage!);
      var downloadUrl = await (await task).ref.getDownloadURL();
      Map<String, dynamic> addItem = {
        'Image': downloadUrl,
        'Name': itemNameController.text,
        'Price': int.parse(itemPriceController.text),
        'Description': itemDescriptionController.text,
        'Type': itemTypeController.text,
        'DeliveryTime': int.parse(itemDeliveryTimeController.text),
      };
      await FirestoreDatabaseMethods.addFoodItem(addItem, dropdownValues!)
          .then((value) {
        CustomSnackbar.customSnackbar(context, 'Item added Successfully');
        Navigator.pop(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 50),
          Material(
            elevation: 2,
            child: Container(
              padding: EdgeInsets.only(bottom: 10, left: 20),
              width: double.infinity,
              child: Row(
                children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.arrow_back_ios_new_outlined)),
                  SizedBox(width: 20),
                  Text(
                    'Add Item',
                    style: TextStyles.mainHeadingTextStyle(),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Form(
              key: _formKey,
              child: ListView(
                padding: EdgeInsets.all(20),
                children: [
                  Text(
                    'Upload Image',
                    style: TextStyles.nameHeadingTextStyle(size: 15),
                  ),
                  SizedBox(height: 10),
                  selectedImage == null
                      ? GestureDetector(
                          onTap: getImage,
                          child: Container(
                            height: 200,
                            // width: 200,
                            margin: EdgeInsets.symmetric(horizontal: 50),
                            // padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(40),
                            ),
                            child: Center(
                              child: Icon(Icons.camera_alt_outlined),
                            ),
                          ),
                        )
                      : Container(
                          height: 200,
                          // width: 200,
                          margin: EdgeInsets.symmetric(horizontal: 50),
                          // padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            // border: Border.all(),

                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(40),
                              child:
                                  Image.file(fit: BoxFit.fill, selectedImage!)),
                        ),
                  SizedBox(height: 30),
                  Text(
                    'Name',
                    style: TextStyles.nameHeadingTextStyle(size: 15),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: itemNameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Item Name is required';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      hintText: 'e.g.  Spicy Thai Chicken Salad',
                      hintStyle: TextStyles.belowMainHeadingTextStyle(),
                    ),
                  ),
                  SizedBox(height: 30),
                  Text(
                    'Price',
                    style: TextStyles.nameHeadingTextStyle(size: 15),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: itemPriceController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Price is required';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      hintText: 'e.g.  12.98',
                      hintStyle: TextStyles.belowMainHeadingTextStyle(),
                    ),
                  ),
                  SizedBox(height: 30),
                  Text(
                    'Type',
                    style: TextStyles.nameHeadingTextStyle(size: 15),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: itemTypeController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Item type is required';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      hintText: 'e.g.  Asian',
                      hintStyle: TextStyles.belowMainHeadingTextStyle(),
                    ),
                  ),
                  SizedBox(height: 30),
                  Text(
                    'Delivery Time',
                    style: TextStyles.nameHeadingTextStyle(size: 15),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: itemDeliveryTimeController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Delivery time is required';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      hintText: 'e.g.  35',
                      hintStyle: TextStyles.belowMainHeadingTextStyle(),
                    ),
                  ),
                  SizedBox(height: 30),
                  Text(
                    'Description',
                    style: TextStyles.nameHeadingTextStyle(size: 15),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: itemDescriptionController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Description is required';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.name,
                    maxLines: 5,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      hintText:
                          'e.g.  Grilled chicken strips tossed with shredded vegetables...',
                      hintStyle: TextStyles.belowMainHeadingTextStyle(),
                    ),
                  ),
                  SizedBox(height: 30),
                  Text(
                    'Category',
                    style: TextStyles.nameHeadingTextStyle(size: 15),
                  ),
                  SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(),
                    ),
                    child: Center(
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                            alignment: Alignment.center,
                            hint: Text(
                              'Select Catregory',
                              style: TextStyles.belowMainHeadingTextStyle(),
                            ),
                            value: dropdownValues,
                            icon: Icon(Icons.keyboard_arrow_down),
                            items: dropdownItems
                                .map(
                                  (item) => DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: TextStyles
                                          .belowMainHeadingTextStyle(),
                                    ),
                                  ),
                                )
                                .toList(),
                            onChanged: (newValue) {
                              dropdownValues = newValue;
                              setState(() {});
                            }),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  GestureDetector(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {}
                      uploadItem();
                    },
                    child: Container(
                      height: 50,
                      width: 100,
                      margin: EdgeInsets.symmetric(horizontal: 30),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: CustomColors.green,
                      ),
                      child: Center(
                        child: Text(
                          'Add Item',
                          style: TextStyles.nameHeadingTextStyle(size: 15),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
