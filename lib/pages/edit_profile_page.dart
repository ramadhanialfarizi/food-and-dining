import 'package:admin_aplication/pages/widget/fail_load_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/material.dart';

import '../controller/upload_controller.dart';

class EditProfilePages extends StatefulWidget {
  const EditProfilePages({super.key});

  @override
  State<EditProfilePages> createState() => _EditProfilePagesState();
}

class _EditProfilePagesState extends State<EditProfilePages> {
  String? imagePath;
  String? imageUpdate;
  String? email;
  final UploadHandler storage = UploadHandler();

  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var phoneNumberController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    firstNameController.dispose();
    lastNameController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

  dynamic getImage() async {
    final file = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ["png", "jpg"],
      allowMultiple: false,
    );

    if (file == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('no selected file'),
          duration: Duration(milliseconds: 800),
        ),
      );
      return null;
    }

    final path = file.files.single.path!;
    final fileName = file.files.single.name;

    storage.uploadImage(path, fileName);
    imageUpdate = await storage.getURLImage(fileName);

    print(imageUpdate);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final idParameter = ModalRoute.of(context)!.settings.arguments as String;
    CollectionReference collection =
        FirebaseFirestore.instance.collection("user_data");
    DocumentReference updateUserData = collection.doc(idParameter);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Your Profile',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(194, 249, 7, 108),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: FutureBuilder<DocumentSnapshot>(
                  future: updateUserData.get(),
                  builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return FailLoadScreen();
                    }
                    if (snapshot.hasData && !snapshot.data!.exists) {
                      return Text("Document does not exist");
                    }
                    if (snapshot.connectionState == ConnectionState.done) {
                      Map<String, dynamic> data =
                          snapshot.data!.data() as Map<String, dynamic>;

                      firstNameController.text = data["first_name"];
                      lastNameController.text = data["last_name"];
                      phoneNumberController.text = data["phone_number"];
                      email = data["email"];
                      imagePath = data["profil_picture"];

                      return Form(
                        key: formKey,
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 30,
                            ),
                            // "empty"
                            if (imagePath == null && imageUpdate == null) ...[
                              Container(
                                width: 150,
                                height: 150,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Color.fromARGB(194, 249, 7, 108),
                                    ),
                                    color: Color.fromARGB(255, 200, 200, 200)),
                              ),
                            ] else if (imageUpdate != null) ...[
                              Container(
                                width: 150,
                                height: 150,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Color.fromARGB(194, 249, 7, 108),
                                  ),
                                  image: DecorationImage(
                                    image: NetworkImage(imageUpdate!),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )
                            ] else ...[
                              Container(
                                width: 150,
                                height: 150,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Color.fromARGB(194, 249, 7, 108),
                                  ),
                                  image: DecorationImage(
                                    image: NetworkImage(imagePath!),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )
                            ],
                            const SizedBox(
                              height: 10,
                            ),
                            TextButton(
                              child: const Text(
                                'Upload Picture',
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                              ),
                              style: TextButton.styleFrom(
                                foregroundColor: Color.fromARGB(
                                    194, 249, 7, 108), // Text Color
                              ),
                              onPressed: () async {
                                getImage();
                              },
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            TextFormField(
                              controller: firstNameController,
                              decoration: InputDecoration(
                                hintText: 'First Name',
                                //filled: true,
                              ),
                              validator: (title) {
                                if (title == null || title.isEmpty) {
                                  return '* Silahkan masukan first name anda';
                                }
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              controller: lastNameController,
                              decoration: InputDecoration(
                                hintText: 'Last Name',
                                //filled: true,
                              ),
                              validator: (title) {
                                if (title == null || title.isEmpty) {
                                  return '* Silahkan masukan last name anda';
                                }
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              controller: phoneNumberController,
                              decoration: InputDecoration(
                                hintText: 'Email',
                                //filled: true,
                              ),
                              validator: (title) {
                                if (title == null || title.isEmpty) {
                                  return '* Silahkan masukan email anda';
                                }
                              },
                            ),
                          ],
                        ),
                      );
                    }
                    return Text("loading");
                  }),
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0.0,
        child: SizedBox(
          height: 60,
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          var isValidForm = formKey.currentState!.validate();

          if (isValidForm) {
            updateUserData.update({
              "first_name": firstNameController.text,
              "last_name": lastNameController.text,
              "email": email,
              "phone_number": phoneNumberController.text,
              "profil_picture": imageUpdate ?? "empty",
            });
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('profil berhasil ditambahkan'),
                duration: Duration(milliseconds: 800),
              ),
            );
            Navigator.pop(context);
          }
        },
        icon: const Icon(Icons.save),
        label: const Text('Save'),
        backgroundColor: Color.fromARGB(194, 249, 7, 108),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
