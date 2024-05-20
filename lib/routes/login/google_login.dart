import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:okuur/core/constants/colors.dart';
import 'package:okuur/core/utils/firebase_auth_helper.dart';
import 'package:okuur/routes/home/home.dart';
import 'package:okuur/ui/components/rich_text.dart';
import 'package:okuur/ui/components/snackbar.dart';

class GoogleLogin extends StatefulWidget {
  const GoogleLogin({super.key});

  @override
  State<GoogleLogin> createState() => _GoogleLoginState();
}

class _GoogleLoginState extends State<GoogleLogin> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AppColors colors = AppColors();
  PageController pageController = PageController(initialPage: 0);

  String errorTextName = "";
  String errorTextSurname = "";
  String errorTextUserName = "";

  final _nameKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final _surnameKey = GlobalKey<FormState>();
  final TextEditingController surnameController = TextEditingController();
  final _userNameKey = GlobalKey<FormState>();
  final TextEditingController userNameController = TextEditingController();

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
                  height: 236,
                  child: PageView(
                    controller: pageController,
                    physics: NeverScrollableScrollPhysics(),
                    children: [nameAndSurname(), completed()],
                  ),
                ),
                Spacer(),
                Text(_auth.currentUser != null
                    ? _auth.currentUser!.email.toString()
                    : "çıkış yapıldı"),
                Text(_auth.currentUser != null
                    ? _auth.currentUser!.uid
                    : "çıkış yapıldı"),
                Text(_auth.currentUser != null
                    ? _auth.currentUser!.emailVerified.toString()
                    : "çıkış yapıldı"),
                bottomBar()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget createForms(Widget formName) {
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
              topLeft: Radius.circular(26)),
          boxShadow: [
            BoxShadow(
              color: colors.greyDark.withOpacity(0.1),
              blurRadius: 5,
              spreadRadius: 2,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: formName);
  }

  Widget nameAndSurname() {
    return Column(
      children: [
        createForms(
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              formTitleAndStep("Kişisel ", colors.blue, "3"),
              const SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  Expanded(
                      child: getTextFormField(nameController, "Adınız", 24, "",
                          _nameKey, errorTextName)),
                  SizedBox(
                    width: 12,
                  ),
                  Expanded(
                      child: getTextFormField(surnameController, "Soyadınız",
                          24, "", _surnameKey, errorTextSurname))
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  title("@", colors.blue, 22, "FontBold"),
                  SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: getTextFormField(
                      userNameController,
                      "Kullanıcı Adınız",
                      54,
                      "",
                      _userNameKey,
                      errorTextUserName,
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  InkWell(
                    onTap: () {
                      SnackBarWidget(
                              context: context,
                              backColor: colors.blue,
                              duration: 5,
                              textWidget: title(
                                  "Kullanıcı adınız diğer kullanıcılar tarafından görülecektir",
                                  colors.grey,
                                  14,
                                  "FontMedium"))
                          .showQuestionDialog();
                    },
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                          color: colors.grey, shape: BoxShape.circle),
                      child: Icon(
                        Icons.question_mark_rounded,
                        color: colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        confirmButtons("Devam Et", colors.blue, 2),
      ],
    );
  }

  Widget completed() {
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
                    title("Aramıza Hoş Geldin", colors.orange, 16, "FontBold"),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                title("@${userNameController.text}\n", colors.black, 15,
                    "FontBold"),
                RichTextWidget(texts: [
                  "Okuma hedeflerini ekle, okumaya ve keşfetmeye başla, başarımlar kazan.\n",
                  " Okuur seni bekliyor"
                ], colors: [
                  colors.black,
                  colors.greenDark
                ], fontFamilies: [
                  "FontMedium",
                  "FontBold"
                ], fontSize: 15, align: TextAlign.center)
              ],
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          confirmButtons("Kullanmaya Başla", colors.orange, 3),
        ],
      ),
    );
  }

  Widget formTitleAndStep(String text, Color color, String step) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichTextWidget(
            texts: [text, "Bilgileriniz"],
            colors: [color, color],
            fontFamilies: ["FontBold", "FontMedium"],
            fontSize: 16,
            align: TextAlign.start),
        title("Yardım", colors.greenDark, 12, "FontMedium")
      ],
    );
  }

  Widget confirmButtons(String text, Color color, int onTapType) {
    return InkWell(
      onTap: () async {
        setState(() {});
        if (onTapType == 2) {
          setState(() {
            if (validateName(nameController.text) &&
                validateSurname(surnameController.text) &&
                validateUsername(userNameController.text)) {
              pageController.nextPage(
                  duration: Duration(milliseconds: 800),
                  curve: Curves.easeInOut);
            } else {}
          });
        } else if (onTapType == 3) {
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
              topLeft: Radius.circular(4)),
          boxShadow: [
            BoxShadow(
              color: colors.greyDark.withOpacity(0.1),
              blurRadius: 5,
              spreadRadius: 2,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Center(child: title(text, colors.white, 16, "FontMedium")),
      ),
    );
  }

  Widget getTextFormField(TextEditingController? controller, String hintText,
      int maxLength, String helperText, Key key, String errorText) {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
          color: colors.grey,
          borderRadius: const BorderRadius.all(Radius.circular(10))),
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
                  fontFamily: "FontMedium"),
              errorStyle: TextStyle(
                  color: colors.red,
                  fontSize: 12,
                  height: 1,
                  fontFamily: "FontMedium"),
              counterText: "",
              contentPadding: EdgeInsets.zero,
              border: InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }

  Widget topBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () async {
            await FirebaseAuthOperation().deleteAccountAndSignOut();
            setState(() {
              Navigator.of(context).pop();
            });
          },
          highlightColor: colors.greenDark,
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          child: Container(
            height: 32,
            width: 48,
            decoration: BoxDecoration(
                color: colors.blue,
                borderRadius: const BorderRadius.all(Radius.circular(30))),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset("assets/icons/back_arrow.png"),
            ),
          ),
        ),
        RichTextWidget(
            texts: ["Hesaba\n", "Giriş\nYap"],
            colors: [colors.blue, colors.blue],
            fontFamilies: ["FontMedium", "FontBold"],
            fontSize: 19,
            align: TextAlign.end)
      ],
    );
  }

  Widget bottomBar() {
    return SizedBox(
      height: 24,
      child: Image.asset("assets/logo/logo_text.png"),
    );
  }

  Text title(String text, Color color, double size, String family) {
    return Text(
      text,
      style: TextStyle(color: color, fontFamily: family, fontSize: size),
    );
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
    } else {
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
    } else {
      setState(() {
        errorTextUserName = 'Kullanıcı adı boş bırakılamaz';
      });
      return false;
    }
  }
}
