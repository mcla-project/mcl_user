import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mcl_user/components/base_layout.dart';
import '../../utils/get_doc_id.dart';
import '../../utils/get_user.dart';
import '../../utils/get_user_information.dart';

class UpdateProfilePage extends StatefulWidget {
  final Function(Widget) navigateToPage;

  const UpdateProfilePage({
    Key? key,
    required this.navigateToPage,
  }) : super(key: key);

  @override
  State<UpdateProfilePage> createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  final UserDataService userDataService = UserDataService();
  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _occupationController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  GlobalKey<FormState> key = GlobalKey();
  String imageUrl = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Update Information',
          style: TextStyle(
            color: Colors.white, // Set text color to white
            fontWeight: FontWeight.bold, // Make text bold
          ),
        ),
        backgroundColor: Color.fromARGB(255, 27, 63, 49), // Set background color
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop(); // Navigate back to the previous screen
          },
          color: Colors.white, // Set icon color to white
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: const Color(0xFF013822),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        ImagePicker imagePicker = ImagePicker();
                        XFile? file = await imagePicker.pickImage(
                            source: ImageSource
                                .gallery); // Select image from gallery

                        if (file == null) return;

                        String uniqueFileName =
                            DateTime.now().millisecondsSinceEpoch.toString();

                        Reference referenceRoot =
                            FirebaseStorage.instance.ref();
                        Reference referenceDirImages =
                            referenceRoot.child('images');

                        Reference referenceImageToUpload =
                            referenceDirImages.child(uniqueFileName);

                        try {
                          //Store the file
                          await referenceImageToUpload.putFile(File(file.path));
                          //Success: get the download URL
                          imageUrl =
                              await referenceImageToUpload.getDownloadURL();

                          if (imageUrl.isEmpty) {
                            if (mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Please upload an image')));
                            }
                            return;
                          }
                        } catch (error) {
                          return;
                        }
                      },
                      child: const CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.white70,
                        child:
                            Icon(Icons.upload_file, color: Color(0xFF013822)),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            UserInfoWidget(
                                getDocData: userDataService.getDocData,
                                fieldName: 'first_name',
                                color: Colors.white),
                            UserInfoWidget(
                                getDocData: userDataService.getDocData,
                                fieldName: 'last_name',
                                color: Colors.white),
                          ],
                        ),
                        UserInfoWidget(
                            getDocData: userDataService.getDocData,
                            fieldName: 'library_card_number',
                            color: Colors.white),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10.0),
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(bottom: 10.0),
                    child: TextFormField(
                      controller: _firstnameController,
                      decoration: InputDecoration(
                        labelText: 'First Name',
                        fillColor: Colors.grey[200],
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 10.0),
                    child: TextFormField(
                      controller: _lastnameController,
                      decoration: InputDecoration(
                        labelText: 'Last Name',
                        fillColor: Colors.grey[200],
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 10.0),
                    child: TextFormField(
                      controller: _occupationController,
                      decoration: InputDecoration(
                        labelText: 'School/Office',
                        fillColor: Colors.grey[200],
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 10.0),
                    child: TextFormField(
                      controller: _occupationController,
                      decoration: InputDecoration(
                        labelText: 'Occupation',
                        fillColor: Colors.grey[200],
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 10.0),
                    child: TextFormField(
                      controller: _addressController,
                      decoration: InputDecoration(
                        labelText: 'Address',
                        fillColor: Colors.grey[200],
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 10.0),
                    child: TextFormField(
                      controller: _phoneController,
                      decoration: InputDecoration(
                        labelText: 'Contact Number',
                        fillColor: Colors.grey[200],
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      keyboardType: TextInputType.phone,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 10.0),
                    child: TextFormField(
                      controller: _phoneController,
                      decoration: InputDecoration(
                        labelText: 'Birthdate',
                        fillColor: Colors.grey[200],
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      keyboardType: TextInputType.phone,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 10.0),
                    child: TextFormField(
                      controller: _phoneController,
                      decoration: InputDecoration(
                        labelText: 'Sex',
                        fillColor: Colors.grey[200],
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      keyboardType: TextInputType.phone,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color(0xFF013822)),
                    ),
                    onPressed: updateUserProfile,
                    child: const Text(
                      'Save Changes',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void updateUserProfile() async {
    final DocIDService docIDService = DocIDService();
    try {
      String? userID = await docIDService.getDocId();

      if (imageUrl.isNotEmpty) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userID)
            .update({
          'photo_url': imageUrl,
        });
      }

      await FirebaseFirestore.instance.collection('users').doc(userID).update({
        'first_name': _firstnameController.text.trim(),
        'last_name': _lastnameController.text.trim(),
        'occupation': _occupationController.text.trim(),
        'address': _addressController.text.trim(),
        'phone_number': _phoneController.text.trim(),
        'photo_url': imageUrl,
      }).then((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Profile Information Successfully Updated"),
          ),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const BaseLayout()),
        );
      }).catchError((error) {
        return;
      });
    } catch (e) {
      return;
    }
  }
}
