import 'package:epark/measure/measure.dart';
import 'package:epark/providers/userProvider.dart';
import 'package:epark/repository/userRepo.dart';
import 'package:epark/theme/themeData.dart';
import 'package:epark/validation/registerValidation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SecurityScreen extends ConsumerStatefulWidget {
  const SecurityScreen({Key? key}) : super(key: key);
  static const route = "/security";
  @override
  ConsumerState<SecurityScreen> createState() => _SecurityScreenState();
}

class _SecurityScreenState extends ConsumerState<SecurityScreen> {
  final style =
      const TextStyle(fontSize: 18, color: Color.fromARGB(255, 48, 48, 48));

  final style1 = const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Color.fromARGB(255, 48, 48, 48));

  final _formkey1 = GlobalKey<FormState>();

  final _forgotPassword = TextEditingController();

  final _password = TextEditingController();

  bool obscureText = true;
  bool _loading = false;

  void _checkPassword() async {
    String username = ref.watch(UserProvider.userProvider).username!;
    bool status =
        await UserRepositoryImpl().checkPassword(username, _password.text);

    if (status) {
      setState(() {
        _loading = false;
        obscureText = false;
      });
    } else {
      setState(() {
        _loading = false;
        invalidBar(context, "Password did not match");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _forgotPassword.text = ref.watch(UserProvider.userProvider).forgetPassword!;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Security"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
                "Use this password to login. In any case, you forgot regsitererd password."),
            gap20,
            TextFormField(
              readOnly: true,
              validator: passwordValidator,
              controller: _forgotPassword,
              obscureText: obscureText,
              decoration: InputDecoration(
                contentPadding: phoneHeight(context) > 850
                    ? const EdgeInsets.all(20)
                    : const EdgeInsets.all(0),
                filled: true,
                fillColor: Colors.white,
                suffix: _loading
                    ? const SizedBox(
                        width: 28,
                        height: 20,
                        child: Padding(
                          padding: EdgeInsets.only(right: 8.0),
                          child: CircularProgressIndicator(),
                        ))
                    : InkWell(
                        onTap: () {
                          showDialog(
                              useSafeArea: true,
                              context: context,
                              builder: (context) {
                                return GestureDetector(
                                  onTap: () => FocusScope.of(context).unfocus(),
                                  child: AlertDialog(
                                    icon: const Icon(
                                      Icons.info,
                                      color: DARK_YELLOW_COLOR,
                                    ),
                                    title: const Text(
                                      "Enter the currnet password.",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 15),
                                    ),
                                    backgroundColor:
                                        const Color.fromARGB(255, 49, 49, 49),
                                    // Content size
                                    content: SizedBox(
                                      height: 180,
                                      child: Form(
                                        key: _formkey1,
                                        child: Column(
                                          children: [
                                            textFormField(
                                                obscureText: true,
                                                context,
                                                "Password",
                                                const Icon(Icons.password),
                                                validator: passwordValidator,
                                                controller: _password,
                                                testKey: "txtForgetPassword"),
                                            gap10,
                                            SizedBox(
                                              height: 45,
                                              child: ElevatedButton(
                                                  style: const ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStatePropertyAll(
                                                              DARK_YELLOW_COLOR)),
                                                  key: const ValueKey(
                                                      'btnLogin'),
                                                  onPressed: () {
                                                    if (_formkey1.currentState!
                                                        .validate()) {
                                                      setState(() {
                                                        _loading = true;
                                                      });
                                                      _checkPassword();
                                                    }
                                                  },
                                                  child: const Text(
                                                    "LOGIN",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  )),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              });
                        },
                        child: const Icon(Icons.lock)),
                prefixIcon: const Icon(Icons.password),
                errorStyle: const TextStyle(fontSize: 12),
                enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(width: 0, color: Colors.white)),
                focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: DARK_GREY_COLOR)),
                errorBorder: const OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Colors.red)),
                focusedErrorBorder: const OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Colors.red)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
