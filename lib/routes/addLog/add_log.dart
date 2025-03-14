import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:okuur/controllers/add_log_controller.dart';
import 'package:okuur/core/constants/colors.dart';
import 'package:okuur/routes/addLog/components/add_log_app_bar.dart';
import 'package:okuur/routes/addLog/components/add_log_button.dart';
import 'package:okuur/routes/addLog/components/log_page_info.dart';
import 'package:okuur/routes/addLog/components/log_name_info.dart';
import 'package:okuur/routes/addLog/components/log_reading_date_info.dart';
import 'package:okuur/routes/addLog/components/log_reading_time_info.dart';
import 'package:okuur/routes/addLog/components/log_finishing_hour_info.dart';

class AddLogPage extends StatefulWidget {
  const AddLogPage({super.key});

  @override
  State<AddLogPage> createState() => _AddLogPageState();
}

class _AddLogPageState extends State<AddLogPage> {

  @override
  void initState() {
    super.initState();
    Get.put(AddLogController());
    AddLogController controller = Get.find();
    controller.clearAll();
    controller.checkAllValidate();
  }

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
                  addLogAppBar(context),
                  const SizedBox(height: 16,),
                  const LogNameInfo(),
                  const LogPageInfo(),
                  const LogReadingTimeInfo(),
                  const LogReadingDateInfo(),
                  const LogFinishingHourInfo(),
                  const SizedBox(height: 12,),
                  const AddLogButton(),
                  const SizedBox(height: 12,)
                ],),
            ),
          ),
        ),
      ),
    );
  }

}