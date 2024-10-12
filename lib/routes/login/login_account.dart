import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:okuur/app/okuur_app.dart';
import 'package:okuur/controllers/db_controller.dart';
import 'package:okuur/core/constants/colors.dart';
import 'package:okuur/core/utils/firebase_auth_helper.dart';
import 'package:okuur/core/utils/get_storage_helper.dart';
import 'package:okuur/routes/home/home.dart';
import 'package:okuur/routes/login/components/bottom_icon.dart';
import 'package:okuur/routes/login/components/create_forms.dart';
import 'package:okuur/routes/login/components/login_text.dart';
import 'package:okuur/routes/login/components/text_form_field.dart';
import 'package:okuur/ui/components/rich_text.dart';

class LoginAccount extends StatefulWidget {
  const LoginAccount({super.key});

  @override
  State<LoginAccount> createState() => _LoginAccountState();
}

class _LoginAccountState extends State<LoginAccount> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AppColors colors = AppColors();

  String errorTextMail = "";
  String errorTextPassword = "";

  final _emailKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final _passwordKey = GlobalKey<FormState>();
  final TextEditingController passwordController = TextEditingController();
  bool passwordVisible = true;

  final DbController dbController = Get.put(DbController());

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
                email(),
                bottomBar()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget email(){
    return Column(
      children: [
        createForms(
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              formTitleAndStep("Hesap ",Theme.of(context).colorScheme.primary,"1"),
              const SizedBox(height: 16,),
              getTextFormField(emailController, "E-Posta adresinizi giriniz", 100, "", _emailKey, errorTextMail,false,context),
              const SizedBox(height: 12,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: getTextFormField(passwordController, "Şifrenizi giriniz", 54, "", _passwordKey, errorTextPassword,passwordVisible,context)),
                  SizedBox(width: 8,),
                  InkWell(
                    onTap: () {
                      setState(() {
                        passwordVisible = !passwordVisible;
                      });
                    },
                    child: Container(width: 48,height: 48,
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          shape: BoxShape.circle
                      ),
                      child: Icon(passwordVisible == true ? Icons.visibility_rounded : Icons.visibility_off_rounded,color: colors.blue,),
                    ),
                  )
                ],
              ),
            ],
          ),
          context
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
            colors: [color],
            fontFamilies: ["FontBold","FontMedium"],
            fontSize: 16),
        loginText("Yardım", Theme.of(context).colorScheme.primaryContainer, 12, "FontMedium")
      ],
    );
  }

  Widget confirmButtons(String text,Color color){
    return InkWell(
      onTap: () async {
        if(validateEmail(emailController.text) && validatePassword(passwordController.text)){
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return Center(
                child: CircularProgressIndicator(
                  color: colors.blue,
                ),
              );
            },
            barrierDismissible: false,
          );

          String login = "" ;
          try {
            login = await FirebaseAuthOperation().signInWithEmailAndPassword(emailController.text.trim(), passwordController.text);
          } finally {
            Navigator.pop(context);
            print("hata mesajı $login");
            setState(() {
              if(login == "user-not-found"){
                errorTextMail = "Böyle bir e-posta bulunamadı";
              }
              if(login == "wrong-password"){
                errorTextPassword = "Şifreyi hatalı girdiniz";
              }
              if(login != "Ok"){
                errorTextMail = "Hesap bulunamadı. Bilgileri kontrol ediniz";
              }
            });

            if (login == "Ok") {
              await OkuurLocalStorage().saveActiveUserUid(_auth.currentUser!.uid);
              await dbController.checkOrCreateUserSpecificTables(_auth.currentUser!.uid);

              Navigator.pushAndRemoveUntil(
                context,
                PageRouteBuilder(
                  opaque: false,
                  transitionDuration: const Duration(milliseconds: 300),
                  pageBuilder: (context, animation, nextanim) => const OkuurApp(),
                  reverseTransitionDuration: const Duration(milliseconds: 1),
                  transitionsBuilder: (context, animation, nexttanim, child) {
                    return FadeTransition(
                      opacity: animation,
                      child: child,
                    );
                  },
                ),
                    (Route<dynamic> route) => false,
              );
            }
          }
        } else {
        }
      },
      highlightColor: color,
      borderRadius: const BorderRadius.all(Radius.circular(4)),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.bounceInOut,
        height: 48,
        constraints: const BoxConstraints(maxWidth: 600),
        decoration: BoxDecoration(
            color: color,
            borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(26),
                bottomLeft: Radius.circular(26),
                topRight: Radius.circular(4),
                topLeft: Radius.circular(4)
            ),
          boxShadow: [
            BoxShadow(
              color: colors.greyDark.withOpacity(0.1),
              blurRadius: 5,
              spreadRadius: 2,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Center(child: loginText(text, colors.white, 16, "FontMedium")),
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
            colors: [colors.blue],
            fontFamilies: ["FontMedium","FontBold"],
            fontSize: 19,
            align: TextAlign.end)
      ],
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