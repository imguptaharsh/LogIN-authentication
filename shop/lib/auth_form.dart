import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  // const AuthForm({key});

  AuthForm(this.submitFn, this.isLoading);
  final void Function(
    String email,
    String password,
    String username,
    bool isLogin,
    BuildContext ctx,
  ) submitFn;
  final isLoading;
  // var isLogin = true;
  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();

  // final _emailController = TextEditingController();
  // final _passwordController = TextEditingController();
  // final isLoading;

  var isLogin = true;
  var _userEmail = '';
  var _userName = '';
  var _userPassword = '';

  void _trySubmit() {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState.save();
      widget.submitFn(_userEmail, _userPassword, _userName, isLogin, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.4,
          left: 35,
          right: 35,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                  validator: (value) {
                    if (value.isEmpty || !value.contains('@')) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                  // controller: _emailController,
                  onSaved: (value) {
                    _userEmail = value;
                    // _userEmail = _emailController as String;
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      fillColor: Colors.grey.shade100,
                      hintText: 'Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ))),
              const SizedBox(
                height: 20,
              ),
              if (!isLogin)
                TextFormField(
                  // controller: _emailController,
                  validator: (value) {
                    if ((value.isEmpty) || (value.length < 4)) {
                      return 'Please enter at least 4 characters.';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      fillColor: Colors.grey.shade100,
                      hintText: 'Username',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                  onSaved: (value) {
                    _userName = value;
                  },
                ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                validator: (value) {
                  if (value.isEmpty || value.length < 7) {
                    return 'Password must be at least 7 characters long.';
                  }
                  return null;
                },
                // controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                    fillColor: Colors.grey.shade100,
                    hintText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),
                onSaved: (value) {
                  _userPassword = value;
                },
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // ignore: prefer_const_constructors
                  if (widget.isLoading) CircularProgressIndicator(),
                  if (!widget.isLoading)
                    Text(isLogin ? 'Sign In' : 'Sign Up',
                        // ignore: prefer_const_constructors
                        style: TextStyle(
                          color: const Color(0xff4c505b),
                          fontSize: 27,
                          fontWeight: FontWeight.w700,
                        )),

                  if (!widget.isLoading)
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: const Color(0xff4c505b),
                      child: IconButton(
                        color: Colors.white,
                        onPressed: _trySubmit,
                        icon: const Icon(Icons.arrow_forward),
                      ),
                    )
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      setState(() {
                        isLogin = !isLogin;
                      });
                    },
                    // ignore: prefer_const_constructors
                    child: Text(isLogin ? "Sign Up" : "Login",
                        style: const TextStyle(
                          decoration: TextDecoration.underline,
                          fontSize: 18,
                          color: Color(0xff4c505b),
                        )),
                  ),
                  if (isLogin)
                    TextButton(
                      onPressed: () {},
                      // ignore: prefer_const_constructors
                      child: Text(
                        "Forgot Password",
                        // ignore: prefer_const_constructors
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontSize: 18,
                          color: const Color(0xff4c505b),
                        ),
                      ),
                    ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}







// Widget build(BuildContext context) {
//     return Center(
//         child: Card(
//       margin: EdgeInsets.all(16),
//       child: Form(
//           child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: <Widget>[
//           TextField(
//               controller: _emailController,
//               decoration: InputDecoration(
//                   fillColor: Colors.grey.shade100,
//                   hintText: 'Email',
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ))),
//           SizedBox(
//             height: 20,
//           ),
//           TextField(
//               controller: _passwordController,
//               obscureText: true,
//               decoration: InputDecoration(
//                   fillColor: Colors.grey.shade100,
//                   hintText: 'Password',
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ))),
//           SizedBox(
//             height: 40,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               // ignore: prefer_const_constructors
//               Text('Sign In',
//                   // ignore: prefer_const_constructors
//                   style: TextStyle(
//                     color: const Color(0xff4c505b),
//                     fontSize: 27,
//                     fontWeight: FontWeight.w700,
//                   )),
//               CircleAvatar(
//                 radius: 30,
//                 backgroundColor: Color(0xff4c505b),
//                 child: IconButton(
//                   color: Colors.white,
//                   onPressed: () => {},
//                   icon: Icon(Icons.arrow_forward),
//                 ),
//               )
//             ],
//           ),
//           SizedBox(
//             height: 40,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.pushNamed(context, 'register');
//                 },
//                 // ignore: prefer_const_constructors
//                 child: Text("Sign Up",
//                     style: const TextStyle(
//                       decoration: TextDecoration.underline,
//                       fontSize: 18,
//                       color: Color(0xff4c505b),
//                     )),
//               ),
//               TextButton(
//                 onPressed: () {},
//                 // ignore: prefer_const_constructors
//                 child: Text(
//                   "Forgot Password",
//                   // ignore: prefer_const_constructors
//                   style: TextStyle(
//                     decoration: TextDecoration.underline,
//                     fontSize: 18,
//                     color: Color(0xff4c505b),
//                   ),
//                 ),
//               ),
//             ],
//           )
//         ],
//       )),
//     ));
//   }
// }
