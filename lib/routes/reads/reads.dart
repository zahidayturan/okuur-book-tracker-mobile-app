import 'package:flutter/material.dart';
import 'package:okuur/core/constants/colors.dart';
import 'package:okuur/data/services/operations/log_operations.dart';
import 'package:okuur/ui/components/page_header.dart';

class AllReadsPage extends StatefulWidget {
  const AllReadsPage({super.key});

  @override
  State<AllReadsPage> createState() => _AllReadsPageState();
}

class _AllReadsPageState extends State<AllReadsPage> {

  AppColors colors = AppColors();
  LogOperations logOperations = LogOperations();

  @override
  void initState() {
    DateTime date = DateTime(DateTime.now().year,DateTime.now().month);
    logOperations.getMonthlyLogInfo(date);
    super.initState();
  }

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
                      title: "Okumaların",
                      pathName: "assets/icons/reads.png",
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