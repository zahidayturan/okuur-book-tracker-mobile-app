import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:okuur/core/constants/colors.dart';
import 'package:okuur/core/utils/firebase_auth_helper.dart';
import 'package:okuur/core/utils/firebase_google_helper.dart';
import 'package:okuur/core/utils/get_storage_helper.dart';
import 'package:okuur/routes/login/welcome_app.dart';
import 'package:okuur/ui/components/base_container.dart';
import 'package:okuur/ui/components/functional_alert_dialog.dart';
import 'package:okuur/ui/components/page_header.dart';

class AccountSettingsPage extends StatefulWidget {
  const AccountSettingsPage({super.key});

  @override
  State<AccountSettingsPage> createState() => _AccountSettingsPageState();
}

class _AccountSettingsPageState extends State<AccountSettingsPage> {
  final AppColors colors = AppColors();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  const SizedBox(height: 12),
                  _buildPageHeader(context),
                  _buildEmailInfo(),
                  const SizedBox(height: 12),
                  _buildDeleteAccountSection(),
                  const SizedBox(height: 12),
                  _buildSignOutSection(),
                  const SizedBox(height: 12),
                  _buildDebugInfo(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPageHeader(BuildContext context) {
    return PageHeaderTitle(
      backButton: true,
      title: "Hesap Ayarları",
      pathName: "assets/icons/settings.png",
      subtitle: "",
    ).getTitle(context);
  }

  Widget _buildEmailInfo() {
    return BaseContainer(
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              readOnly: true,
              style: TextStyle(color: Theme.of(context).colorScheme.secondary),
              decoration: InputDecoration(
                labelText: "Hesap Posta Adresi",
                hintText: _auth.currentUser?.email ?? "Alınamadı",
                hintStyle: TextStyle(color: Theme.of(context).colorScheme.secondary, fontSize: 14),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                prefixIcon: Icon(Icons.mail_outline_rounded, color: Theme.of(context).colorScheme.secondary),
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                labelStyle: TextStyle(color: Theme.of(context).colorScheme.secondary),
              ),
            ),
          ),
          Text(
            _auth.currentUser != null
                ? (_auth.currentUser!.emailVerified ? "Doğrulandı" : "Doğrulanmadı")
                : "?",
            style: TextStyle(color: colors.orange, fontSize: 11),
          ),
        ],
      ),
    );
  }

  Widget _buildDeleteAccountSection() {
    return BaseContainer(
      child: Column(
        children: [
          const Text(
            "Hesabı ve tüm verileri silmek, kalıcı ve geri döndürülemez bir işlemdir.",
            style: TextStyle(fontSize: 12),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () async {
              bool shouldDelete = await _showConfirmationDialog(
                "Hesabı ve tüm verileri silmek, kalıcı ve geri döndürülemez bir işlemdir.\nSilmek istiyor musunuz?",
                context,
              );
              if (shouldDelete) {
                await FirebaseGoogleOperation().disconnectGoogle();
                await FirebaseAuthOperation().deleteAccountAndSignOut();
                Navigator.pushAndRemoveUntil(
                  context,
                  _createFadePageRoute(const WelcomePage()),
                      (Route<dynamic> route) => false,
                );
              }
            },
            style: ButtonStyle(backgroundColor: MaterialStateProperty.all(colors.red)),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text("Hesabı ve Tüm Verileri Sil")],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSignOutSection() {
    return BaseContainer(
      child: ElevatedButton(
        onPressed: () async {
          bool shouldSignOut = await _showConfirmationDialog("Oturumunuz kapatılacak.\nOnaylıyor musunuz?", context);
          if (shouldSignOut) {
            await FirebaseGoogleOperation().signOutGoogle();
            await FirebaseAuthOperation().userSignOut();
            Navigator.pushAndRemoveUntil(
              context,
              _createFadePageRoute(const WelcomePage()),
                  (Route<dynamic> route) => false,
            );
          }
        },
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text("Hesaptan Çıkış Yap")],
        ),
      ),
    );
  }

  Widget _buildDebugInfo() {
    return Column(
      children: [
        Text(_auth.currentUser?.uid ?? "uid"),
        Text(
          _auth.currentUser != null
              ? _auth.currentUser!.providerData.length == 1
              ? _auth.currentUser!.providerData[0].providerId
              : "${_auth.currentUser!.providerData[0].providerId} - ${_auth.currentUser!.providerData[1].providerId}"
              : "Hesap Türü",
        ),
        Text(OkuurLocalStorage().getActiveUserUid() ?? "aktif uid"),
      ],
    );
  }

  Future<bool> _showConfirmationDialog(String message, BuildContext context) async {
    bool? result = await OkuurAlertDialog.show(
      context: context,
      contentText: message,
      buttons: [
        AlertButton(text: "Geri Dön", fill: false, returnValue: false),
        AlertButton(text: "Devam Et", fill: true, returnValue: true),
      ],
    );
    return result ?? false;
  }

  PageRouteBuilder _createFadePageRoute(Widget page) {
    return PageRouteBuilder(
      opaque: false,
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation, nextAnimation) => page,
      reverseTransitionDuration: const Duration(milliseconds: 1),
      transitionsBuilder: (context, animation, nextAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  }
}
