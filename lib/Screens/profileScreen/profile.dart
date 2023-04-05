import 'dart:io';
import 'package:epark/providers/userProvider.dart';
import 'package:epark/screens/profileScreen/updatePassword.dart';
import 'package:epark/measure/measure.dart';
import 'package:epark/measure/registerPage_responsive.dart';
import 'package:epark/models/user.dart';
import 'package:epark/repository/userRepo.dart';
import 'package:epark/theme/themeData.dart';
import 'package:epark/validation/registerValidation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  static const String route = "/profileScreen";

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  // Bottom sheet functions
  Widget _bottomInfo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        // Camera
        ElevatedButton.icon(
          onPressed: () {
            setImage(ImageSource.camera);
          },
          icon: const Icon(Icons.camera),
          label: const Text('Camera'),
        ),
        // Gallery
        ElevatedButton.icon(
          onPressed: () {
            setImage(ImageSource.gallery);
          },
          icon: const Icon(Icons.image),
          label: const Text('Gallery'),
        )
      ],
    );
  }

  // Set Image
  void setImage(ImageSource imageSource) async {
    final image = await ImagePicker().pickImage(source: imageSource);
    if (image != null) {
      setState(() {
        _apiImg = null;
        _img = File(image.path);
      });
    } else {
      Fluttertoast.showToast(
          textColor: Colors.white,
          gravity: ToastGravity.CENTER,
          msg: "No Image Selected");
    }
  }

  // User data
  User user = User();

  // Loading
  bool _loading = false;

  // Link TextStyle
  final TextStyle _linkStyle = const TextStyle(
      fontFamily: "Signika",
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: Colors.white,
      decoration: TextDecoration.underline);

  // Controllers
  final TextEditingController _fullNameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _phoneNumberController = TextEditingController();

  final TextEditingController _usernameController = TextEditingController();
  // File image for local screen
  File? _img;
  // File image to recieve from api
  String? _apiImg;
  // Form validation
  final _formKey = GlobalKey<FormState>();

  // Updated Profile
  void _updateProfile() async {
    User newUser = User(
        fullname: _fullNameController.text,
        email: _emailController.text,
        contact: _phoneNumberController.text,
        username: _usernameController.text);
    int status =
        await UserRepositoryImpl().updateProfile(_img, user.user_id!, newUser);
    _checkStatus(status);
  }

  // Message
  void _checkStatus(int status) {
    if (status > 0) {
      setState(() {
        _loading = false;
      });
      successBar(context, "Please login again to see changes");
    } else {
      setState(() {
        _loading = false;
      });
      invalidBar(context, "Please check your network!");
    }
  }

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 1), () {
      user = ref.watch(UserProvider.userProvider);
    }).then((value) {
      _fullNameController.text = user.fullname!;
      _emailController.text = user.email!;
      _phoneNumberController.text = user.contact!;
      _usernameController.text = user.username!;
      if (user.profileImage != null &&
          user.profileImage != "" &&
          user.profileImage != "none") {
        setState(() {
          _apiImg = user.profileImage;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Profile"),
        centerTitle: true,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          color: DARK_GREY_COLOR,
          height: phoneHeight(context),
          width: phoneWidth(context),
          padding: responsiveForWidth(context),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  responsiveForHeight(context),
                  // Profile Picture
                  SizedBox(
                    width: 150,
                    height: 180,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 150,
                          height: 150,
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(75),
                              color: Colors.grey,
                              image: _apiImg != null
                                  ? DecorationImage(
                                      fit: BoxFit.fill,
                                      image: NetworkImage(
                                          "http://10.0.2.2:3001/$_apiImg"))
                                  : _img == null
                                      ? const DecorationImage(
                                          fit: BoxFit.fill,
                                          image: AssetImage(
                                              "assets/images/default.jpg"))
                                      : DecorationImage(
                                          fit: BoxFit.fill,
                                          image: FileImage(_img!))),
                          alignment: Alignment.bottomCenter,
                          child: InkWell(
                            onTap: () {
                              // Bottom sheet (Camera and gallery)
                              showModalBottomSheet(
                                backgroundColor: Colors.grey[300],
                                context: context,
                                isScrollControlled: true,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(20),
                                  ),
                                ),
                                builder: (context) => Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: _bottomInfo(),
                                ),
                              );
                            },
                            child: Container(
                              height: 50,
                              width: double.infinity,
                              color: const Color.fromARGB(176, 116, 116, 116),
                              child: const Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              _img = null;
                              _apiImg = null;
                            });
                          },
                          child: const Text(
                            "Remove Photo",
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  responsiveForHeight(context),
// ------------------------ Full name ------------------------------------------
                  textFormField(context, "Full Name", const Icon(Icons.person),
                      controller: _fullNameController,
                      validator: nameValidator,
                      testKey: "fullNameKey"),
                  responsiveForHeight1(context),
// ------------------------ Email ------------------------------------------
                  textFormField(
                      context, "Email (Optional)", const Icon(Icons.email),
                      controller: _emailController,
                      validator: emailValidator,
                      testKey: "emailKey"),
                  responsiveForHeight1(context),
// ------------------------ Phone ------------------------------------------
                  textFormField(
                      context,
                      "(+977) Contact",
                      const Icon(
                        Icons.phone,
                      ),
                      keyboardType: TextInputType.number,
                      controller: _phoneNumberController,
                      validator: phoneNumberValidator,
                      testKey: "contactKey"),
                  responsiveForHeight1(context),
// ------------------------ Username ------------------------------------------
                  textFormField(context, "Username", const Icon(Icons.person),
                      controller: _usernameController,
                      validator: nameValidator,
                      testKey: "usernameKey"),
                  responsiveForHeight1(context),
                  gap30,
// ------------------------ Update ------------------------------------------
                  SizedBox(
                    width: phoneWidth(context),
                    height: 45,
                    child: ElevatedButton(
                      style: const ButtonStyle(
                          // textStyle: MaterialStatePropertyAll(
                          //     TextStyle(color: DARK_GREY_COLOR)),
                          backgroundColor:
                              MaterialStatePropertyAll(DARK_YELLOW_COLOR)),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            _loading = true;
                          });
                          _updateProfile();
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "UPDATE",
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          _loading == true
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Text("")
                        ],
                      ),
                    ),
                  ),
                  responsiveForHeight1(context),
                  // Update Profile
                  InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                            context, UpdatePasswordScreen.route);
                      },
                      child: Text("Update Password?", style: _linkStyle)),
                  gap10
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
