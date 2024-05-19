import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:okuur/core/constants/colors.dart';
import 'package:okuur/ui/components/rich_text.dart';

class LoginAccount extends StatefulWidget {
  const LoginAccount({super.key});

  @override
  State<LoginAccount> createState() => _LoginAccountState();
}

class _LoginAccountState extends State<LoginAccount> {

  AppColors colors = AppColors();

  String errorTextMail = "";
  String errorTextPassword = "";

  final _emailKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final _passwordKey = GlobalKey<FormState>();
  final TextEditingController passwordController = TextEditingController();
  bool passwordVisible = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.all(12),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                topBar(),
                Spacer(),
                email(),
                Spacer(),
                Text(_auth.currentUser != null ? _auth.currentUser!.email.toString() : "çıkış yapıldı"),
                Text(_auth.currentUser != null ? _auth.currentUser!.uid : "çıkış yapıldı"),
                Text(_auth.currentUser != null ? _auth.currentUser!.emailVerified.toString() : "çıkış yapıldı"),
                bottomBar()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget createForms(Widget formName){
    return AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.bounceInOut,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: colors.white,
            borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(4),
                bottomLeft: Radius.circular(4),
                topRight: Radius.circular(26),
                topLeft: Radius.circular(26)
            )
        ),
        child: formName
    );
  }

  Widget email(){
    return Column(
      children: [
        createForms(
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              formTitleAndStep("Hesap ",colors.blue,"1"),
              const SizedBox(height: 16,),
              getTextFormField(emailController, "E-Posta adresinizi giriniz", 100, "", _emailKey, errorTextMail,),
              const SizedBox(height: 12,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: getTextFormField(passwordController, "Şifrenizi giriniz", 54, "", _passwordKey, errorTextPassword,)),
                  SizedBox(width: 8,),
                  InkWell(
                    onTap: () {
                      setState(() {
                        passwordVisible = !passwordVisible;
                      });
                    },
                    child: Container(width: 48,height: 48,
                      decoration: BoxDecoration(
                          color: colors.grey,
                          shape: BoxShape.circle
                      ),
                      child: Icon(passwordVisible == true ? Icons.visibility_rounded : Icons.visibility_off_rounded,color: colors.blue,),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 8,),
        confirmButtons(
            "Giriş Yap",
            colors.blue,
        ),
      ],
    );
  }

  Widget formTitleAndStep(String text,Color color,String step){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichTextWidget(
            texts: [text,"Bilgileriniz"],
            colors: [color,color],
            fontFamilies: ["FontBold","FontMedium"],
            fontSize: 16,
            align: TextAlign.start),
        title("Yardım", colors.greenDark, 12, "FontMedium")
      ],
    );
  }

  Widget confirmButtons(String text,Color color){
    return InkWell(
      onTap: () async{
        setState(() {});
          if(validateEmail(emailController.text) && validatePassword(passwordController.text)){
            String login = await signInWithEmailAndPassword(emailController.text.trim(),passwordController.text);
            print("hata mesajı $login");
            setState(() {
              if(login == "user-not-found"){
                errorTextMail = "Böyle bir e-posta bulunamadı";
              }
              if(login == "wrong-password"){
                errorTextPassword = "Şifreyi hatalı girdiniz";
              }
              if(login != "Ok"){
                errorTextMail = "Hatalı girdiniz";
                errorTextPassword = "Hatalı girdiniz";
              }
            });
          }else{
          }
      },
      highlightColor: color,
      borderRadius: const BorderRadius.all(Radius.circular(4)),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.bounceInOut,
        height: 48,
        decoration: BoxDecoration(
            color: color,
            borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(26),
                bottomLeft: Radius.circular(26),
                topRight: Radius.circular(4),
                topLeft: Radius.circular(4)
            )
        ),
        child: Center(child: title(text, colors.white, 16, "FontMedium")),
      ),
    );
  }

  Widget getTextFormField(TextEditingController? controller,String hintText,int maxLength,String helperText,Key key,String errorText){
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
          color: colors.grey,
          borderRadius: const BorderRadius.all(Radius.circular(10))
      ),
      child: Center(
        child: Form(
          key: key,
          child: TextFormField(
            maxLines: 1,
            maxLength: maxLength,
            controller: controller,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Boş bırakılamaz';
              }
            },
            obscureText: key == _passwordKey && passwordVisible ? true : false,
            style: TextStyle(color: colors.greenDark),
            keyboardType: TextInputType.text,
            textAlign: TextAlign.start,
            decoration: InputDecoration(
              hintText: hintText,
              errorText: errorText,
              hintStyle: TextStyle(
                  color: colors.greenDark,
                  fontSize: 14,
                  height: 1,
                  fontFamily: "FontMedium"
              ),
              errorStyle: TextStyle(
                  color: colors.red,
                  fontSize: 12,
                  height: 1,
                  fontFamily: "FontMedium"
              ),
              counterText: "",
              contentPadding: EdgeInsets.zero,
              border: InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }

  Widget topBar(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            Navigator.of(context).pop();
            setState(() {
              if(_auth.currentUser != null){
                _auth.signOut();
              }
              emailController.clear();
              passwordController.clear();
            });
          },
          highlightColor: colors.greenDark,
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          child: Container(
            height: 32,
            width: 48,
            decoration: BoxDecoration(
                color: colors.blue,
                borderRadius: const BorderRadius.all(Radius.circular(30))
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset("assets/icons/back_arrow.png"),
            ),
          ),
        ),
        RichTextWidget(
            texts: ["Hesaba\n","Giriş\nYap"],
            colors: [colors.blue,colors.blue],
            fontFamilies: ["FontMedium","FontBold"],
            fontSize: 19,
            align: TextAlign.end)
      ],
    );
  }

  Widget bottomBar(){
    return SizedBox(
      height: 24,
      child: Image.asset("assets/logo/logo_text.png"),
    );
  }

  Text title(String text,Color color,double size, String family){
    return Text(
      text,style: TextStyle(
        color: color,
        fontFamily: family,
        fontSize: size
    ),
    );
  }

  bool emailValidate(String email) {
    RegExp regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return regex.hasMatch(email);
  }

  bool validateEmail(String email) {
    if (emailValidate(email)) {
      setState(() {
        errorTextMail = "";
      });
      return true;
    } else {
      setState(() {
        errorTextMail = 'Geçerli bir e-posta adresi girin';
      });
      return false;
    }
  }

  bool validatePassword(String password) {
    if (password.length >= 6) {
      setState(() {
        errorTextPassword = "";
      });
      return true;
    } else {
      setState(() {
        errorTextPassword = 'Şifre en az 6 haneli olmalı';
      });
      return false;
    }
  }

}

final FirebaseAuth _auth = FirebaseAuth.instance;

Future<String> signInWithEmailAndPassword(String email, String password) async {
  try {
    UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
    User? user = result.user;

    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();
      return 'email-not-verified';
    }
    return 'Ok';
  } on FirebaseAuthException catch (e) {
    print(e.toString());
    if (e.code == 'user-not-found') {
      return 'user-not-found';
    } else if (e.code == 'wrong-password') {
      return 'wrong-password';
    } else {
      return 'Error: ${e.message}';
    }
  } catch (e) {
    print(e.toString());
    return 'Error: ${e.toString()}';
  }
}

Future<bool> isEmailRegistered(String email,String password) async {
  try {
    UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
    if (result.user != null) {
      await result.user!.delete();
      return true;
    } else {
      return false;
    }
  } on FirebaseAuthException catch (e) {
    return false;
  } catch (e) {
    return false;
  }
}