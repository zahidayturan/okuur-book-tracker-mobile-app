import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:okuur/app/okuur_app.dart';
import 'package:okuur/controllers/db_controller.dart';
import 'package:okuur/core/constants/colors.dart';
import 'package:okuur/core/utils/firebase_auth_helper.dart';
import 'package:okuur/core/utils/firebase_firestore_helper.dart';
import 'package:okuur/core/utils/get_storage_helper.dart';
import 'package:okuur/data/models/okuur_user_info.dart';
import 'package:okuur/data/services/operations/user_operations.dart';
import 'package:okuur/routes/login/components/bottom_icon.dart';
import 'package:okuur/routes/login/components/create_forms.dart';
import 'package:okuur/routes/login/components/login_text.dart';
import 'package:okuur/routes/login/components/text_form_field.dart';
import 'package:okuur/routes/login/welcome_app.dart';
import 'package:okuur/ui/components/rich_text.dart';
import 'package:okuur/ui/components/snackbar.dart';

class GoogleLogin extends StatefulWidget {
  const GoogleLogin({super.key});

  @override
  State<GoogleLogin> createState() => _GoogleLoginState();
}

class _GoogleLoginState extends State<GoogleLogin> {
  AppColors colors = AppColors();
  PageController pageController = PageController(initialPage: 0);

  final FirebaseAuth _auth = FirebaseAuth.instance;

  String errorTextName = "";
  String errorTextSurname = "";
  String errorTextUserName = "";

  final _nameKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final _surnameKey = GlobalKey<FormState>();
  final TextEditingController surnameController = TextEditingController();
  final _userNameKey = GlobalKey<FormState>();
  final TextEditingController userNameController = TextEditingController();

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
                SizedBox(
                  height: 236,
                  child: PageView(
                    controller: pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [nameAndSurname(), completed()],
                  ),
                ),
                bottomBar()
              ],
            ),
          ),
        ),
      ),
    );
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
                          _nameKey, errorTextName,false,context)),
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(
                      child: getTextFormField(surnameController, "Soyadınız",
                          24, "", _surnameKey, errorTextSurname,false,context))
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  loginText("@", colors.blue, 22, "FontBold"),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: getTextFormField(
                      userNameController,
                      "Kullanıcı Adınız",
                      54,
                      "",
                      _userNameKey,
                      errorTextUserName,false,context
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  InkWell(
                    onTap: () {
                      SnackBarWidget(
                              context: context,
                              backColor: colors.blue,
                              duration: 5,
                              textWidget: loginText(
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
          context
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
                    loginText("Aramıza Hoş Geldin", colors.orange, 16, "FontBold"),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                loginText("@${userNameController.text}\n", colors.black, 15,
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
                ], align: TextAlign.center)
              ],
            ),
            context
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
            colors: [color],
            fontFamilies: ["FontBold", "FontMedium"],
            fontSize: 16),
        loginText("Yardım", colors.greenDark, 12, "FontMedium")
      ],
    );
  }

  Widget confirmButtons(String text, Color color, int onTapType) {
    return InkWell(
      onTap: () async {
        setState(() {});
        if (onTapType == 2) {
            if (validateName(nameController.text) &&
                validateSurname(surnameController.text) &&
                validateUsername(userNameController.text)) {
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
                OkuurUserInfo newUser =  OkuurUserInfo(
                    id: _auth.currentUser!.uid,
                    name: nameController.text,
                    surname: surnameController.text,
                    username: userNameController.text,
                    email: _auth.currentUser!.email!,
                    creationTime: DateTime.now().toString()
                );
                await UserOperations().insertUserInfo(newUser);
                await FirebaseFirestoreOperation().addOkuurUserInfoToFirestore(newUser);
                await OkuurLocalStorage().saveActiveUserUid(_auth.currentUser!.uid);
                await dbController.checkOrCreateUserSpecificTables(_auth.currentUser!.uid);
              } finally {
                Navigator.pop(context);
                setState(() {
                  pageController.nextPage(
                      duration: const Duration(milliseconds: 800),
                      curve: Curves.easeInOut);
                });
              }
            } else {}

        } else if (onTapType == 3) {
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
              topLeft: Radius.circular(4)),
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

  Widget topBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () async {
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
              await FirebaseAuthOperation().deleteAccountAndSignOut();
            } finally {
              Navigator.pop(context);
              setState(() {
                Navigator.pushAndRemoveUntil(
                  context,
                  PageRouteBuilder(
                    opaque: false,
                    transitionDuration: const Duration(milliseconds: 300),
                    pageBuilder: (context, animation, nextanim) => const WelcomePage(),
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
              });
            }
          },
          highlightColor: colors.greenDark,
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          child: Container(
            height: 32,
            width: 48,
            decoration: BoxDecoration(
              color: colors.blue,
              borderRadius: const BorderRadius.all(Radius.circular(30)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset("assets/icons/back_arrow.png"),
            ),
          ),
        ),

        RichTextWidget(
            texts: ["Google ile\n", "Kayıt\nOl"],
            colors: [colors.blue],
            fontFamilies: ["FontMedium", "FontBold"],
            fontSize: 19,
            align: TextAlign.end)
      ],
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
        errorTextName = "En az iki harf içermeli";
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
        errorTextSurname = "En az iki harf içermeli";
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
        errorTextUserName = "Kullanıcı adı en az iki harf içermeli";
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