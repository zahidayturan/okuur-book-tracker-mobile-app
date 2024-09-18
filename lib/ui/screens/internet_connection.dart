import 'package:flutter/material.dart';
import 'package:okuur/core/constants/colors.dart';
import 'package:okuur/ui/components/rich_text.dart';

class InternetConnection extends StatefulWidget {

  const InternetConnection({
    Key? key,
  }) : super(key: key);

  @override
  State<InternetConnection> createState() => _InternetConnectionState();
}

class _InternetConnectionState extends State<InternetConnection> {

  AppColors colors = AppColors();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                      child: iconButton("assets/icons/close.png")),
                ],
              ),
              RichTextWidget(
                  texts: const ["İnternet bağlantısı\n","bulunamadı"],
                  colors: [Theme.of(context).colorScheme.onSurface,Theme.of(context).colorScheme.primaryContainer],
                  fontFamilies: const ["FontMedium","FontBold"],
                  fontSize: 18,
                  align: TextAlign.center),
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: RichTextWidget(
                    texts: const ["Lütfen\n","internet bağlantısını\n","sağlayın"],
                    colors: [Theme.of(context).colorScheme.primary,Theme.of(context).colorScheme.onSurface,Theme.of(context).colorScheme.primary],
                    fontFamilies: const ["FontMedium","FontBold","FontMedium"],
                    fontSize: 14,
                    align: TextAlign.center),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container iconButton(String path){
    return Container(
      height: 36,
      width: 36,
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.tertiaryContainer,
          borderRadius: const BorderRadius.all(Radius.circular(20))
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset(path,color: colors.grey),
      ),
    );
  }
}