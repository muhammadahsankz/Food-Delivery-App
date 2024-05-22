import 'package:flutter/material.dart';
import 'package:food_delivery_app/styles/custom_colors.dart';
import 'package:food_delivery_app/styles/text_styles.dart';

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
  final _formKey = GlobalKey<FormState>();
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
                  Icon(Icons.arrow_back_ios_new_outlined),
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
                  Container(
                    height: 200,
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(horizontal: 30),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Center(
                      child: Icon(Icons.camera_alt_outlined),
                    ),
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
                        return 'Enter item name';
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
                        return 'Enter item price';
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
                        return 'Enter item type';
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
                    'Description',
                    style: TextStyles.nameHeadingTextStyle(size: 15),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: itemDescriptionController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter item description';
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
                  Icon(Icons.arrow_drop_down),
                  SizedBox(height: 30),
                  GestureDetector(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {}
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
