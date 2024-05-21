import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:okuur/core/constants/colors.dart';
import 'package:okuur/core/utils/firebase_auth_helper.dart';
import 'package:okuur/core/utils/firebase_firestore_helper.dart';
import 'package:okuur/data/models/okuur_user_info.dart';
import 'package:okuur/routes/home/home.dart';
import 'package:okuur/routes/login/components/bottom_icon.dart';
import 'package:okuur/routes/login/components/create_forms.dart';
import 'package:okuur/routes/login/components/login_text.dart';
import 'package:okuur/routes/login/components/text_form_field.dart';
import 'package:okuur/ui/components/rich_text.dart';
import 'dart:async';
import 'package:okuur/ui/components/snackbar.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  AppColors colors = AppColors();
  PageController pageController = PageController(initialPage: 0);
  String errorTextMail = "";
  String errorTextPassword = "";
  String errorTextName = "";
  String errorTextSurname = "";
  String errorTextUserName = "";
  Timer? _timer;
  final _emailKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final _passwordKey = GlobalKey<FormState>();
  final TextEditingController passwordController = TextEditingController();
  bool passwordVisible = true;
  final _nameKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final _surnameKey = GlobalKey<FormState>();
  final TextEditingController surnameController = TextEditingController();
  final _userNameKey = GlobalKey<FormState>();
  final TextEditingController userNameController = TextEditingController();


  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startEmailVerificationCheckTimer() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      setState(() {});
    });
  }

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
                const Spacer(),
                SizedBox(
                  height: 236,
                  child: PageView(
                    controller: pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      email(),
                      emailCheck(),
                      nameAndSurname(),
                      completed()
                    ],
                  ),
                ),
                const Spacer(),
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


  Widget email(){
    return Column(
      children: [
        createForms(
          Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            formTitleAndStep("Hesap ",colors.greenDark,"1"),
            const SizedBox(height: 16,),
            getTextFormField(emailController, "E-Posta adresinizi giriniz", 100, "", _emailKey, errorTextMail,false),
            const SizedBox(height: 12,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: getTextFormField(passwordController, "Şifre belirleyiniz", 54, "", _passwordKey, errorTextPassword,passwordVisible)),
                const SizedBox(width: 8,),
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
                    child: Icon(passwordVisible == true ? Icons.visibility_rounded : Icons.visibility_off_rounded,color: colors.greenDark,),
                  ),
                )
              ],
            ),
          ],
        ),
        ),
        const SizedBox(height: 8,),
        confirmButtons(
            "Devam Et",
            colors.greenDark,
            0
        ),
      ],
    );
  }

  Widget emailCheck(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          createForms(
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                formTitleAndStep("E-Posta ",colors.greenDark,"2"),
                const SizedBox(height: 16,),
                loginText("Mail adresinize doğrulama bağlantısı gönderdik.\nLütfen posta kutunuzu kontrol edin.\n", colors.black, 13, "FontMedium"),
                loginText(emailController.text != "" ? emailController.text : "E-posta bilgisi alınamadı", colors.black, 13, "FontBold"),
              ],
            ),
          ),
          const SizedBox(height: 8,),
          confirmButtons(
              checkVerify() == false ? "Doğrulamayı Yapınız" : "Devam Et",
              checkVerify() == false ? colors.greyDark :colors.greenDark,
              1
          ),
          const SizedBox(height: 8,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () async{
                  await FirebaseAuthOperation().userDelete();
                  setState(() {
                    emailController.clear();
                    passwordController.clear();
                    pageController.animateToPage(0, duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
                  });
                },
                child: loginText("Geri Dön", colors.greenDark, 13, "FontMedium"),
              ),
              InkWell(
                onTap: () {
                  FirebaseAuthOperation().sendVerification();
                },
                child: loginText(checkVerify() ? "Doğrulandı" :"Yeni Bağlantı Gönder", colors.green, 13, "FontMedium"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget nameAndSurname(){
    return Column(
      children: [
        createForms(
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              formTitleAndStep("Kişisel ",colors.blue,"3"),
              const SizedBox(height: 16,),
              Row(
                children: [
                  Expanded(child: getTextFormField(nameController, "Adınız", 24, "", _nameKey, errorTextName,false)),
                  const SizedBox(width: 12,),
                  Expanded(child: getTextFormField(surnameController, "Soyadınız", 24, "", _surnameKey, errorTextSurname,false))
                ],
              ),
              const SizedBox(height: 12,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  loginText("@", colors.blue, 22, "FontBold"),
                  const SizedBox(width: 8,),
                  Expanded(child: getTextFormField(userNameController, "Kullanıcı Adınız", 54, "", _userNameKey, errorTextUserName,false),),
                  const SizedBox(width: 8,),
                  InkWell(
                    onTap: () {
                      SnackBarWidget(
                          context: context,
                          backColor: colors.blue,
                          duration: 5,
                          textWidget: loginText("Kullanıcı adınız diğer kullanıcılar tarafından görülecektir", colors.grey, 14, "FontMedium")).showQuestionDialog();
                    },
                    child: Container(width: 36,height: 36,
                      decoration: BoxDecoration(
                          color: colors.grey,
                          shape: BoxShape.circle
                      ),
                      child: Icon(Icons.question_mark_rounded,color: colors.blue,),
                    ),
                  ),
                ],
              ),

            ],
          ),
        ),
        const SizedBox(height: 8,),
        confirmButtons(
            "Devam Et",
            colors.blue,
            2
        ),
      ],
    );
  }

  Widget completed(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          createForms(
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    loginText("Aramıza Hoş Geldin", colors.orange, 16, "FontBold"),
                  ],
                ),
                const SizedBox(height: 16,),
                loginText("@${userNameController.text}\n", colors.black, 15, "FontBold"),
                RichTextWidget(
                    texts: ["Okuma hedeflerini ekle, okumaya ve keşfetmeye başla, başarımlar kazan.\n"," Okuur seni bekliyor"],
                    colors: [colors.black,colors.greenDark],
                    fontFamilies: ["FontMedium","FontBold"],
                    fontSize: 15,
                    align: TextAlign.center)
              ],
            ),
          ),
          const SizedBox(height: 8,),
          confirmButtons(
              "Kullanmaya Başla",
              colors.orange,
              3
          ),
        ],
      ),
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
        loginText("$step.adım / 4", colors.greenDark, 12, "FontMedium")
      ],
    );
  }

  Widget confirmButtons(String text,Color color,int onTapType){
    return InkWell(
      onTap: () async{
        setState(() {});
          if(onTapType == 0){
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
              String register = "" ;
              try {
                register = await FirebaseAuthOperation().registerWithEmailAndPassword(emailController.text.trim(),passwordController.text);
              } finally {
                Navigator.pop(context);
                setState(() {
                  if(register == "email-already-in-use"){
                    errorTextMail = "Bu hesap zaten var. Giriş yapmayı deneyin.";
                  }
                  if(_auth.currentUser != null){
                    pageController.nextPage(duration: const Duration(milliseconds: 800), curve: Curves.easeInOut);
                    _startEmailVerificationCheckTimer();
                  }
                });
              }
            }else{
            }
          }else if(onTapType == 1){
            setState(() {
              if(checkVerify()){
                print("doğrulandı");
                _timer!.cancel();
                pageController.nextPage(duration: const Duration(milliseconds: 800), curve: Curves.easeInOut);
              }else{
                print("doğrulanmadı");
              }
            });
          }else if(onTapType == 2){
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
            try {
              await FirebaseFirestoreOperation().addOkuurUserInfoToFirestore(
                  OkuurUserInfo(
                      id: _auth.currentUser!.uid,
                      name: nameController.text,
                      surname: surnameController.text,
                      username: userNameController.text,
                      email: _auth.currentUser!.email!)
              );
            } finally {
              setState(() {
                if(validateName(nameController.text) && validateSurname(surnameController.text) && validateUsername(userNameController.text)){
                  pageController.nextPage(duration: const Duration(milliseconds: 800), curve: Curves.easeInOut);
                }else{

                }
              });
            }

          }else if(onTapType == 3){
            Navigator.pushAndRemoveUntil(
              context,
              PageRouteBuilder(
                opaque: false,
                transitionDuration: const Duration(milliseconds: 400),
                pageBuilder: (context, animation, nextanim) => const HomePage(),
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
          ),
          boxShadow: [
            BoxShadow(
              color: colors.greyDark.withOpacity(0.1),
              blurRadius: 5,
              spreadRadius: 2,
              offset: const Offset(0, 2),
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
              color: colors.greenDark,
              borderRadius: const BorderRadius.all(Radius.circular(30))
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset("assets/icons/back_arrow.png"),
            ),
          ),
        ),
        RichTextWidget(
            texts: ["Yeni\nHesap\n","Oluştur"],
            colors: [colors.greenDark,colors.greenDark],
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

  bool validateName(String name) {
    if (name.length >= 2) {
      setState(() {
        errorTextName = "";
      });
      return true;
    } else if (name.length == 1) {
      setState(() {
        errorTextName = "İsim en az iki harf içermeli";
      });
      return false;
    } else {
      setState(() {
        errorTextName = 'İsim boş bırakılamaz';
      });
      return false;
    }
  }

  bool validateSurname(String surname) {
    if (surname.length >= 2) {
      setState(() {
        errorTextSurname = "";
      });
      return true;
    } else if (surname.length == 1) {
      setState(() {
        errorTextName = "İsim en az iki harf içermeli";
      });
      return false;
    }else {
      setState(() {
        errorTextSurname = 'Soyad boş bırakılamaz';
      });
      return false;
    }
  }

  bool validateUsername(String username) {
    if (username.length >= 2) {
      setState(() {
        errorTextUserName = "";
      });
      return true;
    } else if (username.length == 1) {
      setState(() {
        errorTextName = "İsim en az iki harf içermeli";
      });
      return false;
    }else {
      setState(() {
        errorTextUserName = 'Kullanıcı adı boş bırakılamaz';
      });
      return false;
    }
  }

  bool checkVerify() {
    if(_auth.currentUser != null){
      _auth.currentUser?.reload();
      if(_auth.currentUser!.emailVerified){
        return true;
      }else {
        return false;
      }
    }else {
      return false;
    }
  }
}