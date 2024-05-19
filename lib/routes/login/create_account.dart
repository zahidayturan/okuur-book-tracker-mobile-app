import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:okuur/core/constants/colors.dart';
import 'package:okuur/ui/components/rich_text.dart';
import 'dart:async';

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {

  AppColors colors = AppColors();
  PageController pageController = PageController(initialPage: 0);
  String errorText = "";
  Timer? _timer;
  final _emailKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final _passwordKey = GlobalKey<FormState>();
  final TextEditingController passwordController = TextEditingController();
  final _passwordCheckedKey = GlobalKey<FormState>();
  final TextEditingController passwordCheckedController = TextEditingController();
  final _nameKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final _surnameKey = GlobalKey<FormState>();
  final TextEditingController surnameController = TextEditingController();


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
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      setState(() {
        print("timer");
      });
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
                Spacer(),
                SizedBox(
                  height: 180,
                  child: PageView(
                    controller: pageController,
                    //physics: NeverScrollableScrollPhysics(),
                    children: [
                      email(),
                      emailCheck(),
                      nameAndSurname()
                    ],
                  ),
                ),
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
            formTitleAndStep("E-Posta ",colors.greenDark,"1"),
            const SizedBox(height: 16,),
            getTextFormField(emailController, "E-Posta adresinizi giriniz", 100, "", _emailKey, errorText,),
          ],
        ),
        ),
        const SizedBox(height: 8,),
        confirmButtons(
            "Doğrulama Bağlantısı Gönder",
            colors.greenDark,
            0
        ),
      ],
    );
  }

  Widget emailCheck(){
    return Column(
      children: [
        createForms(
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              formTitleAndStep("E-Posta ",colors.greenDark,"1"),
              const SizedBox(height: 16,),
              title("Mail adresinizi kontrol ediniz\n${emailController.text}", colors.black, 13, "FontMedium"),
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
                await userDelete();
                setState(() {
                  emailController.clear();
                  pageController.animateToPage(0, duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
                });
              },
              child: title("Geri Dön", colors.greenDark, 13, "FontMedium"),
            ),
            InkWell(
              onTap: () {
                sendVerification();
              },
              child: title(checkVerify() ? "Doğrulandı" :"Yeni Bağlantı Gönder", colors.green, 13, "FontMedium"),
            ),
          ],
        ),
      ],
    );
  }

  Widget nameAndSurname(){
    return Column(
      children: [
        createForms(
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              formTitleAndStep("Kişisel ",colors.blue,"1"),
              const SizedBox(height: 16,),
              Row(
                children: [
                  Expanded(child: getTextFormField(nameController, "Adınız", 24, "", _nameKey, "")),
                  SizedBox(width: 12,),
                  Expanded(child: getTextFormField(surnameController, "Soyadınız", 24, "", _surnameKey, ""))
                ],
              )
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
        title("$step.adım / 4", colors.greenDark, 12, "FontMedium")
      ],
    );
  }

  Widget confirmButtons(String text,Color color,int onTapType){
    return InkWell(
      onTap: () async{
        setState(() {});
          if(onTapType == 0){
            if(validateEmail(emailController.text)){
              String register = await registerWithEmailAndPassword(emailController.text.trim(),"123Aa456");
              setState(() {
                if(register == "email-already-in-use"){
                  errorText = "Bu hesap zaten var. Giriş yapmayı deneyin.";
                }
                if(_auth.currentUser != null){
                  pageController.nextPage(duration: Duration(milliseconds: 1000), curve: Curves.easeInOut);
                  _startEmailVerificationCheckTimer();
                }
              });
            }else{
            }
          }else if(onTapType == 1){
            setState(() {
              if(checkVerify()){
                print("doğrulandı");
                _timer!.cancel();
                pageController.nextPage(duration: Duration(milliseconds: 1000), curve: Curves.easeInOut);
              }else{
                print("doğrulanmadı");
              }
            });

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
                  border: InputBorder.none
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
        errorText = "";
      });
      return true;
    } else {
      setState(() {
        errorText = 'Geçerli bir e-posta adresi girin';
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


final FirebaseAuth _auth = FirebaseAuth.instance;

Future<String> registerWithEmailAndPassword(String email, String password) async {
  try {
    UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    User? user = result.user;
    await sendVerification();
    return 'Ok';
  } on FirebaseAuthException catch (e) {
    if (e.code == 'email-already-in-use') {
      return 'email-already-in-use';
    } else {
      return 'Error: ${e.message}';
    }
  } catch (e) {
    return 'Error: ${e.toString()}';
  }
}

Future<void> sendVerification() async {
  if (_auth.currentUser != null && _auth.currentUser!.emailVerified == false) {
    try {
      await _auth.currentUser?.sendEmailVerification();
    } catch (e) {
      print(e.toString());
    }
  }
}

Future<void> userDelete() async {
  print("silinecek");
  if (_auth.currentUser != null) {
    try {
      await _auth.currentUser!.delete();
      print("silindi");
    } catch (e) {
      print(e.toString());
    }
  }
}