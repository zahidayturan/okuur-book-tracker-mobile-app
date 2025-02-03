import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:okuur/controllers/home_controller.dart';
import 'package:okuur/core/constants/colors.dart';
import 'package:okuur/data/services/operations/log_operations.dart';
import 'package:okuur/routes/reads/components/reads_month_select.dart';
import 'package:okuur/routes/reads/components/reads_monthly_info.dart';
import 'package:okuur/routes/reads/components/reads_total_info.dart';
import 'package:okuur/ui/components/page_header.dart';
import 'package:okuur/ui/components/shimmer_box.dart';

class AllReadsPage extends StatefulWidget {
  const AllReadsPage({super.key});

  @override
  State<AllReadsPage> createState() => _AllReadsPageState();
}

class _AllReadsPageState extends State<AllReadsPage> {

  AppColors colors = AppColors();
  LogOperations logOperations = LogOperations();
  HomeController controller = Get.find();

  @override
  void initState() {
    controller.readsResetMonth();
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
                  const SizedBox(height: 12),
                  PageHeaderTitle(
                      title: "Okumaların",
                      pathName: "assets/icons/reads.png",
                      subtitle: "",
                      backButton: true
                  ).getTitle(context),
                  Obx(() => controller.readsLoading.value
                      ? const ShimmerBox(height: 52,borderRadius: BorderRadius.all(Radius.circular(8)))
                      : Column(
                        children: [
                          readsMonthSelect(),
                          const SizedBox(height: 12),
                          readsMonthlyInfo(controller.readsLogInfo,context),
                          const SizedBox(height: 12),
                          readsTotalInfo(context, controller.totalReadsInfo)
                        ],
                      )),
                  const SizedBox(height: 12,),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}