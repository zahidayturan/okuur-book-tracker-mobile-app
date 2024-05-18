import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:okuur/core/constants/colors.dart';
import 'package:okuur/ui/classes/bottom_navigation_bar.dart';
import 'package:okuur/ui/components/rich_text.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {

  AppColors colors = AppColors();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: EdgeInsets.all(12),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                topBar(),
                Column(
                  children: [
                    createForms(),
                    SizedBox(height: 8,),
                    confirmButtons(),
                  ],
                ),
                bottomBar()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget createForms(){
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      curve: Curves.bounceInOut,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colors.white,
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(4),
              bottomLeft: Radius.circular(4),
              topRight: Radius.circular(26),
              topLeft: Radius.circular(26)
          )
      ),
      child: Column(
        children: [
          email(),
        ],
      )

    );
  }

  final _nameSupplyKey = GlobalKey<FormState>();
  final TextEditingController nameSupplyController = TextEditingController();

  Widget email(){
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichTextWidget(
                  texts: ["E-Posta ","Bilgileriniz"],
                  colors: [colors.greenDark,colors.greenDark],
                  fontFamilies: ["FontBold","FontMedium"],
                  fontSize: 16,
                  align: TextAlign.start),
              title("1.adım / 4", colors.greenDark, 12, "FontMedium")
            ],
          ),
          SizedBox(height: 16,),
          getTextFormField(nameSupplyController, "E-Posta adresinizi giriniz", 100, "", _nameSupplyKey)

        ],
      ),
    );
  }

  Widget confirmButtons(){
    return InkWell(
      onTap: () {

      },
      highlightColor: colors.greenDark,
      borderRadius: BorderRadius.all(Radius.circular(4)),
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: colors.greenDark,
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(26),
              bottomLeft: Radius.circular(26),
              topRight: Radius.circular(4),
              topLeft: Radius.circular(4)
          )
        ),
        child: Center(child: title("Doğrulama Kodu Gönder", colors.white, 16, "FontMedium")),
      ),
    );
  }

  Widget getTextFormField(TextEditingController? controller,String hintText,int maxLength,String helperText,Key key){
      return Container(
        height: 48,
        padding: EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: colors.grey,
          borderRadius: BorderRadius.all(Radius.circular(10))
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
                  hintStyle: TextStyle(
                      color: colors.greenDark,
                      fontSize: 14,
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
          },
          highlightColor: colors.greenDark,
          borderRadius: BorderRadius.all(Radius.circular(5)),
          child: Container(
            height: 32,
            width: 48,
            decoration: BoxDecoration(
              color: colors.greenDark,
              borderRadius: BorderRadius.all(Radius.circular(30))
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

}


Future<void> registerUser(String email, String password) async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );


    await sendEmailVerification(userCredential.user);
  } on FirebaseAuthException catch (e) {
    print("Failed with error code: ${e.code}");
    print(e.message);
  }
}

Future<void> sendEmailVerification(User? user) async {
  if (user != null && !user.emailVerified) {
    await user.sendEmailVerification();
    print("Email verification sent to ${user.email}");
  }
}
