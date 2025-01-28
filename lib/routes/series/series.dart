import 'package:flutter/material.dart';
import 'package:okuur/core/constants/colors.dart';
import 'package:okuur/ui/components/page_header.dart';

class ReadingSeriesPage extends StatefulWidget {
  const ReadingSeriesPage({super.key});

  @override
  State<ReadingSeriesPage> createState() => _ReadingSeriesPageState();
}

class _ReadingSeriesPageState extends State<ReadingSeriesPage> {

  AppColors colors = AppColors();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        resizeToAvoidBottomInset: false,
        bottomNavigationBar: null,
        body: Padding(
          padding: const EdgeInsets.only(right: 12,left: 12),
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  const SizedBox(height: 12,),
                  PageHeaderTitle(
                      title: "Okuma Serin",
                      pathName: "assets/icons/time.png",
                      subtitle: "",
                      backButton: true
                  ).getTitle(context),
                  const SizedBox(height: 70)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}