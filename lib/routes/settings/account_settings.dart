import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:okuur/core/constants/colors.dart';
import 'package:okuur/core/utils/firebase_auth_helper.dart';
import 'package:okuur/core/utils/firebase_google_helper.dart';
import 'package:okuur/core/utils/get_storage_helper.dart';
import 'package:okuur/routes/login/welcome_app.dart';
import 'package:okuur/ui/components/base_container.dart';
import 'package:okuur/ui/components/page_header.dart';

class AccountSettingsPage extends StatefulWidget {
  const AccountSettingsPage({super.key});

  @override
  State<AccountSettingsPage> createState() => _AccountSettingsPageState();
}

class _AccountSettingsPageState extends State<AccountSettingsPage> {
  AppColors colors = AppColors();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        resizeToAvoidBottomInset: false,
        bottomNavigationBar: null,
        body: Padding(
          padding: const EdgeInsets.only(right: 12, left: 12),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Center(
              child: Column(
                children: [
                  const SizedBox(
                    height: 12,
                  ),
                  PageHeaderTitle(
                          backButton: true,
                          title: "Hesap Ayarları",
                          pathName: "settings",
                          subtitle: "")
                      .getTitle(context),
                  BaseContainer(
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            readOnly: true,
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.secondary
                            ),
                            decoration: InputDecoration(
                                labelText: "Hesap Posta Adresi",
                                hintText: _auth.currentUser != null ? _auth.currentUser!.email.toString() : "Alınamadı",
                                hintStyle: TextStyle(color: Theme.of(context).colorScheme.secondary, fontSize: 14),
                                floatingLabelBehavior: FloatingLabelBehavior.always,
                                prefixIcon: Icon(Icons.mail_outline_rounded, color: Theme.of(context).colorScheme.secondary),
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                labelStyle: TextStyle(color: Theme.of(context).colorScheme.secondary)),
                          ),
                        ),
                        Text(_auth.currentUser != null
                            ? _auth.currentUser!.emailVerified ? "Doğrulandı" : "Doğrulanmadı"
                            : "?",style: TextStyle(color: colors.orange,fontSize: 11),),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  BaseContainer(
                      child: Column(
                        children: [
                          const Text("Hesabı ve tüm verileri silmek, kalıcı ve geri döndürülemez bir işlemdir.",style: TextStyle(fontSize: 12),),
                          const SizedBox(height: 8,),
                          ElevatedButton(
                              onPressed: () async {
                                await FirebaseGoogleOperation().disconnectGoogle();
                                await FirebaseAuthOperation()
                                    .deleteAccountAndSignOut();
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  PageRouteBuilder(
                                    opaque: false,
                                    transitionDuration:
                                        const Duration(milliseconds: 300),
                                    pageBuilder: (context, animation, nextanim) =>
                                        const WelcomePage(),
                                    reverseTransitionDuration:
                                        const Duration(milliseconds: 1),
                                    transitionsBuilder:
                                        (context, animation, nexttanim, child) {
                                      return FadeTransition(
                                        opacity: animation,
                                        child: child,
                                      );
                                    },
                                  ),
                                  (Route<dynamic> route) => false,
                                );
                              },
                              style: ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(colors.red)
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Hesabı ve Tüm Verileri Sil",),
                                ],
                              )),
                        ],
                      )),
                  const SizedBox(
                    height: 12,
                  ),
                  BaseContainer(
                      child: ElevatedButton(
                          onPressed: () async {
                            await FirebaseGoogleOperation().signOutGoogle();
                            await FirebaseAuthOperation().userSignOut();
                            Navigator.pushAndRemoveUntil(
                              context,
                              PageRouteBuilder(
                                opaque: false,
                                transitionDuration: const Duration(milliseconds: 300),
                                pageBuilder: (context, animation, nextanim) =>
                                const WelcomePage(),
                                reverseTransitionDuration:
                                const Duration(milliseconds: 1),
                                transitionsBuilder:
                                    (context, animation, nexttanim, child) {
                                  return FadeTransition(
                                    opacity: animation,
                                    child: child,
                                  );
                                },
                              ),
                                  (Route<dynamic> route) => false,
                            );
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Hesaptan Çıkış Yap"),
                            ],
                          ))),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(_auth.currentUser != null
                      ? _auth.currentUser!.uid
                      : "uid"),
                  Text(_auth.currentUser != null
                      ? _auth.currentUser!.providerData.length == 1
                          ? _auth.currentUser!.providerData[0].providerId
                          : "${_auth.currentUser!.providerData[0].providerId} - ${_auth.currentUser!.providerData[1].providerId}"
                      : "Hesap Türü"),
                  Text(OkuurLocalStorage().getActiveUserUid() != null
                      ? OkuurLocalStorage().getActiveUserUid()!
                      : "aktif uid"),
                  const SizedBox(
                    height: 12,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
